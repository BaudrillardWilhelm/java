package com.qdu.servlet;

import com.qdu.dao.impl.Book_infoDaoImpl;
import com.qdu.dao.impl.CollectionDaoImpl;
import com.qdu.dao.impl.InterestDaoImpl;
import com.qdu.dao.impl.UserDaoImpl;
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


/**
 * 这个前置是BookInfo.jsp
 * 用的ajax，返回操作是否成功
 * 返回0是没找到操作
 * 返回-1是操作失败
 * 从session中拿loggedUser
 * 从  前置 拿：action，操作
 *            bid
 *
 */
@WebServlet("/collection")
public class CollectionServlet extends HttpServlet {

    private CollectionDaoImpl collectionDaoImpl = new CollectionDaoImpl();
    Book_infoDaoImpl bookInfoDao = new Book_infoDaoImpl();
    InterestDaoImpl interestDao = new InterestDaoImpl();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users loggedUser = (Users) req.getSession().getAttribute("LoggedUser");
        int result = 0;

        String action = req.getParameter("action");
        int bid = Integer.parseInt(req.getParameter("bid"));
        if (loggedUser != null) {

            int uid = loggedUser.getUid();
            Date currentDate = new Date(); // 获取当前日期和时间
            Book_info book = bookInfoDao.findBookById(bid);
            //我这里是想要通过interestDao获得对应interest的中文名，用String装起来
            int TypeId = book.getTypeId();;
            String bookType = interestDao.findInterestChineseNameByUid(uid,TypeId);

            switch (action) {
                case "collect":
                    Collection collection = new Collection(uid, bid, book.getBName(), currentDate,bookType );
                    result = collectionDaoImpl.addCollection(collection);
                    break;
                case "remove":
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
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        out.write(String.valueOf(result));
        out.close();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);

    }
}
