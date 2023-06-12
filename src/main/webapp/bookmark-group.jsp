
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>와이파이 정보 구하기</title>
    <h1>북마크 그룹</h1>
    <style>
        #groupTable {
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
            background-color: white; /* 짝수 번째 줄의 배경색 */
        }
        tr:nth-child(odd) td {
            background-color: #f2f2f2; /* 홀수 번째 줄의 배경색 */
        }
    </style>
</head>
<body>
<a href="index.jsp">홈</a> |
<a href="showHistory.jsp">위치히스토리목록</a> |
<a href="InsertData.jsp" id="InsertData">Open API 와이파이 정보 가져오기</a> |
<a href="bookmark-list.jsp">북마크 보기</a> |
<a href="bookmark-group.jsp">북마크 그룹 관리</a><br><br>
<button onclick="location.href='bookmark-group-add.jsp'">북마크 그룹 이름 추가</button>

<table id="groupTable">
    <tr bgcolor="#32cd32" align="center" aria-colspan="1">
        <th class="tg"><font color = white>ID</font></th>
        <th class="tg"><font color = white>북마크 이름</font></th>
        <th class="tg"><font color = white>순서</font></th>
        <th class="tg"><font color = white>등록일자</font></th>
        <th class="tg"><font color = white>수정일자</font></th>
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

            String query = "SELECT * FROM bookmark_group";
            statement = connection.createStatement();
            resultSet = statement.executeQuery(query);


            while (resultSet.next()) {
                int id = resultSet.getInt("ID");
                String groupName = resultSet.getString("북마크이름");
                int groupOrder = resultSet.getInt("순서");
                String createDate = resultSet.getString("등록일자");
                String modifyDate = resultSet.getString("수정일자");
                if (modifyDate == null) {
                    modifyDate = "";
                }
    %>
    <tr>
        <td><%= id %></td>
        <td><%= groupName %></td>
        <td><%= groupOrder %></td>
        <td><%= createDate %></td>
        <td><%= modifyDate %></td>
        <td><a href="bookmark-group-edit.jsp?id=<%= id %>">수정</a> <a href="deleteBookmarkGroup.jsp?id=<%= id %>">삭제</a> </td>
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
