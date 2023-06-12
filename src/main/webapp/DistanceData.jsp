<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.zerobase_wifi.WifiDto" %>
<%@ page import="com.example.zerobase_wifi.WifiDao" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="com.google.gson.JsonObject" %>

<%
  WifiDao wifiDao = new WifiDao();
  List<WifiDto> wifiList = wifiDao.getNearbyWifiListWithDistanceSort();
  Gson gson = new Gson();

  JsonArray jsonArray = new JsonArray();
  for (WifiDto wifi : wifiList) {
    JsonObject jsonObj = new JsonObject();
    jsonObj.addProperty("거리", wifi.getDistance());
    jsonObj.addProperty("관리번호", wifi.getManagementNumber());
    jsonObj.addProperty("자치구", wifi.getBorough());
    jsonObj.addProperty("와이파이명", wifi.getWifiName());
    jsonObj.addProperty("도로명주소", wifi.getRoadAdr());
    jsonObj.addProperty("상세주소", wifi.getDetailAdr());
    jsonObj.addProperty("설치위치", wifi.getInsLocation());
    jsonObj.addProperty("설치유형", wifi.getInsType());
    jsonObj.addProperty("설치기관", wifi.getInsAgency());
    jsonObj.addProperty("서비스구분", wifi.getServiceDevision());
    jsonObj.addProperty("망종류", wifi.getNetCategory());
    jsonObj.addProperty("설치년도", wifi.getInsYear());
    jsonObj.addProperty("실내외구분", wifi.getInAndOut());
    jsonObj.addProperty("WIFI접속환경", wifi.getConEnviroment());
    jsonObj.addProperty("X좌표", wifi.getX_Coordinate());
    jsonObj.addProperty("Y좌표", wifi.getY_Coordinate());
    jsonObj.addProperty("작업일자", wifi.getWorkDate());
    jsonArray.add(jsonObj);
  }

  String json = gson.toJson(jsonArray);

  // JSON 데이터를 response에 설정
  response.setCharacterEncoding("UTF-8");
  response.setContentType("application/json");
  response.getWriter().write(json);
%>