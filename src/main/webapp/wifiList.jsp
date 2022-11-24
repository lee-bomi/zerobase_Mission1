<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.quest.mission1.db.WifiService" %>
<%@ page import="java.util.List" %>
<%@ page import="com.quest.mission1.entity.WifiList" %>
<%@ page import="com.quest.mission1.entity.History" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
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
            font-size: 10px;
        }

        #customers tr:nth-child(even){background-color: #f2f2f2;}

        #customers tr:hover {background-color: #ddd;}

        #customers th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: center;
            background-color: #04AA6D;
            color: white;
            font-size: 11px;
        }
    </style>

</head>
<body>
<h1>와이파이 정보 구하기</h1>
<a href="index.jsp">홈</a> | <a href="historyList.jsp" id="addMemo">위치 히스토리 목록</a> | <a href="" id="getWifiInfo">Open API 와이파이 정보 가져오기</a>
<br>
<br>

<%
    double latCur = Double.parseDouble(request.getParameter("lat"));
    double lntCur = Double.parseDouble(request.getParameter("lnt"));
    System.out.println("wifilist에서 새로입력한 좌표값 " + latCur + " / " + lntCur);
%>
<form action="">
    <label for="lat">LAT: <input type="text" id="lat" placeholder="0.0" value="<%= latCur%>" name="lat"></label> ,
    <label for="lnt">LNT: <input type="text" id="lnt" placeholder="0.0" value="<%= lntCur%>" name="lnt"></label>
    <input type="button" id="getLocation" value="내 위치 가져오기">
    <input  type="submit" value="근처 wifi정보보기" id="customLocation"> 이걸클릭하면 getlist로 가져와서 게산해서 보여주게한다
</form>
<table id="customers">
    <tr>
        <th>거리(Km)</th>
        <th>관리번호</th>
        <th>자치구</th>
        <th>와이파이명</th>
        <th>도로명주소</th>
        <th>상세주소</th>
        <th>설치위치(층)</th>
        <th>설치유형</th>
        <th>설치기관</th>
        <th>서비스구분</th>
        <th>망종류</th>
        <th>설치년도</th>
        <th>실내외구분</th>
        <th>WIFI접속환경</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>작업일자</th>
    </tr>

    <%
        WifiService wifiService = new WifiService();
        List<WifiList> lists = wifiService.getList();
        if (lists != null) {
            for (int i = 0; i < lists.size(); i++) {
    %>

    <tr>
        <td><%= String.format("%.4f", lists.get(i).getDISTANCE() * 100)%></td>
        <td><%= lists.get(i).getX_SWIFI_MGR_NO()%></td>
        <td><%= lists.get(i).getX_SWIFI_WRDOFC()%></td>
        <td><%= lists.get(i).getX_SWIFI_MAIN_NM()%></td>
        <td><%= lists.get(i).getX_SWIFI_ADRES1()%></td>
        <td><%= lists.get(i).getX_SWIFI_ADRES2()%></td>
        <td><%= lists.get(i).getX_SWIFI_INSTL_FLOOR()%></td>
        <td><%= lists.get(i).getX_SWIFI_INSTL_TY()%></td>
        <td><%= lists.get(i).getX_SWIFI_INSTL_MBY()%></td>
        <td><%= lists.get(i).getX_SWIFI_SVC_SE()%></td>
        <td><%= lists.get(i).getX_SWIFI_CMCWR()%></td>
        <td><%= lists.get(i).getX_SWIFI_CNSTC_YEAR()%></td>
        <td><%= lists.get(i).getX_SWIFI_INOUT_DOOR()%></td>
        <td><%= lists.get(i).getX_SWIFI_REMARS3()%></td>
        <td><%= lists.get(i).getLAT()%></td>
        <td><%= lists.get(i).getLNT()%></td>
        <td><%= lists.get(i).getWORK_DTTM()%></td>
    </tr>
    <%
            }
        }
        //history data insert
        LocalDateTime now = LocalDateTime.now();
        String formatNow = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS"));

        History history = new History(lntCur, latCur, formatNow);
        System.out.println("history 들어갔다개~~~ : " + history);
        wifiService.historyInsert(history);
    %>

</table>
<script type="text/javascript">

    let lnt = document.getElementById('lnt').value;
    let lat = document.getElementById('lat').value;

    function setHistory() {
        location.href = '/historyList.jsp?lnt=' + lnt + '&lat=' + lat;
    }
    document.querySelector('#addMemo').addEventListener('click', setHistory);

    function getNewData() {
        let value = document.getElementById('#lnt').value;
    }
    document.querySelector('#customLocation').addEventListener('click', getNewData);
</script>
</body>
</html>