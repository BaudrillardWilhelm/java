package com.qdu.servlet;

import com.google.gson.Gson;
import com.qdu.dao.InterestDao;
import com.qdu.dao.UserDao;
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
        UserDao uo = new UserDaoImpl();
        // 从会话中获取用户数据
        HttpSession session = request.getSession(false); // 如果会话不存在，则返回null
        if (session != null) {
            Users user = (Users) session.getAttribute("LoggedUser");
            InterestDao io = new InterestDaoImpl();
            List<Interest>receive = io.findInterestListByUid(user.getUid());
            String[] temper = {"a","b","c","d","e","f","g","h","i","j","k","l","m"};
            Map<String,Object> resultMap = new HashMap<>();
            for(int i = 1;i<=13;i++)
            {
                if(!receive.isEmpty())
                {
                    if(receive.get(0).getType_id() == i)
                    {
                        resultMap.put(temper[i-1],true );
                        receive.remove(0);
                    }
                    else
                    {
                        resultMap.put(temper[i-1],false );
                    }
                }
                else
                {
                    resultMap.put(temper[i-1],false );
                }

            }
            if (user != null) {
                // 将用户数据转换为JSON并写入响应
                try {
                    resultMap.put("Uid",user.getUid());
                    resultMap.put("Uname",user.getUname());
                    resultMap.put("Upassword",user.getUpassword());
                    resultMap.put("uquestion",user.getUquestion());
                    resultMap.put("uanswer",user.getUanswer());
                    resultMap.put("true_name",user.getTrue_name());
                    resultMap.put("gender",user.getGender());
                    resultMap.put("Tel",user.getTel());
                    resultMap.put("e_mail",user.getE_mail());
                    resultMap.put("career",user.getCareer());
                    resultMap.put("address",user.getAddress());
                    resultMap.put("money",uo.GetMoney(String.valueOf(user.getUid())));
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
