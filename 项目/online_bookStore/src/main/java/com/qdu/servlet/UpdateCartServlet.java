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
        String bid = request.getParameter("bid");
        String newQtyStr = request.getParameter("newQty");

        if (bid != null && newQtyStr != null) {
            try {
                int newQty = Integer.parseInt(newQtyStr);
                ShoppingCartDaoImpl cartDao = new ShoppingCartDaoImpl();
                ShoppingCart cart = cartDao.getCartByBid(Integer.parseInt(bid));

                if (cart != null) {
                    cart.setBookNum(newQty);
                    cart.setSum(cart.getPrice() * newQty);
                    cartDao.updateCart(cart);
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