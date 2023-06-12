<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.zerobase_wifi.WifiInfo" %>
<%@ page import="com.example.zerobase_wifi.WifiDto" %>
<%@ page import="com.example.zerobase_wifi.WifiDao" %>
<%@ page import="org.json.simple.parser.JSONParser" %>

<%
    try {
        // WifiInfo 클래스를 사용하여 와이파이 정보 가져오기
        WifiInfo wifiInfo = new WifiInfo();
        List<WifiDto> wifiDataList = wifiInfo.getWiFiInfo();

        // WifiDao 클래스를 사용하여 데이터베이스에 저장
        WifiDao wifiDao = new WifiDao();
        wifiDao.deleteAllData();
        for (WifiDto wifiDto : wifiDataList) {
            wifiDao.insertData(wifiDto);
        }

        wifiDao.close();
        int count = wifiDataList.size();
        response.getWriter().write(String.valueOf(count));

    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }

%>
