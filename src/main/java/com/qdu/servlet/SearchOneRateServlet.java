package com.qdu.servlet;

import com.qdu.dao.impl.RateDaoImpl;
import com.qdu.model.Rate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/sors")
public class SearchOneRateServlet extends HttpServlet {
    RateDaoImpl rateDaoImpl = new RateDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int uidRateId = Integer.parseInt(req.getParameter("uidRateId"));
        int uid = Integer.parseInt(req.getParameter("uid"));

        // 根据 uidRateId 获取评论详细信息
        Rate rate = rateDaoImpl.findRateById(uidRateId,uid);

        if (rate != null) {
            req.setAttribute("rate", rate);
            req.getRequestDispatcher("/rate_info.jsp").forward(req, resp);
        } else {
            resp.getWriter().write("评论详情未找到");
        }
    }
}
