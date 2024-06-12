package com.qdu.servlet.Impl;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.qdu.dao.impl.UserDaoImpl;
import com.qdu.model.Login_if;
import com.qdu.model.Users;
import com.qdu.servlet.LoginServlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ls")
public class LoginServletImpl extends HttpServlet implements LoginServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String save_directory = "D:/java专用/A期末项目/项目/online_bookStore/src/main/webapp/ShowUserImage";
        MultipartRequest mreq = new MultipartRequest(request,save_directory,1024*1024*10,"UTF-8");
        String uname=mreq.getParameter("name");
        String pwd=mreq.getParameter("password");
        UserDaoImpl uo = new UserDaoImpl();
        Users user = uo.GetInformationByNameAndPassword(uname, pwd);
        Map<String,Object>resultMap = new HashMap<>();
        if(user != null)
        {
            resultMap.put("isLogin",true);
            Login_if.getInstance().setIfLogin(true);

            HttpSession session = request.getSession();
            session.setAttribute("LoggedUser",user);

            Cookie cookie = new Cookie("JSESSIONID",session.getId());
            response.addCookie(cookie);

        }
        else
        {
            //登录失败
            resultMap.put("isLogin",false);
            Login_if.getInstance().setIfLogin(true);
        }
        Gson gson = new Gson();
        String result = gson.toJson(resultMap);
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().print(result);
    }
}