
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>와이파이 정보 구하기</title>
    <h1>북마크 그룹 수정</h1>
    <style>
        #bookmarkedit {
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
            width: 150px;
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
            $('#editButton').click(function() {
                var groupName = $('input[name="groupName"]').val();
                var groupOrder = $('input[name="groupOrder"]').val();
                var id = <%= request.getParameter("id") %>;

                // AJAX를 사용하여 서버로 북마크 그룹 추가 요청을 전송
                $.ajax({
                    type: "POST",
                    url: "editBookmarkGroup.jsp",
                    data: {
                        groupName: groupName,
                        groupOrder: groupOrder,
                        id : id
                    },
                    success: function() {
                        // 요청이 성공적으로 처리되면 페이지를 새로고침하여 변경된 내용을 표시
                        alert("데이터 수정 성공")
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
<table id = "bookmarkedit">
    <tbody>
    <tr>
        <th>북마크 이름</th>
        <td><input type="text" name="groupName" /></td>
    </tr>
    <tr>
        <th>순서</th>
        <td><input type="number" name="groupOrder" /></td>
    </tr>
    <tr>
        <td colspan="2" align="center"><a href="bookmark-group.jsp">돌아가기</a> | <button id="editButton">수정</button></td>
    </tr>
    </tbody>
</table>
</body>
</html>
