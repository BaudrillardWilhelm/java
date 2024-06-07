package com.qdu.servlet;

import com.qdu.dao.impl.ShoppingCartDaoImpl;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteCartServlet")
public class DeleteCartServlet extends HttpServlet {
    private ShoppingCartDaoImpl cartDao = new ShoppingCartDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users loggedUser = (Users) req.getSession(false).getAttribute("LoggedUser");
        if (loggedUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            int uid = loggedUser.getUid();
            int bid = Integer.parseInt(req.getParameter("bid"));
            int result = cartDao.removeShoppingCart(uid, bid);

            resp.getWriter().write(String.valueOf(result));
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("-1");
        }
    }
}
