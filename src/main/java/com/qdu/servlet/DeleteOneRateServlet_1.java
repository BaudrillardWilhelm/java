package com.qdu.servlet;

import com.qdu.dao.impl.Book_infoDaoImpl;
import com.qdu.dao.impl.RateDaoImpl;
import com.qdu.model.Book_info;
import com.qdu.model.Rate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.google.gson.Gson;  // Import Gson library

@WebServlet("/DeleteOneRateServlet_1")
public class DeleteOneRateServlet_1 extends HttpServlet {
    RateDaoImpl rateDaoImpl = new RateDaoImpl();
    Book_infoDaoImpl bookInfoDao = new Book_infoDaoImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int uidRateId = Integer.parseInt(req.getParameter("uidRateId"));
        int uid = Integer.parseInt(req.getParameter("uid"));
        int bid = Integer.parseInt(req.getParameter("bid"));
        int result_rate = bookInfoDao.UpdateBookRateNum(bid);
        int result = rateDaoImpl.deleteRate(uid, bid, uidRateId);



        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(result);
        resp.getWriter().write(jsonResponse);
    }
}
