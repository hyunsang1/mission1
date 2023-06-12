<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection conn = null;
    Statement stmt = null;

    try {
        Class.forName("org.sqlite.JDBC");
        String dbFile = "/Users/pheno/mydatabase;";
        conn = DriverManager.getConnection("jdbc:sqlite:" + dbFile);
        stmt = conn.createStatement();

        String id = request.getParameter("id");

        String sql = "DELETE FROM history WHERE id = ?";
        String resetAutoIncrementSql = "DELETE FROM sqlite_sequence WHERE name = 'history'";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        int rowsDeleted = pstmt.executeUpdate();
        stmt.executeUpdate(resetAutoIncrementSql);

        if (rowsDeleted > 0) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }

        pstmt.close();
    } catch (Exception e) {
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        e.printStackTrace();
    } finally {
        try {
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