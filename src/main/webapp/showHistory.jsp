<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Connection conn = null;
  Statement stmt = null;
  ResultSet rs = null;
  String sql = "select * from history";
  %>
<html>
<head>
  <title>위치 히스토리 목록</title>
  <h1>위치 히스토리 목록</h1>
  <style>
    table, th, td {
      border: 1px solid gray;
      height: 40px;
      border-collapse: collapse;
    }
    table {
      border: 1px solid gray;
      width: 100%;
      border-collapse: collapse;
    }
  </style>
</head>
<body>
<a href="index.jsp">홈</a> |
<a href="showHistory.jsp">위치히스토리목록</a> |
<a href="InsertData.jsp" id="InsertData">Open API 와이파이 정보 가져오기</a><br><br>
<%
  try {
    Class.forName("org.sqlite.JDBC");
    String dbFile = "/Users/pheno/mydatabase;";
    conn = DriverManager.getConnection("jdbc:sqlite:" + dbFile);
    stmt = conn.createStatement();
    rs = stmt.executeQuery(sql);
    %>
<table id = "historyTable">
  <tr bgcolor="#32cd32" align="center">
    <th><font color = white>ID</font></th>
    <th><font color = white>X좌표</font></th>
    <th><font color = white>Y좌표</font></th>
    <th><font color = white>조회일자</font></th>
    <th><font color = white>비고</font></th>
  </tr>
    <%
    List<Map<String, String>> rows = new ArrayList<>();
    while (rs.next()) {
      Map<String, String> row = new HashMap<>();
      row.put("id", rs.getString("id"));
      row.put("x_coordinate", rs.getString("x_coordinate"));
      row.put("y_coordinate", rs.getString("y_coordinate"));
      row.put("timestamp", rs.getString("timestamp"));
      rows.add(row);
      }
    for (int i = rows.size() - 1; i >= 0; i--) {
      Map<String, String> row = rows.get(i);
		%>
  <tr>
    <td><%=row.get("id")%></td>
    <td><%=row.get("x_coordinate")%></td>
    <td><%=row.get("y_coordinate")%></td>
    <td><%=row.get("timestamp")%></td>
    <td style="text-align: center;">
      <button onclick="deleteData('<%= row.get("id") %>')">삭제</button>
    </td>
  </tr>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    function deleteData(id) {
      $.ajax({
        url: "deleteHistory.jsp",
        method: "POST",
        data: { id: id },
        success: function () {
          location.reload();
        },
        error: function () {
          alert("삭제 중 오류가 발생했습니다.");
        }
      });
    }
    var table = document.getElementById("historyTable");
    var rows = table.getElementsByTagName("tr");

    for (var i = 1; i < rows.length; i++) {
      if (i % 2 === 0) {
        rows[i].style.backgroundColor = "#f2f2f2";
      } else {
        rows[i].style.backgroundColor = "#ffffff";
      }
    }
  </script>
    <%
			}
		} catch (Exception e) {
		e.printStackTrace();
		} finally {
		try {
		if (rs != null) {
			rs.close();
		}
		if (stmt != null) {
			stmt.close();
		}
		if (conn != null) {
			conn.close();
		}
		} catch (Exception e) {
		e.printStackTrace();
		}
		}
		%>
</body>
</html>
