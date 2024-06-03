package com.qdu.chatblog.servlet;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.qdu.chatblog.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author 李冠良
 * @program ChatBlog
 * @description 处理登录请求
 * @date 2024/05/28
 */
@WebServlet("/loginSubmitServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String save_directory = "D:/JavaProject/ChatBlog/ResourceSave/ProfileImage";
        MultipartRequest mreq = new MultipartRequest(req,save_directory,1024*1024*10,"UTF-8");
        UserService userService=UserService.getUserService();
        boolean isPassRight = false;
        try {
            long uid= Long.parseLong(mreq.getParameter("uid"));
            String pass=mreq.getParameter("uPass");
            isPassRight=userService.isPassRight(uid,pass);
        }
        catch (NumberFormatException ignored){}
        finally{
            Map<String, Object> resultMap = new HashMap<>();
            resultMap.put("isRight",isPassRight);
            Gson gson = new Gson();
            String result = gson.toJson(resultMap);
            resp.setContentType("application/json;charset=utf-8");
            resp.getWriter().print(result);
        }
    }
}