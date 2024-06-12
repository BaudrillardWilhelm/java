package com.qdu.servlet;

import com.qdu.dao.impl.Book_infoDaoImpl;
import com.qdu.dao.impl.InterestDaoImpl;
import com.qdu.dao.impl.RateDaoImpl;
import com.qdu.model.Book_info;
import com.qdu.model.Rate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/SearchOneBookInfoServlet")
public class SearchOneBookInfoServlet extends HttpServlet {
    Book_infoDaoImpl book_infoDao = new Book_infoDaoImpl();
    InterestDaoImpl interestDao = new InterestDaoImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int bid = Integer.parseInt(req.getParameter("bid"));

        // 根据 uidRateId 获取详细信息
        Book_info book = book_infoDao.findBookById(bid);
        if (book != null) {
            int type_id = book.getTypeId();
            String type_name = interestDao.findInterestChineseNameBytypeId(type_id);
            req.setAttribute("type_name",type_name);
            req.setAttribute("bookInfo", book);
            req.getRequestDispatcher("/BookInfo.jsp").forward(req, resp);
        } else {
            resp.getWriter().write("未找到该书！");
        }
    }
}
