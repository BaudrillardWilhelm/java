/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.qdu.model;

/**
 *
 * @author dell
 */
public class Image {
    private String url;
    private String alt;
    private String href;

    public Image(){}
    public Image(String url)
    {
        this.url=url;
    }

    public Image(String url, String alt, String href) {
        this.url = url;
        this.alt = alt;
        this.href = href;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getAlt() {
        return alt;
    }

    public void setAlt(String alt) {
        this.alt = alt;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }


}
