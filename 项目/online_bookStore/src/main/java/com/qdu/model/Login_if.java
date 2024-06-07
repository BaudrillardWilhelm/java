package com.qdu.model;

public class Login_if {
    private boolean ifLogin;
    private int uid;//-1代表未登录
    private static Login_if instance = new Login_if();
    private Login_if()
    {
        ifLogin = false;
        uid  = -1;
    }
    public static Login_if getInstance()
    {
        return instance;
    }
    public boolean getIfLogin()
    {
        return ifLogin;
    }
    public int getUid()
    {
        return uid;
    }
    public void setIfLogin(boolean in)
    {
        ifLogin = in;
    }
    public void setUid(int in)
    {
        uid = in;
    }
}
