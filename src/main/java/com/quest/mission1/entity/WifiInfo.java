package com.quest.mission1.entity;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown =true)  //객체에 속성이없어도 예외를 발생하지않는다
public class WifiInfo {

    String X_SWIFI_MGR_NO;  //관리번호
    String X_SWIFI_WRDOFC; //자치구
    String X_SWIFI_MAIN_NM; //와이파이명
    String X_SWIFI_ADRES1; //도로명주소
    String X_SWIFI_ADRES2; //상세주소
    String X_SWIFI_INSTL_FLOOR; //설치위치(층)
    String X_SWIFI_INSTL_TY;    //설치유형
    String X_SWIFI_INSTL_MBY;   //설치기관
    String X_SWIFI_SVC_SE;  //서비스구분
    String X_SWIFI_CMCWR;  //망종류
    String X_SWIFI_CNSTC_YEAR;  //설치년도
    String X_SWIFI_INOUT_DOOR;  //실내외구분
    String X_SWIFI_REMARS3;    //WIFI접속환경
    String LAT;    //Y좌표
    String LNT;    //X좌표
    String WORK_DTTM;  //작업일자

    public WifiInfo() {
    }

    public WifiInfo(String X_SWIFI_MGR_NO, String X_SWIFI_WRDOFC, String X_SWIFI_MAIN_NM, String X_SWIFI_ADRES1, String X_SWIFI_ADRES2, String X_SWIFI_INSTL_FLOOR, String X_SWIFI_INSTL_TY, String X_SWIFI_INSTL_MBY, String X_SWIFI_SVC_SE, String X_SWIFI_CMCWR, String X_SWIFI_CNSTC_YEAR, String X_SWIFI_INOUT_DOOR, String X_SWIFI_REMARS3, String LAT, String LNT, String WORK_DTTM) {
        this.X_SWIFI_MGR_NO = X_SWIFI_MGR_NO;
        this.X_SWIFI_WRDOFC = X_SWIFI_WRDOFC;
        this.X_SWIFI_MAIN_NM = X_SWIFI_MAIN_NM;
        this.X_SWIFI_ADRES1 = X_SWIFI_ADRES1;
        this.X_SWIFI_ADRES2 = X_SWIFI_ADRES2;
        this.X_SWIFI_INSTL_FLOOR = X_SWIFI_INSTL_FLOOR;
        this.X_SWIFI_INSTL_TY = X_SWIFI_INSTL_TY;
        this.X_SWIFI_INSTL_MBY = X_SWIFI_INSTL_MBY;
        this.X_SWIFI_SVC_SE = X_SWIFI_SVC_SE;
        this.X_SWIFI_CMCWR = X_SWIFI_CMCWR;
        this.X_SWIFI_CNSTC_YEAR = X_SWIFI_CNSTC_YEAR;
        this.X_SWIFI_INOUT_DOOR = X_SWIFI_INOUT_DOOR;
        this.X_SWIFI_REMARS3 = X_SWIFI_REMARS3;
        this.LAT = LAT;
        this.LNT = LNT;
        this.WORK_DTTM = WORK_DTTM;
    }
}
