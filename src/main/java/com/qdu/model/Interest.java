package com.qdu.model;

public class Interest {
    private int uid;
    private String type_name;
    private int type_id;

    // Getters and setters

    public Interest() {
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getType_name() {
        return type_name;
    }

    public void setType_name(String type_name) {
        this.type_name = type_name;
    }

    public int getType_id() {
        return type_id;
    }

    public void setType_id(int type_id) {
        this.type_id = type_id;
    }

    public Interest(int uid, String type_name, int type_id) {
        this.uid = uid;
        this.type_name = type_name;
        this.type_id = type_id;
    }
}