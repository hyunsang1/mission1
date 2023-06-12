
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String bookmarkName = request.getParameter("bookmarkName");
    String wifiName = request.getParameter("wifiName");
    String createDate = request.getParameter("createDate");
    int id = Integer.parseInt(request.getParameter("id"));
%>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <h1>북마크 삭제</h1>
    <style>
        #deletTable {
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
            background-color: #32cd32; /* 초록색 배경 */
            color: white; /* 글자 색상 */
            width: 300px;
        }
        tr:nth-child(even) td {
            background-color: #f2f2f2; /* 짝수 번째 줄의 배경색 */
        }
        tr:nth-child(odd) td {
            background-color: white; /* 홀수 번째 줄의 배경색 */
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#deleteButton').click(function() {
                var id = <%=id%>;

                // AJAX를 사용하여 서버로 북마크 그룹 추가 요청을 전송
                $.ajax({
                    type: "POST",
                    url: "deleteBookmark.jsp",
                    data: {
                        id : id
                    },
                    success: function() {
                        // 요청이 성공적으로 처리되면 페이지를 새로고침하여 변경된 내용을 표시
                        alert("데이터 삭제 성공")
                        location.href='bookmark-list.jsp';
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
<p>북마크를 삭제하시겠습니까?</p>
<table id="deletTable">
    <tbody>
    <tr>
        <th class="tg">북마크 이름</th>
        <td><%=bookmarkName%></td>
    </tr>
    <tr>
        <th class="tg">와이파이명</th>
        <td><%=wifiName%></td>
    </tr>
    <tr>
        <th class="tg">등록일자</th>
        <td><%=createDate%></td>
    </tr>
    <tr>
        <td colspan="2" align="center"><a href="bookmark-list.jsp">돌아가기</a> | <button id="deleteButton">삭제</button></td>
    </tr>
    </tbody>
</table>
</body>
</html>
