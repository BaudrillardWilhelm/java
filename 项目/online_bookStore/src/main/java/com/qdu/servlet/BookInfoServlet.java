package com.qdu.servlet;

import com.qdu.dao.impl.Book_infoDaoImpl;
import com.qdu.model.Book_info;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/BookInfoServlet")
public class BookInfoServlet extends HttpServlet {
    Book_infoDaoImpl book_infoDaoImpl = new Book_infoDaoImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int bid = Integer.parseInt(req.getParameter("bid"));
        Book_info book_info = book_infoDaoImpl.findBookById(bid);
        req.setAttribute("bookInfo",book_info);
        req.getRequestDispatcher("/BookInfo.jsp").forward(req, resp);
    }

}
