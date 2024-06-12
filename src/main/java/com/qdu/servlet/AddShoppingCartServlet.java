package com.qdu.servlet;

import com.qdu.dao.impl.Book_infoDaoImpl;
import com.qdu.dao.impl.ShoppingCartDaoImpl;
import com.qdu.model.Book_info;
import com.qdu.model.ShoppingCart;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/AddShoppingCartServlet")
public class AddShoppingCartServlet extends HttpServlet {
    private ShoppingCartDaoImpl cartDao = new ShoppingCartDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users loggedUser = (Users) req.getSession(false).getAttribute("LoggedUser");
        Book_infoDaoImpl bookInfoDao = new Book_infoDaoImpl();
        if (loggedUser == null) {
            resp.getWriter().write("0");
            return;
        }

        try {
            int uid = loggedUser.getUid();
            int bid = Integer.parseInt(req.getParameter("bid"));
            Book_info book = bookInfoDao.findBookById(bid);
            List<ShoppingCart> cartList = cartDao.getAllShoppingCartsByUser(uid);

            boolean bookExists = false;
            ShoppingCart existingCart = null;
            for (ShoppingCart cart : cartList) {
                if (cart.getBid() == bid) {
                    bookExists = true;
                    existingCart = cart;
                    break;
                }
            }

            if (bookExists) {
                resp.getWriter().write("2," + existingCart.getBookName() + "," + existingCart.getBookNum() + "," + existingCart.getSum());
            } else {
                String bookName = book.getBName();
                Double price = book.getBPrice();
                String bookType = req.getParameter("type_name");
                int bookNum = Integer.parseInt(req.getParameter("qty"));
                Double sum = price * bookNum * book.getDiscount();

                ShoppingCart cart = new ShoppingCart(uid, bid, bookName, price, bookType, bookNum, sum);
                int result = cartDao.addShoppingCart(cart);

                resp.getWriter().write(String.valueOf(result));
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("-1");
        }
    }
}
