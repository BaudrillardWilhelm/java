package com.qdu.servlet;

import com.qdu.dao.impl.AddressDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteAddressServlet")
public class DeleteAddressServlet extends HttpServlet {
    private AddressDaoImpl addressDao = new AddressDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int addressId = Integer.parseInt(req.getParameter("user_address_id"));
            int uid = Integer.parseInt(req.getParameter("uid"));
            int result = addressDao.removeAddress(uid,addressId);

            resp.getWriter().write(String.valueOf(result));
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("-1");
        }
    }
}
