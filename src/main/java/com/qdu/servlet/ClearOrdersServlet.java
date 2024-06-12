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
import java.io.PrintWriter;

@WebServlet("/clearOrdersServlet")
public class ClearOrdersServlet extends HttpServlet {

    OrderDaoImpl orderDao = new OrderDaoImpl();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users loggedUser = (Users) req.getSession(false).getAttribute("LoggedUser");

        if (loggedUser == null) {
            resp.sendRedirect("Userlogin.jsp");
            return;
        }

        int result = orderDao.clearOrder(loggedUser.getUid());

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        if (result  > 0) {
            out.write("{\"status\": 1}");
        } else {
            out.write("{\"status\": 0}");
        }
        out.flush();
        out.close();
    }
}
