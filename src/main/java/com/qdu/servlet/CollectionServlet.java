package com.qdu.servlet;

import com.qdu.dao.impl.Book_infoDaoImpl;
import com.qdu.dao.impl.CollectionDaoImpl;
import com.qdu.dao.impl.InterestDaoImpl;
import com.qdu.model.Book_info;
import com.qdu.model.Collection;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

@WebServlet("/collection")
public class CollectionServlet extends HttpServlet {

    private CollectionDaoImpl collectionDaoImpl = new CollectionDaoImpl();
    private Book_infoDaoImpl bookInfoDao = new Book_infoDaoImpl();
    private InterestDaoImpl interestDao = new InterestDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users loggedUser = (Users) req.getSession(false).getAttribute("LoggedUser");
        int result = 0;

        String action = req.getParameter("action");

        if (loggedUser != null) {
            int uid = loggedUser.getUid();
            int bid;
            switch (action) {
                case "collect":
                    bid = Integer.parseInt(req.getParameter("bid"));
                    Book_info book = bookInfoDao.findBookById(bid);
                    String book_name = book.getBName();
                    Date date = new Date();
                    String book_type = interestDao.findInterestChineseNameBytypeId(book.getTypeId());
                    Collection collection = new Collection(uid,bid, book_name, date, book_type);

                    result = collectionDaoImpl.addCollection(collection);
                    break;
                case "remove":
                    bid = Integer.parseInt(req.getParameter("bid"));
                    result = collectionDaoImpl.removeCollection(uid, bid);
                    break;
                case "clearAll":
                    result = collectionDaoImpl.removeAllCollection(uid);
                    break;
                default:
                    result = 0;
            }
        } else {
            result = -1;  // 用户未登录
        }

        resp.setContentType("application/json");
        resp.getWriter().write(String.valueOf(result));
    }
}
