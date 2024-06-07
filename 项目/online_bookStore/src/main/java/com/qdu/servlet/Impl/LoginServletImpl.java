package com.qdu.servlet.Impl;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.qdu.dao.impl.UserDaoImpl;
import com.qdu.model.Login_if;
import com.qdu.model.lyyAjax;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ls")
public class LoginServletImpl extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String save_directory = lyyAjax.getInstance().getUrl();
        MultipartRequest mreq = new MultipartRequest(request,save_directory,1024*1024*10,"UTF-8");
        String uname=mreq.getParameter("name");
        String pwd=mreq.getParameter("password");
        UserDaoImpl uo = new UserDaoImpl();
        Map<String,Object>resultMap = new HashMap<>();
        if(uo.haveThePeopleByUnameAndUpassword(uname,pwd))
        {
            resultMap.put("isLogin",true);
            Login_if.getInstance().setIfLogin(true);
            //HttpSession session = request.getSession();
            //session.setAttribute("loggedUser",uo.GetInformationByNameAndPassword(uname,pwd));
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
