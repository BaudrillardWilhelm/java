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
@WebServlet("/UserManagerChangeCareerServlet")
public class UserManagerChangeCareerServlet  extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String save_directory = lyyAjax.getInstance().getUrl();
        MultipartRequest mreq = new MultipartRequest(request,save_directory,1024*1024*10,"UTF-8");
        String uid=mreq.getParameter("uid");
        String Career=mreq.getParameter("g");
        UserDaoImpl uo = new UserDaoImpl();
        uo.ChangeCareer(uid, Career);
        Map<String,Object>resultMap = new HashMap<>();
        resultMap.put("flag",true);
        Gson gson = new Gson();
        String result = gson.toJson(resultMap);
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().print(result);
    }
}
