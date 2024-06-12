package com.qdu.servlet;

import com.qdu.dao.impl.Book_infoDaoImpl;
import com.qdu.dao.impl.RateDaoImpl;
import com.qdu.dao.impl.UserDaoImpl;
import com.qdu.model.Book_info;
import com.qdu.model.Rate;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 从BookInfo.jsp里面拿参数，发给add_rate.jsp
 */
@WebServlet("/banrs")
public class BeforeAddNewRateServlet extends HttpServlet {
    UserDaoImpl userDao = new UserDaoImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 获取请求参数并设置字符编码
        req.setCharacterEncoding("utf-8");
        int uid = Integer.parseInt(req.getParameter("uid"));
        Users user = userDao.findUserListById(uid);
        req.setAttribute("uid",uid);
        req.setAttribute("loggedUser",user);
        req.setAttribute("bid",req.getParameter("bid"));
        req.getRequestDispatcher("/add_rate.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        doGet(req, resp);
    }

}
