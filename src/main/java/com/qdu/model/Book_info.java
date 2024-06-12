package com.qdu.model;

import java.util.Date;

public class Book_info {
    private int bid;
    private String b_name;
    private double b_price;
    private int b_num;
    private String b_imgpath;
    private int type_id;
    private String publisher;
    private Date b_time;

    private double rate_number;
    private String author;
    private Date storage_time;
    private String b_info;
    private double discount;



    // Getters and setters
    public Date getB_time() {
        return b_time;
    }

    public void setB_time(Date b_time) {
        this.b_time = b_time;
    }

    public Book_info() {
    }


    public Book_info(int bid, String b_name, double b_price, int b_num, String b_imgpath, int type_id, String publisher, Date b_time, double rate_number, String author, Date storage_time, String b_info, double discount) {
        this.bid = bid;
        this.b_name = b_name;
        this.b_price = b_price;
        this.b_num = b_num;
        this.b_imgpath = b_imgpath;
        this.type_id = type_id;
        this.publisher = publisher;
        this.b_time = b_time;
        this.rate_number = rate_number;
        this.author = author;
        this.storage_time = storage_time;
        this.b_info = b_info;
        this.discount = discount;
    }

    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public String getBName() {
        return b_name;
    }

    public void setBName(String b_name) {
        this.b_name = b_name;
    }

    public double getBPrice() {
        return b_price;
    }

    public void setBPrice(double b_price) {
        this.b_price = b_price;
    }

    public int getBNum() {
        return b_num;
    }

    public void setBNum(int b_num) {
        this.b_num = b_num;
    }

    public String getBImgpath() {
        return b_imgpath;
    }

    public void setBImgpath(String b_imgpath) {
        this.b_imgpath = b_imgpath;
    }

    public int getTypeId() {
        return type_id;
    }

    public void setTypeId(int type_id) {
        this.type_id = type_id;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getBInfo() {
        return b_info;
    }

    public void setBInfo(String b_info) {
        this.b_info = b_info;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public double getRateNumber() {
        return rate_number;
    }

    public void setRateNumber(double rate_number) {
        this.rate_number = rate_number;
    }

    public Date getStorageTime() {
        return storage_time;
    }

    public void setStorageTime(Date storage_time) {
        this.storage_time = storage_time;
    }
}