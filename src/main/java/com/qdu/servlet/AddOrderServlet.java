package com.qdu.servlet;

import com.qdu.dao.impl.Book_infoDaoImpl;
import com.qdu.dao.impl.OrderDaoImpl;
import com.qdu.dao.impl.UserDaoImpl;
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

/**
 * 前置是OneOrderConfirm.jsp
 * 是最后一步，这里完了这个订单就添加完成了
 * 用ajax
 * 处理就1个订单情况，多个时用AddManyOrdersServlet
 */

@WebServlet("/addOneOrder")
public class AddOrderServlet extends HttpServlet {

    private OrderDaoImpl orderDaoImpl = new OrderDaoImpl();
    Book_infoDaoImpl bookInfoDao = new Book_infoDaoImpl();

    UserDaoImpl userDao = new UserDaoImpl();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users loggedUser = (Users) req.getSession(false).getAttribute("LoggedUser");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        if (loggedUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            int uid = loggedUser.getUid();
            String receiverName = req.getParameter("receiver_name");
            String buyerAddress = req.getParameter("buyer_address");
            String buyerTel = req.getParameter("buyer_tel");
            String postalCode = req.getParameter("postal_code");
            int bid = Integer.parseInt(req.getParameter("bid"));
            String bname = req.getParameter("b_name");
            int bookNum = Integer.parseInt(req.getParameter("book_num"));
            double sumPrice = Double.parseDouble(req.getParameter("sum_price"));

            double a = loggedUser.getMoney();

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

            //检查钱够不够
            if(loggedUser.getMoney() < sumPrice)
            {
                resp.getWriter().write("{\"status\": \"insufficient_funds\"}");
                return;
            }

            //更新书的数目
            Book_info book_info = bookInfoDao.findBookById(bid);

            int b = book_info.getBNum();

            if(book_info.getBNum() <= bookNum)
            {
                resp.getWriter().write("{\"status\": \"bookNumFalse\"}");
                return;
            }

            int result_book = bookInfoDao.UpdateBookNum(bid,book_info.getBNum() - bookNum);
            if(result_book == 0) {
                resp.getWriter().write("{\"status\": \"bookNumFalse\"}");
//                return;
            } else{
                int result_money = userDao.UpdateUserMoneyByUid(uid,loggedUser.getMoney() - sumPrice);
                if( result_money == -1  || result_money == 0)
                {
                    resp.getWriter().write("{\"status\": \"Change_money_failed\"}");     //数据库报错
//                    return;
                }else {
                    // 插入订单到数据库
                    int result = orderDaoImpl.addOrder(order);

                    if (result > 0) {
                        // 订单添加成功
                        resp.getWriter().write("{\"status\": \"success\"}");

                    } else {
                        // 订单添加失败
                        resp.getWriter().write("{\"status\": \"error\"}");
                    }
                }

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
