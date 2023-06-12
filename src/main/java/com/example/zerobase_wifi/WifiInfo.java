package com.example.zerobase_wifi;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class WifiInfo {
    public static long getTotalCount(){
        String result = " ";
        long total_count = 0;
        try {
            StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088"); /*URL*/
            urlBuilder.append("/" + URLEncoder.encode("4f4367655874796f34304f44646e71", "UTF-8")); /*인증키 (sample사용시에는 호출시 제한됩니다.)*/
            urlBuilder.append("/" + URLEncoder.encode("json", "UTF-8")); /*요청파일타입 (xml,xmlf,xls,json) */
            urlBuilder.append("/" + URLEncoder.encode("TbPublicWifiInfo", "UTF-8")); /*서비스명 (대소문자 구분 필수입니다.)*/
            urlBuilder.append("/" + URLEncoder.encode("1", "UTF-8")); /*요청시작위치 (sample인증키 사용시 5이내 숫자)*/
            urlBuilder.append("/" + URLEncoder.encode("1", "UTF-8")); /*요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨)*/

            URL url = new URL(urlBuilder.toString());

            BufferedReader rd = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
            result = rd.readLine();
            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObject = (JSONObject)jsonParser.parse(result);
            JSONObject TbPublicWifiInfo = (JSONObject)jsonObject.get("TbPublicWifiInfo");
            total_count = (long) TbPublicWifiInfo.get("list_total_count");
            rd.close();

        } catch (Exception e){
            e.printStackTrace();
        }
        return total_count;
    }
    public static List getWiFiInfo(){
        List<WifiDto> wifiDataList = new ArrayList<>();
        long MAX_CALL = 1000;
        long total_count = getTotalCount();

        for (long scnt = 1; scnt <= total_count; scnt += MAX_CALL) {
            long lcnt = scnt + MAX_CALL - 1;
            if (lcnt > total_count) {
                lcnt = total_count;
            }

            try {
                StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088");
                urlBuilder.append("/" + URLEncoder.encode("4f4367655874796f34304f44646e71", "UTF-8"));
                urlBuilder.append("/" + URLEncoder.encode("json", "UTF-8"));
                urlBuilder.append("/" + URLEncoder.encode("TbPublicWifiInfo", "UTF-8"));
                urlBuilder.append("/" + URLEncoder.encode(String.valueOf(scnt), "UTF-8"));
                urlBuilder.append("/" + URLEncoder.encode(String.valueOf(lcnt), "UTF-8"));

                URL url = new URL(urlBuilder.toString());
                BufferedReader rd = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

                StringBuilder sb = new StringBuilder();
                String result;
                while ((result = rd.readLine()) != null) {
                    sb.append(result);
                }

                rd.close();

                JSONParser jsonParser = new JSONParser();
                JSONObject jsonObject = (JSONObject) jsonParser.parse(sb.toString());
                JSONObject TbPublicWifiInfo = (JSONObject) jsonObject.get("TbPublicWifiInfo");
                JSONArray rows = (JSONArray) TbPublicWifiInfo.get("row");

                for (Object rowObj : rows) {
                    JSONObject row = (JSONObject) rowObj;
                    double distance = 0.0;
                    String managementNumber = (String) row.get("X_SWIFI_MGR_NO"); // 관리번호
                    String borough = (String) row.get("X_SWIFI_WRDOFC"); // 자치구
                    String wifiName = (String) row.get("X_SWIFI_MAIN_NM"); // 와이파이명
                    String roadAdr = (String) row.get("X_SWIFI_ADRES1"); // 도로명주소
                    String detailAdr = (String) row.get("X_SWIFI_ADRES2"); // 상세주소
                    String insLocation = (String) row.get("X_SWIFI_INSTL_FLOOR"); // 설치위치
                    String insType = (String) row.get("X_SWIFI_INSTL_TY"); // 설치유형
                    String insAgency = (String) row.get("X_SWIFI_INSTL_MBY"); // 설치기관
                    String serviceDevision = (String) row.get("X_SWIFI_SVC_SE"); // 서비스구분
                    String netCategory = (String) row.get("X_SWIFI_CMCWR"); // 망종류
                    int insYear = Integer.parseInt((String) row.get("X_SWIFI_CNSTC_YEAR")); // 설치년도
                    String inAndOut = (String) row.get("X_SWIFI_INOUT_DOOR"); // 실내외구분
                    String conEnviroment = (String) row.get("X_SWIFI_REMARS3"); // WIFI접속환경
                    double x_Coordinate = Double.parseDouble((String) row.get("LNT")); //X좌표
                    double y_Coordinate = Double.parseDouble((String) row.get("LAT")); //Y좌표
                    String workDate = (String) row.get("WORK_DTTM"); // 작업일자

                    WifiDto wifiDto = new WifiDto(distance, managementNumber, borough, wifiName, roadAdr, detailAdr, insLocation, insType,
                            insAgency, serviceDevision, netCategory, insYear, inAndOut, conEnviroment, x_Coordinate, y_Coordinate,
                            workDate);
                    wifiDataList.add(wifiDto);

                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return wifiDataList;
    }
//    public static void main(String[] args) {
//        WifiInfo wifiInfo = new WifiInfo();
//        List<WifiDto> wifiDataList = wifiInfo.getWiFiInfo();
//
//        WifiDao wifiDao = new WifiDao();
//        for (WifiDto wifiDto : wifiDataList) {
//            wifiDao.insertData(wifiDto);
//        }
//
//    }
}
