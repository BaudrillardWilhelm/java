package com.qdu.model;

import java.util.Date;

public class Collection {
    private int uid;
    private int bid;
    private String book_name;
    private Date book_time;
    private String book_type;


    // Getters and setters

    public Collection() {
    }

    public Collection(int uid,int bid, String book_name, Date book_time, String book_type) {
        this.uid = uid;
        this.bid = bid;
        this.book_name = book_name;
        this.book_time = book_time;
        this.book_type = book_type;
    }

    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public String getBook_name() {
        return book_name;
    }

    public void setBook_name(String book_name) {
        this.book_name = book_name;
    }

    public Date getBook_time() {
        return book_time;
    }

    public void setBook_time(Date book_time) {
        this.book_time = book_time;
    }

    public String getBook_type() {
        return book_type;
    }

    public void setBook_type(String book_type) {
        this.book_type = book_type;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }
}