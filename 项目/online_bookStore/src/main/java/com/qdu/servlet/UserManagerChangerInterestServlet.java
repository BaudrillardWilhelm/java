package com.qdu.servlet;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.qdu.dao.impl.InterestDaoImpl;
import com.qdu.dao.impl.UserDaoImpl;
import com.qdu.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
@WebServlet("/UserManagerChangerInterestServlet")
public class UserManagerChangerInterestServlet  extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String save_directory = lyyAjax.getInstance().getUrl();
        MultipartRequest mreq = new MultipartRequest(request,save_directory,1024*1024*10,"UTF-8");
        String[]receive = mreq.getParameterValues("Interest");
        InterestDaoImpl pushUse = new InterestDaoImpl();
        Interest pushInterest = new Interest();
        String uid=mreq.getParameter("uid");
        //先移除所有的感兴趣，然后再次添加
        pushUse.EarseAllInterestByUid(Integer.parseInt(uid));
        pushInterest.setUid(Integer.parseInt(uid));
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
        Map<String,Object>resultMap = new HashMap<>();
        resultMap.put("flag",true);
        Gson gson = new Gson();
        String result = gson.toJson(resultMap);
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().print(result);
    }
}
