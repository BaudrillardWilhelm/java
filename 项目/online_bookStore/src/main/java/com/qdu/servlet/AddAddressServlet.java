package com.qdu.servlet;

import com.qdu.dao.impl.AddressDaoImpl;
import com.qdu.model.Address;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addAddressServlet")
public class AddAddressServlet extends HttpServlet {
    private AddressDaoImpl addressDao = new AddressDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users loggedUser = (Users) req.getSession(false).getAttribute("LoggedUser");
        if (loggedUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            int uid = loggedUser.getUid();
            String province = req.getParameter("province");
            String city = req.getParameter("city");
            String area = req.getParameter("area");
            String info = req.getParameter("info");
            String receiverName = req.getParameter("receiver_name");
            String buyerTel = req.getParameter("tel");
            String postalCode = req.getParameter("postal_code");

            Address address = new Address(uid, province, city, area, info, postalCode, receiverName, buyerTel, 0);
            int result = addressDao.addAddress(address);

            resp.getWriter().write(String.valueOf(result));
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("-1");
        }
    }
}
