package com.qdu.model;

public class Rate {
    private int uid;
    private int bid;
    private Double star;
    private String info;
    private int uidRateId;

    public Rate() {
    }

    public Rate(int uid, int bid, Double star, String info, int uidRateId) {
        this.uid = uid;
        this.bid = bid;
        this.star = star;
        this.info = info;
        this.uidRateId = uidRateId;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public Double getStar() {
        return star;
    }

    public void setStar(Double star) {
        this.star = star;
    }

    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public int getUidRateId() {
        return uidRateId;
    }

    public void setUidRateId(int uidRateId) {
        this.uidRateId = uidRateId;
    }
}
