package com.qdu.servlet;

import com.google.gson.Gson;
import com.qdu.dao.InterestDao;
import com.qdu.dao.impl.InterestDaoImpl;
import com.qdu.dao.impl.UserDaoImpl;
import com.qdu.model.Interest;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/ums")
public class UserManagerServlet  extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应内容类型为JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 从会话中获取用户数据
        HttpSession session = request.getSession(false); // 如果会话不存在，则返回null
        if (session != null) {
            Users user = (Users) session.getAttribute("LoggedUser");
            InterestDao io = new InterestDaoImpl();
            List<Interest>receive = io.findInterestListByUid(user.getUid());
            Map<String,Boolean>receiveBack = new HashMap<>();
            for(int i = 0;i<receive.size();i++)
            {
                receiveBack.put(receive.get(i).getType_name(),true);
            }
            if (user != null) {
                // 将用户数据转换为JSON并写入响应
                try {
                    Map<String,Object> resultMap = new HashMap<>();
                    resultMap.put("Uid",user.getUid());
                    resultMap.put("Uname",user.getUname());
                    resultMap.put("Upassword",user.getUpassword());
                    resultMap.put("uquestion",user.getUquestion());
                    resultMap.put("uanswer",user.getUanswer());
                    resultMap.put("true_name",user.getTrue_name());
                    resultMap.put("gender",user.getGender());
                    resultMap.put("tel",user.getTel());
                    resultMap.put("e_mail",user.getE_mail());
                    resultMap.put("career",user.getCareer());
                    resultMap.put("interest",receiveBack);
                    resultMap.put("address",user.getAddress());
                    resultMap.put("money",user.getMoney());
                    resultMap.put("registration_time",user.getRegistration_time());
                    Gson gson = new Gson();
                    String result = gson.toJson(resultMap);
                    response.getWriter().write(result);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else {
                // 用户数据不存在，可以返回一个错误或空JSON对象
                response.getWriter().write("{}");
            }
        }
    }
}
