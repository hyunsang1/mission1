package com.example.zerobase_wifi;

public class WifiDto {

    private double distance; // 거리
    private String managementNumber; // 관리번호
    private String borough; // 자치구
    private String wifiName; // 와이파이명
    private String roadAdr; // 도로명주소
    private String detailAdr; // 상세주소
    private String insLocation; // 설치위치
    private String insType; // 설치유형
    private String insAgency; // 설치기관
    private String serviceDevision; // 서비스구분
    private String netCategory; // 망종류
    private int insYear; // 설치년도
    private String inAndOut; // 실내외구분
    private String conEnviroment; // WIFI접속환경
    private double x_Coordinate; //X좌표
    private double y_Coordinate; //Y좌표
    private String workDate; // 작업일자

    // 생성자
    public WifiDto(double distance, String managementNumber, String borough, String wifiName, String roadAdr, String detailAdr, String insLocation, String insType, String insAgency, String serviceDevision, String netCategory, int insYear, String inAndOut, String conEnviroment, double x_Coordinate, double y_Coordinate, String workDate) {
        this.distance = distance;
        this.managementNumber = managementNumber;
        this.borough = borough;
        this.wifiName = wifiName;
        this.roadAdr = roadAdr;
        this.detailAdr = detailAdr;
        this.insLocation = insLocation;
        this.insType = insType;
        this.insAgency = insAgency;
        this.serviceDevision = serviceDevision;
        this.netCategory = netCategory;
        this.insYear = insYear;
        this.inAndOut = inAndOut;
        this.conEnviroment = conEnviroment;
        this.x_Coordinate = x_Coordinate;
        this.y_Coordinate = y_Coordinate;
        this.workDate = workDate;
    }

    public WifiDto() {

    }

    //getter and setter
    public double getDistance() { return distance; }
    public void setDistance(double distance) { this.distance = distance; }
    public String getManagementNumber() {
        return managementNumber;
    }

    public void setManagementNumber(String managementNumber) {
        this.managementNumber = managementNumber;
    }

    public String getBorough() {
        return borough;
    }

    public void setBorough(String borough) {
        this.borough = borough;
    }

    public String getWifiName() {
        return wifiName;
    }

    public void setWifiName(String wifiName) {
        this.wifiName = wifiName;
    }

    public String getRoadAdr() {
        return roadAdr;
    }

    public void setRoadAdr(String roadAdr) {
        this.roadAdr = roadAdr;
    }

    public String getDetailAdr() {
        return detailAdr;
    }

    public void setDetailAdr(String detailAdr) {
        this.detailAdr = detailAdr;
    }

    public String getInsLocation() {
        return insLocation;
    }

    public void setInsLocation(String insLocation) {
        this.insLocation = insLocation;
    }

    public String getInsType() {
        return insType;
    }

    public void setInsType(String insType) {
        this.insType = insType;
    }

    public String getInsAgency() {
        return insAgency;
    }

    public void setInsAgency(String insAgency) {
        this.insAgency = insAgency;
    }

    public String getServiceDevision() {
        return serviceDevision;
    }

    public void setServiceDevision(String serviceDevision) {
        this.serviceDevision = serviceDevision;
    }

    public String getNetCategory() {
        return netCategory;
    }

    public void setNetCategory(String netCategory) {
        this.netCategory = netCategory;
    }

    public int getInsYear() {
        return insYear;
    }

    public void setInsYear(int insYear) {
        this.insYear = insYear;
    }

    public String getInAndOut() {
        return inAndOut;
    }

    public void setInAndOut(String inAndOut) {
        this.inAndOut = inAndOut;
    }

    public String getConEnviroment() {
        return conEnviroment;
    }

    public void setConEnviroment(String conEnviroment) {
        this.conEnviroment = conEnviroment;
    }

    public double getX_Coordinate() {
        return x_Coordinate;
    }

    public void setX_Coordinate(double x_Coordinate) {
        this.x_Coordinate = x_Coordinate;
    }

    public double getY_Coordinate() {
        return y_Coordinate;
    }

    public void setY_Coordinate(double y_Coordinate) {
        this.y_Coordinate = y_Coordinate;
    }

    public String getWorkDate() {
        return workDate;
    }

    public void setWorkDate(String workDate) {
        this.workDate = workDate;
    }
}

