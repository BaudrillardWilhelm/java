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
import java.util.Random;

@WebServlet("/addAddressServlet")
public class AddAddressServlet extends HttpServlet {
    private AddressDaoImpl addressDao = new AddressDaoImpl();

    public static int getRandomNum()
    {
        // 结合当前时间的毫秒和纳秒作为种子
        long seed = System.currentTimeMillis() * 1_000_000L + System.nanoTime();
        Random random = new Random(seed);

        // 如果你想要一个非负的随机整数，比如在一个特定的范围内
        int min = 0;
        int max = 99999999; // 假设我们想要一个在0到99之间的整数
        int randomIntInRange = random.nextInt(max - min + 1) + min;
        return randomIntInRange;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users loggedUser = (Users) req.getSession(false).getAttribute("LoggedUser");
        if (loggedUser == null) {
            resp.sendRedirect("Userlogin.jsp");
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

            int user_address_id = getRandomNum();



            Address address = new Address(uid, province, city, area, info, postalCode, receiverName, buyerTel, user_address_id);
            int result = addressDao.addAddress(address);
            if(result > 0 )
            {
                resp.getWriter().write(String.valueOf(result));
            }else if(result == 0){
                resp.getWriter().write("0");
            }else{
                resp.getWriter().write("-1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("-1");
        }
    }
}
