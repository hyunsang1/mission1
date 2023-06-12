<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <h1>와이파이 정보 구하기</h1>

    <style>
        #wifiTable {
            margin-top: 1em;
        }
        table, th, td {
            border: 1px solid gray;
            height: 50px;
            border-collapse: collapse;
        }
        table {
            border: 1px solid gray;
            width: 100%;
            border-collapse: collapse;
        }
    </style>
    <script>
        function getLocationAndSave() { //내 위치 가져오기
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    var latitude = position.coords.latitude;
                    var longitude = position.coords.longitude;
                    document.getElementById("latitude").value = latitude;
                    document.getElementById("longitude").value = longitude;
                    saveHistory(latitude, longitude);
                    insertDistance();
                });
            } else {
                alert("Geolocation is not supported by this browser.");
            }
        }

        function saveHistory(latitude, longitude) {
            $.ajax({
                url: "saveHistory.jsp",
                type: "POST",
                data: {
                    latitude: latitude,
                    longitude: longitude
                },
                success: function(response) {
                    console.log("History saved successfully!");
                },
                error: function(xhr, status, error) {
                    console.error("An error occurred while saving history: " + error);
                }
            });
        }

        function showPosition(position) {
            var latitude = position.coords.latitude;
            var longitude = position.coords.longitude;
            document.getElementById("latitude").value = latitude;
            document.getElementById("longitude").value = longitude;
        }

        function insertDistance() {
            var latitude = document.getElementById("latitude").value;
            var longitude = document.getElementById("longitude").value;
            $.ajax({
                url: "insertDistanceData.jsp",
                type: "POST",
                data: {
                    latitude: latitude,
                    longitude: longitude
                },
                success: function(response) {
                    console.log("Distance saved successfully!");
                },
                error: function(xhr, status, error) {
                    alert("An error occurred while fetching data: " + error);
                }
            });
        }
        function populateTable() {
            $.ajax({
                url: "DistanceData.jsp",
                type: "GET",
                success: function(json) {
                    var data = json;
                    var tableBody = $("#wifiTableBody");
                    tableBody.empty();

                    for (var i = 0; i < data.length; i++) {
                        var row = $("<tr>");
                        row.css("background-color", i % 2 === 0 ? "#FFFFFF" : "#F0F0F0");
                        var distance = encodeURIComponent(data[i].거리);
                        var mnumber = encodeURIComponent(data[i].관리번호)
                        var brough = encodeURIComponent(data[i].자치구);
                        var wifiName = encodeURIComponent(data[i].와이파이명);
                        var roadArr = encodeURIComponent(data[i].도로명주소);
                        var detailArr = encodeURIComponent(data[i].상세주소);
                        var insLoca = encodeURIComponent(data[i].설치위치);
                        var insType = encodeURIComponent(data[i].설치유형);
                        var insAgency = encodeURIComponent(data[i].설치기관);
                        var service = encodeURIComponent(data[i].서비스구분);
                        var net = encodeURIComponent(data[i].망종류);
                        var insYear = encodeURIComponent(data[i].설치년도);
                        var inAndOut = encodeURIComponent(data[i].실내외구분);
                        var wifiCon = encodeURIComponent(data[i].WIFI접속환경);
                        var coorX = encodeURIComponent(data[i].X좌표);
                        var coorY = encodeURIComponent(data[i].Y좌표);
                        var workDate = encodeURIComponent(data[i].작업일자);

                        row.append($("<td>").text(data[i].거리));
                        row.append($("<td>").text(data[i].관리번호));
                        row.append($("<td>").text(data[i].자치구));
                        var wifiNameLink = $("<a>").attr("href", "showDetail.jsp?mNumber=" + mnumber + "&distance=" + distance
                            + "&brough=" + brough + "&wifiName=" + wifiName + "&roadArr=" + roadArr + "&detailArr=" + detailArr
                            + "&insLoca=" + insLoca + "&insType=" + insType + "&insAgency=" + insAgency + "&service=" + service
                            + "&net=" + net + "&insYear=" + insYear + "&inAndOut=" + inAndOut + "&wifiCon=" + wifiCon
                            + "&coorX=" + coorX + "&coorY=" + coorY + "&workDate=" + workDate).text(data[i].와이파이명);
                        row.append($("<td>").append(wifiNameLink));
                        row.append($("<td>").text(data[i].도로명주소));
                        row.append($("<td>").text(data[i].상세주소));
                        row.append($("<td>").text(data[i].설치위치));
                        row.append($("<td>").text(data[i].설치유형));
                        row.append($("<td>").text(data[i].설치기관));
                        row.append($("<td>").text(data[i].서비스구분));
                        row.append($("<td>").text(data[i].망종류));
                        row.append($("<td>").text(data[i].설치년도));
                        row.append($("<td>").text(data[i].실내외구분));
                        row.append($("<td>").text(data[i].WIFI접속환경));
                        row.append($("<td>").text(data[i].X좌표));
                        row.append($("<td>").text(data[i].Y좌표));
                        row.append($("<td>").text(data[i].작업일자));

                        tableBody.append(row);
                    }
                    },
                error: function(xhr, status, error) {
                    alert("An error occurred while fetching data: " + error);
                }
            });
        }
    </script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $("#InsertData").click(function(e) {
                e.preventDefault();
                $.ajax({
                    url: "InsertData.jsp",
                    type: "GET",
                    success: function(response) {

                        alert("데이터 불러오기 성공");
                        window.location.href = "result.jsp?count=" + response;
                    },
                    error: function(xhr, status, error) {
                        alert("An error occurred while fetching data: " + error);
                    }
                });
            });
        });
    </script>

