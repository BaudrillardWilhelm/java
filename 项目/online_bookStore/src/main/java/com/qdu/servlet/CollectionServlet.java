package com.qdu.servlet;

import com.qdu.dao.impl.CollectionDaoImpl;
import com.qdu.model.Collection;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/collection")
public class CollectionServlet extends HttpServlet {

    private CollectionDaoImpl collectionDaoImpl = new CollectionDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        Users loggedUser = (Users) req.getSession().getAttribute("LoggedUser");
        int result = 0;

        if (loggedUser != null) {
            int uid = loggedUser.getUid();
            int bid = Integer.parseInt(req.getParameter("bid"));

            switch (action) {
                case "collect":
                    Collection collection = new Collection(uid, bid, req.getParameter("book_name"), null, req.getParameter("book_type"));
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
