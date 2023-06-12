package com.example.zerobase_wifi;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.*;
import java.sql.ResultSet;

public class WifiDao {
    private Connection conn = null;

    public WifiDao() {
        try {
            Class.forName("org.sqlite.JDBC");
            String dbFile = "/Users/pheno/mydatabase;";
            conn = DriverManager.getConnection("jdbc:sqlite:" + dbFile);

            createTable();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void createTable() {
        try {
            String query = "CREATE TABLE IF NOT EXISTS wifi_data (" +
                    "거리 REAL," +
                    "관리번호 TEXT," +
                    "자치구 TEXT," +
                    "와이파이명 TEXT," +
                    "도로명주소 TEXT," +
                    "상세주소 TEXT," +
                    "설치위치 TEXT," +
                    "설치유형 TEXT," +
                    "설치기관 TEXT," +
                    "서비스구분 TEXT," +
                    "망종류 TEXT," +
                    "설치년도 INTEGER," +
                    "실내외구분 TEXT," +
                    "WIFI접속환경 TEXT," +
                    "X좌표 REAL," +
                    "Y좌표 REAL," +
                    "작업일자 TEXT" +
                    ")";

            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.execute();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void insertData(WifiDto wifiDto) {
        try {
            String query = "INSERT INTO wifi_data (관리번호, 자치구, 와이파이명, 도로명주소, 상세주소, 설치위치, 설치유형, " +
                    "설치기관, 서비스구분, 망종류, 설치년도, 실내외구분, WIFI접속환경, X좌표, Y좌표, 작업일자) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, wifiDto.getManagementNumber());
            pstmt.setString(2, wifiDto.getBorough());
            pstmt.setString(3, wifiDto.getWifiName());
            pstmt.setString(4, wifiDto.getRoadAdr());
            pstmt.setString(5, wifiDto.getDetailAdr());
            pstmt.setString(6, wifiDto.getInsLocation());
            pstmt.setString(7, wifiDto.getInsType());
            pstmt.setString(8, wifiDto.getInsAgency());
            pstmt.setString(9, wifiDto.getServiceDevision());
            pstmt.setString(10, wifiDto.getNetCategory());
            pstmt.setInt(11, wifiDto.getInsYear());
            pstmt.setString(12, wifiDto.getInAndOut());
            pstmt.setString(13, wifiDto.getConEnviroment());
            pstmt.setDouble(14, wifiDto.getX_Coordinate());
            pstmt.setDouble(15, wifiDto.getY_Coordinate());
            pstmt.setString(16, wifiDto.getWorkDate());
            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteAllData() {
        try {
            String query = "DELETE FROM wifi_data";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<WifiDto> getCoordinateData() {

        List<WifiDto> wifiList = new ArrayList<>();

        try {
            //String query = "SELECT * FROM wifi_data";
            String query = "SELECT 관리번호, X좌표, Y좌표 FROM wifi_data";
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                WifiDto wifiDto = new WifiDto();
                wifiDto.setManagementNumber(rs.getString("관리번호"));
                wifiDto.setX_Coordinate(rs.getDouble("X좌표"));
                wifiDto.setY_Coordinate(rs.getDouble("Y좌표"));
                wifiList.add(wifiDto);
            }

            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return wifiList;
    }
    public double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        double R = 6371;

        double lat1_rad = Math.toRadians(lat1);
        double lon1_rad = Math.toRadians(lon1);
        double lat2_rad = Math.toRadians(lat2);
        double lon2_rad = Math.toRadians(lon2);

        double delta_lat = lat2_rad - lat1_rad;
        double delta_lon = lon2_rad - lon1_rad;

        double a = Math.sin(delta_lat / 2) * Math.sin(delta_lat / 2) +
                Math.cos(lat1_rad) * Math.cos(lat2_rad) *
                        Math.sin(delta_lon / 2) * Math.sin(delta_lon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        double distance = R * c;

        return distance;
    }
    public List<WifiDto> getNearbyWifiList(double latitude, double longitude) {
        List<WifiDto> wifiList;
        List<WifiDto> nearbyWifiList = new ArrayList<>();

        wifiList = getCoordinateData();

        for (WifiDto wifiDto : wifiList) {
            double distance = calculateDistance(latitude, longitude, wifiDto.getX_Coordinate(), wifiDto.getY_Coordinate());
            wifiDto.setDistance(distance);
        }

        Collections.sort(wifiList, new Comparator<WifiDto>() {
            @Override
            public int compare(WifiDto wifi1, WifiDto wifi2) {
                return Double.compare(wifi1.getDistance(), wifi2.getDistance());
            }
        });

        for (int i = 0; i < 20 && i < wifiList.size(); i++) {
            WifiDto wifiDto = wifiList.get(i);
            nearbyWifiList.add(wifiDto);
            updateDistanceInDatabase(wifiDto);
        }
        return wifiList;
    }
    public List<WifiDto> getNearbyWifiListWithDistanceSort() {

        List<WifiDto> wifiList = new ArrayList<>();

        try {
            // SQL 쿼리 작성
            String sql = "SELECT * FROM wifi_data WHERE 거리 IS NOT NULL ORDER BY 거리 ASC LIMIT 20";

            // PreparedStatement 생성
            PreparedStatement pstmt = conn.prepareStatement(sql);

            // SQL 쿼리 실행
            ResultSet rs = pstmt.executeQuery();

            // 결과 처리
            while (rs.next()) {
                WifiDto wifi = new WifiDto();
                wifi.setDistance((rs.getDouble("거리")));
                wifi.setManagementNumber(rs.getString("관리번호"));
                wifi.setBorough(rs.getString("자치구"));
                wifi.setWifiName(rs.getString("와이파이명"));
                wifi.setRoadAdr(rs.getString("도로명주소"));
                wifi.setDetailAdr(rs.getString("상세주소"));
                wifi.setInsLocation(rs.getString("설치위치"));
                wifi.setInsType(rs.getString("설치유형"));
                wifi.setInsAgency(rs.getString("설치기관"));
                wifi.setServiceDevision(rs.getString("서비스구분"));
                wifi.setNetCategory(rs.getString("망종류"));
                wifi.setInsYear(rs.getInt("설치년도"));
                wifi.setInAndOut(rs.getString("실내외구분"));
                wifi.setConEnviroment(rs.getString("WIFI접속환경"));
                wifi.setX_Coordinate(rs.getDouble("X좌표"));
                wifi.setY_Coordinate(rs.getDouble("Y좌표"));
                wifi.setWorkDate(rs.getString("작업일자"));
                wifiList.add(wifi);
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return wifiList;
    }

    public void close() {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void updateDistanceInDatabase(WifiDto wifiDto) {
        try {
            String query = "UPDATE wifi_data SET 거리 = ? WHERE 관리번호 = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setDouble(1, wifiDto.getDistance());
            pstmt.setString(2, wifiDto.getManagementNumber());
            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        WifiDao wifiDao = new WifiDao();

    }
}
