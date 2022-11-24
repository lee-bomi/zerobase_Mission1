package com.quest.mission1;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.quest.mission1.entity.Test;
import org.json.JSONArray;
import org.json.JSONObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
import com.quest.mission1.entity.WifiInfo;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

public class ApiTest {
    public static List<WifiInfo> getApi() throws IOException {
        ApiTest apiTest = new ApiTest();
        String jsonData = apiTest.readApi();
        //데이터 -> JSON형태로 변환
        JSONObject jsonObject = new JSONObject(jsonData);   // key - value형태일때는 JSONObject
        JSONArray jsonArray = jsonObject.getJSONObject("TbPublicWifiInfo").getJSONArray("row"); //wifi_info

        //Json -> Gson
        Gson gson = new Gson();
        Type listType = new TypeToken<ArrayList<WifiInfo>>(){}.getType();
        List<WifiInfo> list = gson.fromJson(jsonArray.toString(), listType);

        return list;
    }

    public int getCount() throws Exception {
        String jsonData = readApi();
        JSONObject jsonObject = new JSONObject(jsonData);
        int cnt = jsonObject.getJSONObject("TbPublicWifiInfo").getInt("list_total_count");
        return cnt;
    }

    public String readApi() throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088/4a69776956656d6d36366974486f6b/json/TbPublicWifiInfo/1/20/");
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;

        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }

        rd.close();
        conn.disconnect();

        return sb.toString();
    }
}
