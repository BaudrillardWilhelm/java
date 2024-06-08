package com.qdu.servlet.Impl;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.qdu.dao.UserDao;
import com.qdu.dao.impl.UserDaoImpl;
import com.qdu.model.Login_if;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/gq")
public class GetQuestion extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String save_directory = "D:/java专用/A期末项目/项目/online_bookStore/src/main/webapp/ShowUserImage";
        MultipartRequest mreq = new MultipartRequest(request,save_directory,1024*1024*10,"UTF-8");
        String phone=mreq.getParameter("findPhone");
        UserDao uo = new UserDaoImpl();
        Map<String,Object> resultMap = new HashMap<>();
        String receive = uo.GetQuestionByPhone(phone);
        if(!receive.isEmpty())
        {
            resultMap.put("question",receive);
        }
        else
        {
            //登录失败
            resultMap.put("question","gg");
        }
        Gson gson = new Gson();
        String result = gson.toJson(resultMap);
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().print(result);
    }
}
