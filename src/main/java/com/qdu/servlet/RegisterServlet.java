package com.qdu.servlet;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.qdu.dao.impl.UserDaoImpl;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
@WebServlet("/rs")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String save_directory = "D:/java专用/A期末项目/项目/online_bookStore/src/main/webapp/ShowUserImage";
        MultipartRequest mreq = new MultipartRequest(request,save_directory,1024*1024*10,"UTF-8");
        UserDaoImpl uo = new UserDaoImpl();
        Map<String,Object> resultMap = new HashMap<>();

        long currentTimeMillis = System.currentTimeMillis();
        // 使用该毫秒值创建 Date 对象
        Date currentDate = new Date(currentTimeMillis);
        Users push = new Users(11,mreq.getParameter("userName"),mreq.getParameter("userPassword"),mreq.getParameter("userQuestion"),mreq.getParameter("userAnswer"),mreq.getParameter("userTrue_Name"),mreq.getParameter("userGender"),mreq.getParameter("userTel"),mreq.getParameter("userE_Mail"),mreq.getParameter("userCareer"),"",mreq.getParameter("userAddress"),0, currentDate);
        // 打印格式化后的日期和时间
        if(uo.PushNewUser(push))
        {
            resultMap.put("RegisterTrue",true);
        }
        else
        {
            resultMap.put("RegisterTrue",false);
        }
        Gson gson = new Gson();
        String result = gson.toJson(resultMap);
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().print(result);
    }
}
