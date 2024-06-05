package com.qdu.model;

import java.util.Date;

public class Order {
    private int oid;
    private int uid;
    private String receiver_name;
    private String buyer_address;
    private String buyer_tel;
    private String postal_code;
    private Date order_date;

    private int order_type;

    private int bid;
    private String b_name;
    private int book_num;
    private double sum_price;

    // Getters and setters

    public Order() {
    }

    public Order(int oid, int uid, String receiver_name, String buyer_address, String buyer_tel, String postal_code, Date order_date, int order_type, int bid, String b_name, int book_num, double sum_price) {
        this.oid = oid;
        this.uid = uid;
        this.receiver_name = receiver_name;
        this.buyer_address = buyer_address;
        this.buyer_tel = buyer_tel;
        this.postal_code = postal_code;
        this.order_date = order_date;
        this.order_type = order_type;
        this.bid = bid;
        this.b_name = b_name;
        this.book_num = book_num;
        this.sum_price = sum_price;
    }
    public Order(int uid, String receiver_name, String buyer_address, String buyer_tel, String postal_code, Date order_date, int order_type, int bid, String b_name, int book_num, double sum_price) {
        this.uid = uid;
        this.receiver_name = receiver_name;
        this.buyer_address = buyer_address;
        this.buyer_tel = buyer_tel;
        this.postal_code = postal_code;
        this.order_date = order_date;
        this.order_type = order_type;
        this.bid = bid;
        this.b_name = b_name;
        this.book_num = book_num;
        this.sum_price = sum_price;
    }
    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public String getB_name() {
        return b_name;
    }

    public void setB_name(String b_name) {
        this.b_name = b_name;
    }

    public int getBook_num() {
        return book_num;
    }

    public void setBook_num(int book_num) {
        this.book_num = book_num;
    }

    public double getSum_price() {
        return sum_price;
    }

    public void setSum_price(double sum_price) {
        this.sum_price = sum_price;
    }

    public Order(int oid, int uid, String receiver_name, String buyer_address, String buyer_tel, String postal_code, Date order_date, int order_type) {
        this.oid = oid;
        this.uid = uid;
        this.receiver_name = receiver_name;
        this.buyer_address = buyer_address;
        this.buyer_tel = buyer_tel;
        this.postal_code = postal_code;
        this.order_date = order_date;
        this.order_type = order_type;
    }

    public int getOid() {
        return oid;
    }

    public void setOid(int oid) {
        this.oid = oid;
    }

    public String getReceiver_name() {
        return receiver_name;
    }

    public void setReceiver_name(String receiver_name) {
        this.receiver_name = receiver_name;
    }

    public String getBuyer_address() {
        return buyer_address;
    }

    public void setBuyer_address(String buyer_address) {
        this.buyer_address = buyer_address;
    }

    public String getBuyer_tel() {
        return buyer_tel;
    }

    public void setBuyer_tel(String buyer_tel) {
        this.buyer_tel = buyer_tel;
    }

    public String getPostal_code() {
        return postal_code;
    }

    public void setPostal_code(String postal_code) {
        this.postal_code = postal_code;
    }

    public Date getOrder_date() {
        return order_date;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public int getOrder_type() {
        return order_type;
    }

    public void setOrder_type(int order_type) {
        this.order_type = order_type;
    }
}
