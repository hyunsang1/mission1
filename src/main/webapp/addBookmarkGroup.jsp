<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
    // 데이터베이스 연결 정보 설정
    Connection connection = null;
    PreparedStatement stmt = null;
    Date currentTime = new Date();
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String formattedTime = dateFormat.format(currentTime);
    try {
        // 사용자로부터 입력받은 북마크 이름과 순서 값을 가져옴
        String bookmarkName = request.getParameter("groupName");
        int bookmarkOrder = Integer.parseInt(request.getParameter("groupOrder"));

        // 데이터베이스 연결
        Class.forName("org.sqlite.JDBC");
        String dbFile = "/Users/pheno/mydatabase;";
        connection = DriverManager.getConnection("jdbc:sqlite:" + dbFile);

        // 북마크 그룹 추가 쿼리 작성
        String query = "INSERT INTO bookmark_group (북마크이름, 순서, 등록일자) VALUES (?, ?, ?)";
        stmt = connection.prepareStatement(query);

        // 쿼리에 파라미터 값 설정
        stmt.setString(1, bookmarkName);
        stmt.setInt(2, bookmarkOrder);
        stmt.setString(3, formattedTime);

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
%>