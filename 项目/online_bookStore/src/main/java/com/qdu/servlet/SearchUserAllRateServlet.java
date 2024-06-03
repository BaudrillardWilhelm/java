package com.qdu.servlet;

import com.qdu.dao.impl.RateDaoImpl;
import com.qdu.model.Rate;
import com.qdu.service.DiaryService;
import com.qdu.service.impl.DiaryServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * 用于搜索用户所有评论，需要获得一个int uid
 * 向UserRate_list.jsp发送 List<Rate>
 */
@WebServlet("/suars")
public class SearchUserAllRateServlet extends HttpServlet {

    DiaryService diaryService=new DiaryServiceImpl();
    RateDaoImpl rateDaoImpl = new RateDaoImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int uid=Integer.parseInt(req.getParameter("uid"));
        //调用业务逻辑 ，完成请求处理
        List<Rate> rateList = rateDaoImpl.findRateListByUserId(uid);
        //生成动态响应
        req.setAttribute("rateList", rateList);
        req.getRequestDispatcher("/UserRate_list.jsp").forward(req, resp);
    }
}
