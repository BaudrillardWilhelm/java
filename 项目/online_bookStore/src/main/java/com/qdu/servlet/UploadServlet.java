package com.qdu.servlet;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.qdu.model.Image;
import com.qdu.model.Result;
import com.qdu.util.CustomFileRenamePolicy2;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 该Servlet负责上传多张图片的请求
 *
 * @author Anna
 */
@WebServlet("/uploadServlet")
public class UploadServlet extends HttpServlet {

    private String save_directory = "c:/upload";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        CustomFileRenamePolicy2 policy = new CustomFileRenamePolicy2();

        MultipartRequest mreq
                = new MultipartRequest(req, save_directory, 100 * 1024 * 1024, "utf-8", policy);

        //上传完文件，获取上传的文件的名称（重命名后的名称）列表
        List<String> fileNameList = policy.getFileNames();

        //为了满足wangEditor要的返回的数据格式，可以返回一个Result对象
        //包含上传的图片的信息
        List<Image> list = new ArrayList<>();

        //遍历上传的文件的名称列表
        for (String name : fileNameList) {
            //每张图片的信息构造成一个Image对象
            Image image = new Image("upload/" + name);
            //添加Image对象到列表中
            list.add(image);
        }

        //指定错误代码（0表示没有错误）和上传的图片列表
        Result result = new Result(0, list);
        //鉴于wangEditor要的json数据，所以转成json返回给页面
        Gson gson=new Gson();
        resp.setContentType("application/json;charset=utf-8");
        resp.getWriter().print(gson.toJson(result));
    }
}
