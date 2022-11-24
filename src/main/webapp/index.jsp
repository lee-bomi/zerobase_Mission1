<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.quest.mission1.db.WifiService" %>

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
    <a href="index.jsp">홈</a> | <a href="historyList.jsp">위치 히스토리 목록</a> | <a id="tossGeo" style="text-decoration: underline">Open API 와이파이 정보 가져오기</a>
<br>
<br>

<label for="lat">LAT: <input type="text" id="lat" placeholder="0.0" value="" name="lat"></label> ,
<label for="lnt">LNT: <input type="text" id="lnt" placeholder="0.0" name="lnt"></label>
<input type="button" id="getLocation" value="내 위치 가져오기">
<input type="button" id="getList" value="근처 wifi정보보기">

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
    <tr><td colspan="17" style="text-align: center">위치 정보를 입력한 후에 조회해 주세요</td></tr>

</table>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
    let latitude = 0;
    let longitude = 0;
    function geoFindMe() {
        const status = document.querySelector('#status');

        function success(position) {    //현재 페이지가 로딩되면 자동으로 현재위치 가져온다
            latitude  = position.coords.latitude;
            longitude = position.coords.longitude;
        }

        function error() {
            status.textContent = 'Unable to retrieve your location';
        }
        navigator.geolocation.getCurrentPosition(success, error);
    }
    document.addEventListener("DOMContentLoaded", geoFindMe);

    function showGeo() {    //input에 값을 보여주는역할만!
        document.getElementById('lat').value = latitude;
        document.getElementById('lnt').value  = longitude;
    }
    document.querySelector('#getLocation').addEventListener('click', showGeo);

    function toss() {   //와이파이정보가져올때 현재위치를 넘김
        location.href = '/indexTemp.jsp?lnt=' + longitude + '&lat=' + latitude;
    }
    document.querySelector('#tossGeo').addEventListener('click', toss);

    function getWifiList() {    //쿼리문에서 검색해서 가져옴
        let _lat = document.getElementById('lat').value;
        let _lnt = document.getElementById('lnt').value;

        location.href = '/wifiList.jsp?lat=' + _lat + '&lnt=' + _lnt;
    }
    document.querySelector('#getList').addEventListener('click', getWifiList);
</script>
</body>
</html>