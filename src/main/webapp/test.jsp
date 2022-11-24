<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.quest.mission1.db.WifiService" %>
<%@ page import="com.quest.mission1.entity.WifiInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
    Float latCur = Float.parseFloat(request.getParameter("lat"));
    Float lntCur = Float.parseFloat(request.getParameter("lnt"));
    System.out.println(latCur + " : " + lntCur);
%>
<form action="wifiList.jsp">
    <label for="lat">LAT: <input type="text" id="lat" placeholder="0.0" value="<%= latCur%>" name="lat"></label> ,
    <label for="lnt">LNT: <input type="text" id="lnt" placeholder="0.0" value="<%= lntCur%>" name="lnt"></label>
    <input type="button" id="getLocation" value="내 위치 가져오기">
    <input  type="submit" value="근처 wifi정보보기">
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
        List<WifiInfo> infolist = wifiService.getList();
        List<WifiList> list = new ArrayList<>();
        float distance = 0f;
        if (infolist != null) {
            for (int i = 0; i < infolist.size(); i++) {
                WifiList wifiList = new WifiList();
                String latVal = infolist.get(i).getLAT();
                String lntVal = infolist.get(i).getLAT();

                float x = latCur - Float.parseFloat(latVal);
                float y = lntCur - Float.parseFloat(lntVal);
                distance = (float) Math.sqrt(x * x + y * y);

                wifiList.setDISTANCE(distance);
                wifiList.setX_SWIFI_MGR_NO(infolist.get(i).getX_SWIFI_MGR_NO());
                wifiList.setX_SWIFI_WRDOFC(infolist.get(i).getX_SWIFI_WRDOFC());
                wifiList.setX_SWIFI_MAIN_NM(infolist.get(i).getX_SWIFI_MAIN_NM());
                wifiList.setX_SWIFI_ADRES1(infolist.get(i).getX_SWIFI_ADRES1());
                wifiList.setX_SWIFI_ADRES2(infolist.get(i).getX_SWIFI_ADRES2());
                wifiList.setX_SWIFI_INSTL_FLOOR(infolist.get(i).getX_SWIFI_INSTL_FLOOR());
                wifiList.setX_SWIFI_INSTL_FLOOR(infolist.get(i).getX_SWIFI_INSTL_FLOOR());
                wifiList.setX_SWIFI_INSTL_TY(infolist.get(i).getX_SWIFI_INSTL_TY());
                wifiList.setX_SWIFI_INSTL_MBY(infolist.get(i).getX_SWIFI_INSTL_MBY());
                wifiList.setX_SWIFI_SVC_SE(infolist.get(i).getX_SWIFI_SVC_SE());
                wifiList.setX_SWIFI_CMCWR(infolist.get(i).getX_SWIFI_CMCWR());
                wifiList.setX_SWIFI_CNSTC_YEAR(infolist.get(i).getX_SWIFI_CNSTC_YEAR());
                wifiList.setX_SWIFI_INOUT_DOOR(infolist.get(i).getX_SWIFI_INOUT_DOOR());
                wifiList.setX_SWIFI_REMARS3(infolist.get(i).getX_SWIFI_REMARS3());
                wifiList.setLAT(infolist.get(i).getLAT());
                wifiList.setLNT(infolist.get(i).getLNT());
                wifiList.setWORK_DTTM(infolist.get(i).getWORK_DTTM());
                list.add(wifiList);
            }
            wifiService.distanceInsert(list);
            System.out.println("distance포함데이터  insert완료");
            List<WifiList> lists = wifiService.getListIncludeDistance();

            for (int i = 0; i < lists.size(); i++) {
                System.out.println(i + " : 진행중");
    %>

    <tr>
        <td><%= String.format("%.4f", lists.get(i).getDISTANCE())%></td>
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
        System.out.println("1");
        LocalDateTime now = LocalDateTime.now();
        System.out.println("2 : " + now);
        String formatNow = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS"));
        System.out.println("3");

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
        console.log(location.href);
    }
    document.querySelector('#addMemo').addEventListener('click', setHistory);
</script>
</body>
</html>