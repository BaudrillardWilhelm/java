package com.qdu.model;

public class lyyAjax {
    private String url;
    private static lyyAjax instance = new lyyAjax();
    private lyyAjax()
    {
        url = "D:/java专用/A期末项目/项目/online_bookStore/src/main/webapp/ShowUserImage";
    }
    public static lyyAjax getInstance()
    {
        return instance;
    }
    public String getUrl()
    {
        return url;
    }
}
