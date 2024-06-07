package com.qdu.model;

public class ShoppingCart {

    private int uid; // 外键，指向users表的uid
    private int bid; // 书编号，外键，指向book_info表的bid
    private String bookName; // 书名
    private double price; // 单价
    private String bookType; // 买的书的类型
    private int bookNum; // 买的书的数目
    private double sum; // 总价

    // 构造方法
    public ShoppingCart() {
    }

    public ShoppingCart(int uid, int bid, String bookName, double price, String bookType, int bookNum, double sum) {
        this.uid = uid;
        this.bid = bid;
        this.bookName = bookName;
        this.price = price;
        this.bookType = bookType;
        this.bookNum = bookNum;
        this.sum = sum;
    }

    // Getter 和 Setter 方法
    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getBookType() {
        return bookType;
    }

    public void setBookType(String bookType) {
        this.bookType = bookType;
    }

    public int getBookNum() {
        return bookNum;
    }

    public void setBookNum(int bookNum) {
        this.bookNum = bookNum;
    }

    public double getSum() {
        return sum;
    }

    public void setSum(double sum) {
        this.sum = sum;
    }
}