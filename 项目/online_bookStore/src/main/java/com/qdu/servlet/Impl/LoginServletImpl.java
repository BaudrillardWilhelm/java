package com.qdu.servlet.Impl;

import com.qdu.dao.impl.UserDaoImpl;
import com.qdu.servlet.LoginServlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ls")
public class LoginServletImpl extends HttpServlet implements LoginServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {        
 
        String uname=request.getParameter("username");
        String pwd=request.getParameter("password");
        UserDaoImpl uo = new UserDaoImpl();
        if(uo.haveThePeopleByUnameAndUpassword(uname,pwd))
        {
            if(uo.ifPeopleIsTheAdministratorsByUnameAndUpassword(uname,pwd))
            {
                //管理员登录
                HttpSession session=request.getSession();
                session.setAttribute("isLogin", "yes");
                response.sendRedirect("index1.html");
            }
            else
            {
                //该用户作为非管理员登录
                HttpSession session=request.getSession();
                session.setAttribute("isLogin", "yes");
                response.sendRedirect("index1.html");
            }
        }
        else
        {
            //登录失败
            response.sendRedirect("fail.html");
        }
        if(uname.equals("anna")&&pwd.equals("1234")){

        }else{

        }
    }
}
