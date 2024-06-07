package com.qdu.servlet;

import com.qdu.dao.impl.ShoppingCartDaoImpl;
import com.qdu.model.ShoppingCart;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AddShoppingCartServlet")
public class AddShoppingCartServlet extends HttpServlet {
    private ShoppingCartDaoImpl cartDao = new ShoppingCartDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users loggedUser = (Users) req.getSession().getAttribute("LoggedUser");
        if (loggedUser == null) {
            resp.getWriter().write("0");
            return;
        }

        try {
            int uid = loggedUser.getUid();
            int bid = Integer.parseInt(req.getParameter("bid"));
            String bookName = req.getParameter("bookName");
            double price = Double.parseDouble(req.getParameter("b_price"));
            String bookType = req.getParameter("bookType");
            int bookNum = Integer.parseInt(req.getParameter("qty"));
            double sum = price * bookNum;

            ShoppingCart cart = new ShoppingCart(uid, bid, bookName, price, bookType, bookNum, sum);
            int result = cartDao.addShoppingCart(cart);

            resp.getWriter().write(String.valueOf(result));
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("-1");
        }
    }
}
