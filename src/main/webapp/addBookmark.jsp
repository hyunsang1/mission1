
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
  // 데이터베이스 연결 정보 설정
  Connection connection = null;
  PreparedStatement stmt = null;

  try {
    String bookmarkName = request.getParameter("selectedValue");
    String wifiName = request.getParameter("wifiNameValue");
    Date currentTime = new Date();
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String formattedTime = dateFormat.format(currentTime);

    // 데이터베이스 연결
    Class.forName("org.sqlite.JDBC");
    String dbFile = "/Users/pheno/mydatabase;";
    connection = DriverManager.getConnection("jdbc:sqlite:" + dbFile);

    // 북마크 그룹 추가 쿼리 작성
    String query = "INSERT INTO bookmark (북마크이름, 와이파이명, 등록일자) VALUES (?, ?, ?)";
    stmt = connection.prepareStatement(query);

    stmt.setString(1, bookmarkName);
    stmt.setString(2, wifiName);
    stmt.setString(3, formattedTime);

    stmt.executeUpdate();

    // 북마크 그룹 추가 완료 메시지
  } catch (Exception e) {
    e.printStackTrace();
    System.out.println("Error: " + e.getMessage());
  } finally {
    // 리소스 해제
    if (stmt != null) stmt.close();
    if (connection != null) connection.close();
  }
%>