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
import java.util.List;

/**
 * 处理查询所有日志基本信息请求的Servlet
 *
 * @author Anna
 */

/**
 * 用于搜索图书所有评论，需要获得一个int bid
 * 向BookRate_list.jsp发送 List<Rate>
 */
@WebServlet("/sbars")
public class SearchBookAllRateServlet extends HttpServlet {
    private static final int COMMENTS_PER_PAGE = 4;
    RateDaoImpl rateDaoImpl = new RateDaoImpl();
    UserDaoImpl userDao = new UserDaoImpl();
    Book_infoDaoImpl book_infoDaoImpl = new Book_infoDaoImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int uid = Integer.parseInt(req.getParameter("uid"));
        int bid = Integer.parseInt(req.getParameter("bid"));
        int page = req.getParameter("page") != null ? Integer.parseInt(req.getParameter("page")) : 1;

        // Calculate offset based on page number
        int offset = (page - 1) * COMMENTS_PER_PAGE;
        List<Rate> rateList = rateDaoImpl.findRateListByBookIdPaged(bid, offset, COMMENTS_PER_PAGE);
        int totalComments = rateDaoImpl.countRatesByBookId(bid);
        int totalPages = (int) Math.ceil((double) totalComments / COMMENTS_PER_PAGE);
        Users user = userDao.findUserListById(uid);
        Book_info book = book_infoDaoImpl.findBookById(bid);

        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.setAttribute("uid",uid);
        req.setAttribute("bid",bid);
        req.setAttribute("loggedUser",user);
        req.setAttribute("rateList", rateList);
        req.setAttribute("book",book);
        req.setAttribute("rateDaoImpl",rateDaoImpl);

        req.getRequestDispatcher("/BookRate_list.jsp").forward(req, resp);
    }
}
