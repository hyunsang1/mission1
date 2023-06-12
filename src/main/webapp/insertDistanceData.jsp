
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.zerobase_wifi.WifiDao" %>

<%
    String latitudeStr = request.getParameter("latitude");
    String longitudeStr = request.getParameter("longitude");
    double lat = Double.parseDouble(latitudeStr);
    double lan = Double.parseDouble(longitudeStr);
    WifiDao wifiDao = new WifiDao();
    wifiDao.getNearbyWifiList(lat,lan);

%>
