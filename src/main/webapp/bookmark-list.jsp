<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <h1>북마크 목록</h1>
    <style>
        #bookmarkList {
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
        tr:nth-child(even) td {
            background-color: white;
        }
        tr:nth-child(odd) td {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<a href="index.jsp">홈</a> |
<a href="showHistory.jsp">위치히스토리목록</a> |
<a href="InsertData.jsp" id="InsertData">Open API 와이파이 정보 가져오기</a> |
<a href="bookmark-list.jsp">북마크 보기</a> |
<a href="bookmark-group.jsp">북마크 그룹 관리</a><br><br>
<table id = bookmarkList>
    <tr bgcolor="#32cd32" align="center" aria-colspan="1">
        <th class="tg"><font color = white>ID</font></th>
        <th class="tg"><font color = white>북마크 이름</font></th>
        <th class="tg"><font color = white>와이파이명</font></th>
        <th class="tg"><font color = white>등록일자</font></th>
        <th class="tg"><font color = white>비고</font></th>
    </tr>
    <%
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {

            Class.forName("org.sqlite.JDBC");
            String dbFile = "/Users/pheno/mydatabase;";
            connection = DriverManager.getConnection("jdbc:sqlite:" + dbFile);

            String query = "SELECT * FROM bookmark";
            statement = connection.createStatement();
            resultSet = statement.executeQuery(query);


            while (resultSet.next()) {
                int id = resultSet.getInt("ID");
                String bookmarkName = resultSet.getString("북마크이름");
                String bookwifiName = resultSet.getString("와이파이명");
                String createDate = resultSet.getString("등록일자");
    %>
    <tr>
        <td><%= id %></td>
        <td><%= bookmarkName %></td>
        <td><%= bookwifiName %></td>
        <td><%= createDate %></td>
        <td><a href="bookmark-delete.jsp?bookmarkName=<%=bookmarkName%>&wifiName=<%=bookwifiName%>&createDate=<%=createDate%>&id=<%=id%>">삭제</a></td>
    </tr>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 리소스 해제
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
    %>
</table>
</body>
</html>
