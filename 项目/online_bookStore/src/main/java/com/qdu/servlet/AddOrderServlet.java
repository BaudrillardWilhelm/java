package com.qdu.servlet;

import com.qdu.dao.impl.OrderDaoImpl;
import com.qdu.model.Order;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

/**
 * 前置是OneOrderConfirm.jsp
 * 是最后一步，这里完了这个订单就添加完成了
 * 用ajax
 * 处理就1个订单情况，多个时用AddManyOrdersServlet
 */

@WebServlet("/addOneOrder")
public class AddOrderServlet extends HttpServlet {

    private OrderDaoImpl orderDaoImpl = new OrderDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users loggedUser = (Users) req.getSession().getAttribute("LoggedUser");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        if (loggedUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            int uid = loggedUser.getUid();
            String receiverName = req.getParameter("receiverName");
            String buyerAddress = req.getParameter("buyerAddress");
            String buyerTel = req.getParameter("buyerTel");
            String postalCode = req.getParameter("postalCode");
            int bid = Integer.parseInt(req.getParameter("bid"));
            String bname = req.getParameter("bname");
            int bookNum = Integer.parseInt(req.getParameter("bookNum"));
            double sumPrice = Double.parseDouble(req.getParameter("sumPrice"));

            // 创建订单对象
            Order order = new Order(
                    uid,
                    receiverName,
                    buyerAddress,
                    buyerTel,
                    postalCode,
                    new Date(),
                    0,  // 默认订单类型为未送达
                    bid,
                    bname,
                    bookNum,
                    sumPrice
            );

            if(loggedUser.getMoney() < sumPrice)
            {
                resp.getWriter().write("{\"status\": \"insufficient_funds\"}");
                return;
            }


            // 插入订单到数据库
            int result = orderDaoImpl.addOrder(order);

            if (result > 0) {
                // 订单添加成功
                resp.getWriter().write("{\"status\": \"success\"}");
            } else {
                // 订单添加失败
                resp.getWriter().write("{\"status\": \"error\"}");
            }
        } catch (NumberFormatException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
