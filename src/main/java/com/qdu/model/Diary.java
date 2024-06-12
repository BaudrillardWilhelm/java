package com.qdu.model;

import java.util.Date;

/**
 * Diary类
 *
 * @author Anna
 */
public class Diary {

    private String did; //日志编号
    private String dtitle; //日志标题
    private String dtext; //日志内容
    private Date dtime; //发布日志时间
    private String downer; //日志发布人

    public Diary() {
    }

    public Diary(String did, String dtitle, Date dtime, String downer) {
        this.did = did;
        this.dtitle = dtitle;
        this.dtime = dtime;
        this.downer = downer;
    }

    public Diary(String did, String dtitle, String dtext, String downer) {
        this.did = did;
        this.dtitle = dtitle;
        this.dtext = dtext;
        this.downer = downer;
    }

    public Diary(String did, String dtitle, String dtext, Date dtime, String downer) {
        this.did = did;
        this.dtitle = dtitle;
        this.dtext = dtext;
        this.dtime = dtime;
        this.downer = downer;
    }

    public String getDid() {
        return did;
    }

    public void setDid(String did) {
        this.did = did;
    }

    public String getDtitle() {
        return dtitle;
    }

    public void setDtitle(String dtitle) {
        this.dtitle = dtitle;
    }

    public String getDtext() {
        return dtext;
    }

    public void setDtext(String dtext) {
        this.dtext = dtext;
    }

    public Date getDtime() {
        return dtime;
    }

    public void setDtime(Date dtime) {
        this.dtime = dtime;
    }

    public String getDowner() {
        return downer;
    }

    public void setDowner(String downer) {
        this.downer = downer;
    }
}
