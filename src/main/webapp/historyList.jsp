<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.quest.mission1.db.WifiService" %>
<%@ page import="java.util.List" %>
<%@ page import="com.quest.mission1.entity.History" %>

<!DOCTYPE html>
<html>
<head>
    <style>
        #customers {
            font-family: Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
            margin-top: 10px;
        }

        #customers td, #customers th {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
            font-size: 13px;
        }

        #customers tr:nth-child(even){background-color: #f2f2f2;}

        #customers tr:hover {background-color: #ddd;}

        #customers th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: center;
            background-color: #04AA6D;
            color: white;
            font-size: 13px;
        }
    </style>

</head>
<body>
<h1>위치 히스토리 목록</h1>
    <a href="index.jsp">홈</a> | <a href="historyList.jsp">위치 히스토리 목록</a> | <a href="indexTemp.jsp">Open API 와이파이 정보 가져오기</a>
<br>
<br>
<table id="customers">
    <tr>
        <th>ID</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>조회일자</th>
        <th>비고</th>
    </tr>
    <%
        WifiService wifiService = new WifiService();
        List<History> historyList = wifiService.getHistoryList();
        if (historyList != null) {
            for (int i = 0; i < historyList.size(); i++) {
    %>

    <tr>
        <td><%= historyList.get(i).getID() %></td>
        <td><%= historyList.get(i).getLNT() %></td>
        <td><%= historyList.get(i).getLAT() %></td>
        <td><%= historyList.get(i).getCURTIME() %></td>
        <td><button onclick="location.href = 'deleteAction.jsp?id=<%= historyList.get(i).getID() %>'">삭제</button></td>
    </tr>

    <%
            }
        }
    %>
</table>
<script type="text/javascript">
<%--    function deleteHistory() {--%>
<%--        let num = document.getElementById('#id').valueOf();--%>
<%--        <%--%>
<%--//            wifiService.deleteHistory(num);   // js => jsp로 어떻게 보내지--%>
<%--        %>--%>
<%--    }--%>
<%--    document.querySelector('#delBtn').addEventListener('click', deleteHistory());--%>
</script>
</body>
</html>