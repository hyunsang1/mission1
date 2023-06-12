<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String mNumber = request.getParameter("mNumber");
    String distance = request.getParameter("distance");
    String brough = request.getParameter("brough");
    String wifiName = request.getParameter("wifiName");
    String roadArr = request.getParameter("roadArr");
    String detailArr = request.getParameter("detailArr");
    String insLoca = request.getParameter("insLoca");
    String insType = request.getParameter("insType");
    String insAgency = request.getParameter("insAgency");
    String service = request.getParameter("service");
    String net = request.getParameter("net");
    String insYear = request.getParameter("insYear");
    String inAndOut = request.getParameter("inAndOut");
    String wifiCon = request.getParameter("wifiCon");
    String coorX = request.getParameter("coorX");
    String coorY = request.getParameter("coorY");
    String workDate = request.getParameter("workDate");

    // 데이터베이스 연결 정보 설정
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        // 데이터베이스 연결
        Class.forName("org.sqlite.JDBC");
        String dbFile = "/Users/pheno/mydatabase;";
        connection = DriverManager.getConnection("jdbc:sqlite:" + dbFile);

        // 북마크 그룹 조회 쿼리
        String query = "SELECT * FROM bookmark_group";
        statement = connection.createStatement();
        resultSet = statement.executeQuery(query);

%>
<html>
<head>
    <title>와이파이 상세정보</title>
    <h1>와이파이 상세정보</h1>
    <style>
        #detailtable {
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
        th {
            background-color: #32cd32;
            color: white;
            width: 300px;
        }
        tr:nth-child(even) td {
            background-color: #f2f2f2;
        }
        tr:nth-child(odd) td {
            background-color: white;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#addButton').click(function() {
                var selectedValue = $('#book-mark').val();
                var wifiNameValue = '<%= wifiName %>';
                // AJAX를 사용하여 서버로 북마크 그룹 추가 요청을 전송
                $.ajax({
                    type: "POST",
                    url: "addBookmark.jsp",
                    data: {
                        selectedValue : selectedValue,
                        wifiNameValue : wifiNameValue
                    },
                    success: function() {

                        alert("데이터 추가 성공")
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
<select name="bookmarks" id="book-mark">
    <option value="">북마크 그룹 관리</option>
    <% while (resultSet.next()) { %>
    <option value="<%= resultSet.getString("북마크이름") %>"><%= resultSet.getString("북마크이름") %></option>
    <% } %>
</select>
<button id="addButton">북마크 추가하기</button>
<table id="detailtable">
    <tbody>
    <tr>
        <th class="tg">거리(km)</th>
        <td><%= distance %></td>
    </tr>
    <tr>
        <th class="tg">관리번호</th>
        <td><%= mNumber %></td>
    </tr>
    <tr>
        <th class="tg">자치구</th>
        <td><%= brough %></td>
    </tr>
    <tr>
        <th class="tg">와이파이명</th>
        <td><%= wifiName %></td>
    </tr>
    <tr>
        <th class="tg">도로명주소</th>
        <td><%= roadArr %></td>
    </tr>
    <tr>
        <th class="tg">상세주소</th>
        <td><%= detailArr %></td>
    </tr>
    <tr>
        <th class="tg">설치위치</th>
        <td><%= insLoca %></td>
    </tr>
    <tr>
        <th class="tg">설치유형</th>
        <td><%= insType %></td>
    </tr>
    <tr>
        <th class="tg">설치기관</th>
        <td><%= insAgency %></td>
    </tr>
    <tr>
        <th class="tg">서비스구분</th>
        <td><%= service %></td>
    </tr>
    <tr>
        <th class="tg">망종류</th>
        <td><%= net %></td>
    </tr>
    <tr>
        <th class="tg">설치년도</th>
        <td><%= insYear %></td>
    </tr>
    <tr>
        <th class="tg">실내외구분</th>
        <td><%= inAndOut %></td>
    </tr>
    <tr>
        <th class="tg">WIFI접속환경</th>
        <td><%= wifiCon %></td>
    </tr>
    <tr>
        <th class="tg">X좌표</th>
        <td><%= coorX %></td>
    </tr>
    <tr>
        <th class="tg">Y좌표</th>
        <td><%= coorY %></td>
    </tr>
    <tr>
        <th class="tg">작업일자</th>
        <td><%= workDate %></td>
    </tr>

    </tbody>
</table>

</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 리소스 해제
        if (resultSet != null) resultSet.close();
        if (statement != null) statement.close();
        if (connection != null) connection.close();
    }
%>
