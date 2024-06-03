package com.qdu.servlet;

import com.qdu.dao.impl.AddressDaoImpl;
import com.qdu.dao.impl.Book_infoDaoImpl;
import com.qdu.dao.impl.OrderDaoImpl;
import com.qdu.model.Address;
import com.qdu.model.Book_info;
import com.qdu.model.Order;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;


/**
 * 前置是BookInfo的购买按钮，（购物车的立即支付按钮得另做一个给list的）
 * 后续是orderConfirm.jsp
 * 给后面1个 order对象，1个addressList
 * 如果查询到当前用户没设置地址，则跳转到noAddress.jsp
 */
@WebServlet("/ocs")
public class OrderConfirmServlet extends HttpServlet
{

    private OrderDaoImpl orderDaoImpl = new OrderDaoImpl();
    private Book_infoDaoImpl bookDaoImpl = new Book_infoDaoImpl();
    private AddressDaoImpl addressDaoImpl = new AddressDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        Users loggedUser = (Users) req.getSession().getAttribute("LoggedUser");

        if (loggedUser == null)
        {
            resp.sendRedirect("login.jsp");
            return;
        }

        try
        {
            int uid = loggedUser.getUid();
            int qty = Integer.parseInt(req.getParameter("qty"));
            int bid = Integer.parseInt(req.getParameter("bid"));
            double b_price = Double.parseDouble(req.getParameter("b_price"));

            // 查找图书信息
            Book_info book = bookDaoImpl.findBookById(bid);

            // 查找用户地址列表
            List<Address> addressList = addressDaoImpl.findAddressListById(String.valueOf(uid));

            if (addressList.isEmpty()) {
                resp.sendRedirect("noAddress.jsp");
                return;
            }

            // 取第一个地址作为默认地址
            Address defaultAddress = addressList.get(0);
            String AccurateAddress = defaultAddress.getProvince() + defaultAddress.getCity() + defaultAddress.getArea() + defaultAddress.getInfo();
            // 计算总价
            double sum_price = qty * b_price * book.getDiscount();
            // 创建订单对象
            Order order = new Order(
                    loggedUser.getUid(),
                    defaultAddress.getReceiver_name(),
                    AccurateAddress,
                    defaultAddress.getTel(),
                    defaultAddress.getPostal_code(),
                    new Date(),  // 当前时间
                    0,  // 默认订单类型为未送达
                    bid,    //book的id
                    book.getBName(),  // 图书名称
                    qty,
                    sum_price
            );
            req.setAttribute("order",order);
            req.setAttribute("addressList",addressList);
            req.getRequestDispatcher("/orderConfirm.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        doGet(req, resp);
    }
}
