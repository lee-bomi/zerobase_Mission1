
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        #customers h2 {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: center;
            background-color: yellow;
        }
    </style>
</head>
<body>
<%
    int cnt = Integer.parseInt(request.getParameter("cnt"));
%>
<h2 style="text-align: center"><%= cnt %>개의 WIFI정보를 정상적으로 저장하였습니다</h2>
<p style="text-align: center"><a href="index.jsp" >홈으로 가기</a></p>

</body>
</html>
