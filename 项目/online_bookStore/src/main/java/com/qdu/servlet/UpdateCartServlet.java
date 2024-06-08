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

/**
 * 前置是ManageCart.jsp
 * 用ajax返回
 *
 */
@WebServlet("/updateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String bid = request.getParameter("bid");
        int bid = Integer.parseInt(request.getParameter("bid"));
        int newQty = Integer.parseInt(request.getParameter("newQty"));
        Users loggedUser = (Users) request.getSession(false).getAttribute("LoggedUser");
        if (bid != 0 && newQty != 0) {
            try {
                ShoppingCartDaoImpl cartDao = new ShoppingCartDaoImpl();
                int uid = loggedUser.getUid();
                ShoppingCart cart = cartDao.getShoppingCart(uid,bid);

                if (cart != null) {
                    cart.setBookNum(newQty);
                    cart.setSum(cart.getPrice() * newQty);
                    cartDao.updateShoppingCart(cart);
                    response.getWriter().write("{\"status\": \"success\"}");
                } else {
                    response.getWriter().write("{\"status\": \"error\"}");
                }
            } catch (NumberFormatException e) {
                response.getWriter().write("{\"status\": \"error\"}");
            }
        } else {
            response.getWriter().write("{\"status\": \"error\"}");
        }
    }
}