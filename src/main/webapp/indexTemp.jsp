<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.quest.mission1.db.WifiService" %>
<%@ page import="com.quest.mission1.entity.WifiInfo" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="com.fasterxml.jackson.core.JsonProcessingException" %>
<%@ page import="com.fasterxml.jackson.annotation.PropertyAccessor" %>
<%@ page import="com.fasterxml.jackson.annotation.JsonAutoDetect" %>
<%@ page import="java.util.ArrayList" %>
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
    <a href="">홈</a> | <a href="">위치 히스토리 목록</a> | <a href="indexTemp.jsp">Open API 와이파이 정보 가져오기</a>
<br>
<br>
<form action="wifiList.jsp">
    <label for="lat">LAT: <input type="text" id="lat" placeholder="0.0" value="" name="lat"></label> ,
    <label for="lnt">LNT: <input type="text" id="lnt" placeholder="0.0" name="lnt"></label>
    <input type="button" id="getLocation" value="내 위치 가져오기">
    <input type="submit" value="근처 wifi정보보기">
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
    %>
        <tr><td colspan="17" style="text-align: center">위치 정보를 입력한 후에 조회해 주세요</td></tr>

</table>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
    function getInfos() {
        <%
            String lnt = request.getParameter("lnt");
            String lat = request.getParameter("lat");
            System.out.println("indexTemp lnt, lat : " + lnt + ", " + lat);
            int totalCnt = 0;
            StringBuilder urlBuilder = null;
            HttpURLConnection conn = null;
            BufferedReader rd = null;
            int start = 0;
            int end = 999;
            JSONArray jsonArray = new JSONArray();
            ArrayList<JSONArray> arr = new ArrayList<>();
            JSONObject getJson = null;

            for(int i = 0; i < 17; i++) {
                urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088/4a69776956656d6d36366974486f6b/json/TbPublicWifiInfo/" + start + "/" + end + "/");
                start += 1000;
                end = start + 999;
                URL url = new URL(urlBuilder.toString());
                conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Content-type", "application/json");
                if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                    rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                } else {
                    rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
                }


                String line;
                while ((line = rd.readLine()) != null) {
                    getJson = new JSONObject(line);
                    jsonArray = getJson.getJSONObject("TbPublicWifiInfo").getJSONArray("row");
                    arr.add(jsonArray);
                }
                    totalCnt = getJson.getJSONObject("TbPublicWifiInfo").getInt("list_total_count");
                rd.close();
                conn.disconnect();
            }

            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);  //dto의 각 프로퍼티에 데이터 매핑해주기위함
            try{
                for(int i = 0; i < arr.size(); i++) {
                    WifiInfo[] data = objectMapper.readValue(arr.get(i).toString(), WifiInfo[].class);
                    wifiService.dbInsert(data, lnt, lat);   //현재위치 좌표도 함께 보냄
                    System.out.println(i + " : data insert");
                }
                System.out.println("여기는 try : 완료햇다오바");
            }catch (JsonProcessingException e){
                e.printStackTrace();
            }finally{
                System.out.println(" : api로 가져온데이터 insert완료" );
            }
        %>
    }

</script>
<script>
    function ready() {
        location.href = '/infoSave.jsp?cnt=' + <%= totalCnt %>;
    }
    document.addEventListener("DOMContentLoaded", ready);
</script>
</body>
</html>