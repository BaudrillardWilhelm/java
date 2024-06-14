package com.qdu.servlet;

import com.qdu.dao.impl.Book_infoDaoImpl;
import com.qdu.dao.impl.OrderDaoImpl;
import com.qdu.model.Book_info;
import com.qdu.model.Rate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/SearchBooksServlet")
public class SearchBooksServlet extends HttpServlet {
    private static final int COMMENTS_PER_PAGE = 4;
    private Book_infoDaoImpl bookInfoDao = new Book_infoDaoImpl();
            OrderDaoImpl orderDao = new OrderDaoImpl();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String searchType = request.getParameter("searchType");
        List<Book_info> bookList;


        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int offset = (page - 1) * COMMENTS_PER_PAGE;
        int totalComments;

        if ("author".equals(searchType)) {
            bookList = bookInfoDao.findBookByAuhor(keyword,offset, COMMENTS_PER_PAGE);
            totalComments = bookInfoDao.countBooksByAuthorAsKeyword(keyword);
        }else if("name".equals(searchType)){
            bookList = bookInfoDao.findBookByName(keyword,offset, COMMENTS_PER_PAGE);
            totalComments = bookInfoDao.countBooksByNameAsKeyword(keyword);
        }else {
            bookList = bookInfoDao.findBookByName(keyword,offset, COMMENTS_PER_PAGE);     //默认按照名字查
            totalComments = bookInfoDao.countBooksByNameAsKeyword(keyword);
        }

        int totalPages = (int) Math.ceil((double) totalComments / COMMENTS_PER_PAGE);

        if (bookList == null || bookList.isEmpty()) {
            request.setAttribute("errorMessage", "很抱歉，没有搜索到您想要的(╥﹏╥)");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } else {

            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.setAttribute("keyword",keyword);
            request.setAttribute("searchType",searchType);
            request.setAttribute("bookList", bookList);
            request.getRequestDispatcher("/searchResults.jsp").forward(request, response);
        }
    }
}
