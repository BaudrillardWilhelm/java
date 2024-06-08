package com.qdu.model;

public class Login_if {
    boolean ifLogin;
    private static Login_if instance = new Login_if();
    private Login_if()
    {
        ifLogin = false;
    }
    public static Login_if getInstance()
    {
        return instance;
    }
    public boolean getIfLogin()
    {
        return ifLogin;
    }
    public void setIfLogin(boolean in)
    {
        ifLogin = in;
    }
}
