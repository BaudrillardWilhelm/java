package com.qdu.servlet;

import com.qdu.dao.impl.RateDaoImpl;
import com.qdu.model.Rate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 该Servlet负责处理发表新日志的请求
 *
 * @author Anna
 */
@WebServlet("/ars")
public class AlterRateServlet extends HttpServlet {
    RateDaoImpl rateDaoImpl = new RateDaoImpl();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");

        int uid =  Integer.parseInt(req.getParameter("uid"));
        int bid = Integer.parseInt(req.getParameter("bid"));
        double star = Double.parseDouble(req.getParameter("star"));
        String content = req.getParameter("content");
        int uidRateId= Integer.parseInt(req.getParameter("uidRateId"));
        int rate = rateDaoImpl.alterRate(uid, bid, uidRateId, star, content);

        resp.setContentType("text/plain");
        resp.getWriter().write(String.valueOf(rate));
    }
}
