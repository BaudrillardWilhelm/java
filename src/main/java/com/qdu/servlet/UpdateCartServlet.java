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
        int bid = Integer.parseInt(request.getParameter("bid"));
        int newQty = Integer.parseInt(request.getParameter("newQty"));
        Users loggedUser = (Users) request.getSession(false).getAttribute("LoggedUser");
        response.setContentType("application/json;charset=utf-8");        //添加这句话会让这部分程序正确运行，但是返回的response接收方接收不到
        if (bid != 0 && newQty != 0) {
            try {
                ShoppingCartDaoImpl cartDao = new ShoppingCartDaoImpl();
                int uid = loggedUser.getUid();
                ShoppingCart cart = cartDao.getShoppingCart(uid,bid);

                if (cart != null) {
                    cart.setBookNum(newQty);
                    cart.setSum(cart.getPrice() * newQty);
                    cartDao.updateShoppingCart(cart);
                    response.getWriter().print("{\"status\": \"success\"}");
                } else {
                    response.getWriter().print("{\"status\": \"false\"}");
                }
            } catch (NumberFormatException e) {
                response.getWriter().print("{\"status\": \"error\"}");
            }
        } else {
            response.getWriter().write("{\"status\": \"error\"}");
        }
    }
}