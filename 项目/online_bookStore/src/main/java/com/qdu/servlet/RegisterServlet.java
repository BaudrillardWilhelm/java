package com.qdu.servlet;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.qdu.dao.impl.InterestDaoImpl;
import com.qdu.dao.impl.UserDaoImpl;
import com.qdu.model.Interest;
import com.qdu.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
@WebServlet("/rs")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String save_directory = "D:/java专用/A期末项目/项目/online_bookStore/src/main/webapp/ShowUserImage";
        MultipartRequest mreq = new MultipartRequest(request,save_directory,1024*1024*10,"UTF-8");
        UserDaoImpl uo = new UserDaoImpl();
        Map<String,Object> resultMap = new HashMap<>();

        long currentTimeMillis = System.currentTimeMillis();
        // 使用该毫秒值创建 Date 对象
        Date currentDate = new Date(currentTimeMillis);
        Users push = new Users(11,mreq.getParameter("userName"),mreq.getParameter("userPassword"),mreq.getParameter("userQuestion"),mreq.getParameter("userAnswer"),mreq.getParameter("userTrue_Name"),mreq.getParameter("userGender"),mreq.getParameter("userTel"),mreq.getParameter("userE_Mail"),mreq.getParameter("userCareer"),"",mreq.getParameter("userAddress"),0, currentDate);
        // 打印格式化后的日期和时间
        if(uo.PushNewUser(push))
        {
            int uidUse = uo.GetUidByUnameAndUpassword(mreq.getParameter("userName"),mreq.getParameter("userPassword"));
            if(uidUse == -1)
            {
                resultMap.put("RegisterTrue",false);
            }
            else
            {
                String[]receive = mreq.getParameterValues("Interest");
                Interest pushInterest = new Interest();
                pushInterest.setUid(uidUse);
                InterestDaoImpl pushUse = new InterestDaoImpl();
                for(String Interest : receive)
                {
                    if(Interest.equals("文学"))
                    {
                        pushInterest.setType_name("文学");
                        pushInterest.setType_id(1);
                    }
                    else if(Interest.equals("科幻"))
                    {
                        pushInterest.setType_name("科幻");
                        pushInterest.setType_id(2);
                    }
                    else if(Interest.equals("历史"))
                    {
                        pushInterest.setType_name("历史");
                        pushInterest.setType_id(8);
                    }
                    else if(Interest.equals("冒险"))
                    {
                        pushInterest.setType_name("冒险");
                        pushInterest.setType_id(6);
                    }
                    else if(Interest.equals("经典"))
                    {
                        pushInterest.setType_name("经典");
                        pushInterest.setType_id(3);
                    }
                    else if(Interest.equals("爱情"))
                    {
                        pushInterest.setType_name("爱情");
                        pushInterest.setType_id(4);
                    }
                    else if(Interest.equals("幻想"))
                    {
                        pushInterest.setType_name("幻想");
                        pushInterest.setType_id(12);
                    }
                    else if(Interest.equals("社会"))
                    {
                        pushInterest.setType_name("社会");
                        pushInterest.setType_id(5);
                    }
                    else if(Interest.equals("诗歌"))
                    {
                        pushInterest.setType_name("诗歌");
                        pushInterest.setType_id(9);
                    }
                    else if(Interest.equals("小说"))
                    {
                        pushInterest.setType_name("小说");
                        pushInterest.setType_id(7);
                    }
                    else if(Interest.equals("传记"))
                    {
                        pushInterest.setType_name("传记");
                        pushInterest.setType_id(13);
                    }
                    else if(Interest.equals("戏剧"))
                    {
                        pushInterest.setType_name("戏剧");
                        pushInterest.setType_id(11);
                    }
                    else if(Interest.equals("宗教"))
                    {
                        pushInterest.setType_name("宗教");
                        pushInterest.setType_id(10);
                    }
                    pushUse.addInterest((pushInterest));
                }
                resultMap.put("RegisterTrue",true);
                resultMap.put("uid",uidUse);
            }


        }
        else
        {
            resultMap.put("RegisterTrue",false);
        }
        Gson gson = new Gson();
        String result = gson.toJson(resultMap);
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().print(result);
    }
}
