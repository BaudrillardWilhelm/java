package com.qdu.servlet;

import com.qdu.dao.impl.Book_infoDaoImpl;
import com.qdu.dao.impl.OrderDaoImpl;
import com.qdu.model.Book_info;
import com.qdu.model.Order;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ReturnOrderServlet")
public class ReturnOrderServlet extends HttpServlet {

    OrderDaoImpl orderDao = new OrderDaoImpl();
    Book_infoDaoImpl bookInfoDao = new Book_infoDaoImpl();
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
            Order order = orderDao.getOrderByUidOid(uid,oid);
            int bid = order.getBid();


            Book_info book  = bookInfoDao.findBookById(bid);
            int newNum = book.getBNum() + order.getBook_num();

            int result_UpdateBookNum = bookInfoDao.UpdateBookNum(bid,newNum);
            int result_ReturnOrder = orderDao.ReturnOrder(uid,oid);

            int result = ( result_ReturnOrder & result_UpdateBookNum);
            resp.getWriter().write(String.valueOf(result));
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("-1");
        }
    }
}
