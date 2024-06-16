package com.qdu.servlet;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.qdu.dao.impl.UserDaoImpl;
import com.qdu.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
@WebServlet("/UserManagerRechargeServlet")
public class UserManagerRechargeServlet  extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String save_directory = lyyAjax.getInstance().getUrl();
        MultipartRequest mreq = new MultipartRequest(request,save_directory,1024*1024*10,"UTF-8");
        String uid=mreq.getParameter("uid");
        String money=mreq.getParameter("g");
        UserDaoImpl uo = new UserDaoImpl();
        Double a = Double.parseDouble(money);
        Double b = Double.parseDouble(uo.GetMoney(uid));
        Double c = a+b;
        String receive = String.valueOf(c);
        uo.ChangeMoney(uid, receive);
        Map<String,Object>resultMap = new HashMap<>();
        resultMap.put("flag",true);
        resultMap.put("money",uo.GetMoney(uid));
        Gson gson = new Gson();
        String result = gson.toJson(resultMap);
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().print(result);
    }
}
