package com.qdu.model;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

/**
 *创建一个实体类，用于包含上传的所有图片的信息
 * @author dell
 */
public class Result {
    private int errno;

    private List<Image> data;

    public Result() {
    }

    public Result(int errno, List<Image> data) {
        this.errno = errno;
        this.data = data;
    }

    public int getErrno() {
        return errno;
    }

    public void setErrno(int errno) {
        this.errno = errno;
    }

    public List<Image> getData() {
        return data;
    }

    public void setData(List<Image> data) {
        this.data = data;
    }


}
