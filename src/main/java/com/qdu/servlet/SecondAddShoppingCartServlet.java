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

@WebServlet("/SecondAddShoppingCartServlet")
public class SecondAddShoppingCartServlet extends HttpServlet {
    private ShoppingCartDaoImpl cartDao = new ShoppingCartDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        Users loggedUser = (Users) req.getSession(false).getAttribute("LoggedUser");
        Book_infoDaoImpl bookInfoDao = new Book_infoDaoImpl();
        if (loggedUser == null) {
            resp.getWriter().write("0");
            return;
        }

        try
        {
            int uid = loggedUser.getUid();
            int bid = Integer.parseInt(req.getParameter("bid"));
            ShoppingCart oldCart = cartDao.getShoppingCart(uid,bid);
            Book_info book = bookInfoDao.findBookById(bid);
                int bookNum = Integer.parseInt(req.getParameter("qty"));
                int NewBookNum = bookNum + oldCart.getBookNum();
                Double sum = oldCart.getPrice() * bookNum * book.getDiscount();
                oldCart.setSum(sum);
                oldCart.setBookNum(NewBookNum);
                int result = cartDao.updateShoppingCart(oldCart);

                resp.getWriter().write(String.valueOf(result));
        } catch (Exception e)
        {
            e.printStackTrace();
            resp.getWriter().write("-1");
        }
    }
}