</head>
<body>

<a href="index.jsp">홈</a> |
<a href="showHistory.jsp">위치히스토리목록</a> |
<a href="InsertData.jsp" id="InsertData">Open API 와이파이 정보 가져오기</a> |
<a href="bookmark-list.jsp">북마크 보기</a> |
<a href="bookmark-group.jsp">북마크 그룹 관리</a><br><br>
<label for="latitude">LAT:</label>
<input type="text" value="0.0" id="latitude" name="latitude" readonly>,
<label for="longitude">LNT:</label>
<input type="text" value="0.0" id="longitude" name="longitude" readonly>
<button onclick="getLocationAndSave()">내 위치 가져오기</button>
<button onclick="populateTable()">근처 WIFI 정보 보기</button>

<table id="wifiTable">
    <tr bgcolor="#32cd32" align="center" aria-colspan="1">
        <th class="tg"><font color = white>거리(km)</font></th>
        <th class="tg"><font color = white>관리번호</font></th>
        <th class="tg"><font color = white>자치구</font></th>
        <th class="tg"><font color = white>와이파이명</font></th>
        <th class="tg"><font color = white>도로명주소</font></th>
        <th class="tg"><font color = white>상세주소</font></th>
        <th class="tg"><font color = white>설치위치(층)</font></th>
        <th class="tg"><font color = white>설치유형</font></th>
        <th class="tg"><font color = white>설치기관</font></th>
        <th class="tg"><font color = white>서비스구분</font></th>
        <th class="tg"><font color = white>망종류</font></th>
        <th class="tg"><font color = white>설치년도</font></th>
        <th class="tg"><font color = white>실내외구분</font></th>
        <th class="tg"><font color = white>WIFI접속환경</font></th>
        <th class="tg"><font color = white>X좌표</font></th>
        <th class="tg"><font color = white>Y좌표</font></th>
        <th class="tg"><font color = white>작업일자</font></th>
    </tr>
    <tbody id="wifiTableBody">
        <td class = "tg" colspan="17" style="text-align: center;" >위치 정보를 입력한 후에 조회해 주세요.</td>
    </tbody>
</table>

</body>
</html>
