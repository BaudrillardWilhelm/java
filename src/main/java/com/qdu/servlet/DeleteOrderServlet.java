package com.qdu.servlet;

import com.qdu.dao.impl.OrderDaoImpl;
import com.qdu.dao.impl.ShoppingCartDaoImpl;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteOrderServlet")
public class DeleteOrderServlet extends HttpServlet {

    OrderDaoImpl orderDao = new OrderDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users loggedUser = (Users) req.getSession(false).getAttribute("LoggedUser");
        if (loggedUser == null) {
            resp.sendRedirect("Userlogin.jsp");
            return;
        }

        try {
            int uid = loggedUser.getUid();
            int oid = Integer.parseInt(req.getParameter("oid"));
            int result = orderDao.removeOrder(uid,oid);

            resp.getWriter().write(String.valueOf(result));
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("-1");
        }
    }
}
