package com.qdu.servlet;

import com.qdu.dao.impl.AddressDaoImpl;
import com.qdu.dao.impl.ShoppingCartDaoImpl;
import com.qdu.model.Address;
import com.qdu.model.ShoppingCart;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/manyOrdersConfirmServlet")
public class ManyOrdersConfirmServlet extends HttpServlet {
    ShoppingCartDaoImpl cartDao = new ShoppingCartDaoImpl();
    AddressDaoImpl addressDao = new AddressDaoImpl();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Users loggedUser = (Users) session.getAttribute("LoggedUser");

        if (loggedUser != null) {

            int uid = loggedUser.getUid();
            List<Address> addressList = addressDao.findAddressListById(uid);
            List<ShoppingCart> cartList = cartDao.getAllShoppingCartsByUser(loggedUser.getUid());

            request.setAttribute("defaultAddress",addressList.get(0));
            request.setAttribute("addressList",addressList);
            request.setAttribute("cartList",cartList);
            request.getRequestDispatcher("/ManyOrdersConfirm.jsp").forward(request, response);
        } else {
                response.sendRedirect("/Userlogin.jsp"); // 如果用户未登录，重定向到登录页面
        }
    }
}
