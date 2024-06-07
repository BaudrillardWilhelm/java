package com.qdu.servlet;

import com.qdu.dao.impl.AddressDaoImpl;
import com.qdu.dao.impl.ShoppingCartDaoImpl;
import com.qdu.model.Address;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/clearCartServlet")
public class ClearCartServlet extends HttpServlet {

    private ShoppingCartDaoImpl cartDao = new ShoppingCartDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users loggedUser = (Users) req.getSession().getAttribute("LoggedUser");

        if (loggedUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int result = cartDao.clearCartByUserId(loggedUser.getUid());

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (result > 0) {
            resp.getWriter().write("{\"status\": \"success\"}");
        } else {
            resp.getWriter().write("{\"status\": \"error\"}");
        }
    }
}
