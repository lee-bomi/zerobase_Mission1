package com.quest.mission1.entity;

public class History {

    int ID;
    double LNT;    //X좌표
    double LAT;    //Y좌표
    String CURTIME;   //현재시간

    public History(double LNT, double LAT, String CURTIME) {
        this.LNT = LNT;
        this.LAT = LAT;
        this.CURTIME = CURTIME;
    }

    public History() {
    }

    public int getID() {
        return ID;
    }
    public void setID(int ID) {
        this.ID = ID;
    }

    public double getLNT() {
        return LNT;
    }

    public void setLNT(double LNT) {
        this.LNT = LNT;
    }

    public double getLAT() {
        return LAT;
    }

    public void setLAT(double LAT) {
        this.LAT = LAT;
    }

    public String getCURTIME() {
        return CURTIME;
    }

    public void setCURTIME(String CURTIME) {
        this.CURTIME = CURTIME;
    }
}
