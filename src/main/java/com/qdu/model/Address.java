package com.qdu.model;

public class Address {
    private int uid;
    private String province;
    private String city;
    private String area;
    private String info;
    private String postal_code;
    private String receiver_name;
    private String tel;
    private int user_address_id;

    // Getters and setters

    public Address() {
    }


    public Address(int uid, String province, String city, String area, String info, String postal_code, String receiver_name, String tel, int user_address_id) {
        this.uid = uid;
        this.province = province;
        this.city = city;
        this.area = area;
        this.info = info;
        this.postal_code = postal_code;
        this.receiver_name = receiver_name;
        this.tel = tel;
        this.user_address_id = user_address_id;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getPostal_code() {
        return postal_code;
    }

    public void setPostal_code(String postal_code) {
        this.postal_code = postal_code;
    }

    public String getReceiver_name() {
        return receiver_name;
    }

    public void setReceiver_name(String receiver_name) {
        this.receiver_name = receiver_name;
    }

    public int getUser_address_id() {
        return user_address_id;
    }

    public void setUser_address_id(int user_address_id) {
        this.user_address_id = user_address_id;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }
}