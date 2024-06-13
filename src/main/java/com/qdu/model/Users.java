package com.qdu.model;

import java.util.Date;

public class Users {
    private int uid;//编号，自动分配
    private String uname;//用户名
    private String upassword;//用户密码
    private String uquestion;//密保的问题
    private String uanswer;//密保的答案
    private String true_name;//真名
    private String gender;//性别
    private String tel;//手机号
    private String e_mail;//电子邮件
    private String career;//职业
    private String interest;//感兴趣的书籍
    private String address;//收件地址
    private double money;//账户金额
    private Date registration_time;//注册时间

    // Getters and setters


    public Users() {
    }

    public Users(int uid) {
        this.uid = uid;
    }

    public Users(int uid, String uname, String upassword, String uquestion, String uanswer, String true_name, String gender, String tel, String e_mail, String career, String interest, String address, double money, Date registration_time) {
        this.uid = uid;
        this.uname = uname;
        this.upassword = upassword;
        this.uquestion = uquestion;
        this.uanswer = uanswer;
        this.true_name = true_name;
        this.gender = gender;
        this.tel = tel;
        this.e_mail = e_mail;
        this.career = career;
        this.interest = interest;
        this.address = address;
        this.money = money;
        this.registration_time = registration_time;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getUpassword() {
        return upassword;
    }

    public void setUpassword(String upassword) {
        this.upassword = upassword;
    }

    public String getUquestion() {
        return uquestion;
    }

    public void setUquestion(String uquestion) {
        this.uquestion = uquestion;
    }

    public String getUanswer() {
        return uanswer;
    }

    public void setUanswer(String uanswer) {
        this.uanswer = uanswer;
    }


    public String getTrue_name() {
        return true_name;
    }

    public void setTrue_name(String true_name) {
        this.true_name = true_name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getE_mail() {
        return e_mail;
    }

    public void setE_mail(String e_mail) {
        this.e_mail = e_mail;
    }

    public String getCareer() {
        return career;
    }

    public void setCareer(String career) {
        this.career = career;
    }

    public String getInterest() {
        return interest;
    }

    public void setInterest(String interest) {
        this.interest = interest;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getMoney() {
        return money;
    }

    public void setMoney(double money) {
        this.money = money;
    }

    public Date getRegistration_time() {
        return registration_time;
    }

    public void setRegistration_time(Date registration_time) {
        this.registration_time = registration_time;
    }
}