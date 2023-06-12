<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
    String latitudeStr = request.getParameter("latitude");
    String longitudeStr = request.getParameter("longitude");
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String currentDate = dateFormat.format(new Date());


    double latitude = 0.0;
    double longitude = 0.0;

    if (latitudeStr != null && !latitudeStr.isEmpty()) {
        latitude = Double.parseDouble(latitudeStr);
    }

    if (longitudeStr != null && !longitudeStr.isEmpty()) {
        longitude = Double.parseDouble(longitudeStr);
    }

    Connection conn = null;
    PreparedStatement pstmt = null;


    try {
        // 데이터베이스 연결
        Class.forName("org.sqlite.JDBC");
        String dbFile = "/Users/pheno/mydatabase;";
        conn = DriverManager.getConnection("jdbc:sqlite:" + dbFile);

        // 쿼리 작성 및 실행
        String query = "INSERT INTO history (x_coordinate, y_coordinate, timestamp) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, String.valueOf(latitude));
        pstmt.setString(2, String.valueOf(longitude));
        pstmt.setString(3, currentDate);
        pstmt.executeUpdate();
        pstmt.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>