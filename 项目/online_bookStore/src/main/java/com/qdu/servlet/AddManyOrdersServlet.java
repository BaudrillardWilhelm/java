package com.qdu.servlet;

import com.qdu.dao.impl.OrderDaoImpl;
import com.qdu.dao.impl.ShoppingCartDaoImpl;
import com.qdu.dao.impl.UserDaoImpl;
import com.qdu.model.Order;
import com.qdu.model.ShoppingCart;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 前置是ManyOrdersConfirm.jsp
 * 是最后一步，这里完了这个订单就添加完成了
 * 用ajax
 */

@WebServlet("/AddManyOrdersServlet")
public class AddManyOrdersServlet extends HttpServlet {

    private OrderDaoImpl orderDao = new OrderDaoImpl();
    private ShoppingCartDaoImpl cartDao = new ShoppingCartDaoImpl();
    private UserDaoImpl usersDao = new UserDaoImpl();  // 实例化UsersDaoImpl

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users loggedUser = (Users) req.getSession(false).getAttribute("LoggedUser");

        if (loggedUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        List<ShoppingCart> cartList = cartDao.getAllShoppingCartsByUser(loggedUser.getUid());
        double totalSum = 0;

        for (ShoppingCart cart : cartList) {
            totalSum += cart.getSum();
        }

        // 检查用户余额是否足够
        if (loggedUser.getMoney() < totalSum) {
            // 设置响应的内容类型为 JSON
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"status\": \"insufficient_funds\"}");
            return;
        }

        List<Order> orderList = new ArrayList<>();
        for (ShoppingCart cart : cartList) {
            Order order = new Order(
                    loggedUser.getUid(),
                    req.getParameter("receiverName"),
                    req.getParameter("buyerAddress"),
                    req.getParameter("buyerTel"),
                    req.getParameter("postalCode"),
                    new Date(),
                    0,  // 默认订单类型为未送达
                    cart.getBid(),
                    cart.getBookName(),
                    cart.getBookNum(),
                    cart.getSum()
            );
            orderList.add(order);
        }

        boolean allOrdersAdded = true;
        for (Order order : orderList) {
            int result = orderDao.addOrder(order);
            if (result <= 0) {
                allOrdersAdded = false;
                break;
            }
        }

        // 设置响应的内容类型为 JSON
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (allOrdersAdded) {
            // 扣除用户余额
            double newBalance = loggedUser.getMoney() - totalSum;
            loggedUser.setMoney(newBalance);

            usersDao.updateUser(loggedUser);  // 更新用户余额

            // 清空购物车
            cartDao.clearCartByUserId(loggedUser.getUid());

            resp.getWriter().write("{\"status\": \"success\"}");
        } else {
            resp.getWriter().write("{\"status\": \"error\"}");
        }
    }
}
