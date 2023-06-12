
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    // 데이터베이스 연결 정보 설정
    Connection connection = null;
    PreparedStatement stmt = null;
    int id = Integer.parseInt(request.getParameter("id"));

    try {

        // 데이터베이스 연결
        Class.forName("org.sqlite.JDBC");
        String dbFile = "/Users/pheno/mydatabase;";
        connection = DriverManager.getConnection("jdbc:sqlite:" + dbFile);

        // 북마크 그룹 추가 쿼리 작성
        String query = "DELETE FROM bookmark_group WHERE ID = ?";
        stmt = connection.prepareStatement(query);
        stmt.setInt(1, id);

        // 쿼리 실행
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
    response.sendRedirect("bookmark-group.jsp");
%>
