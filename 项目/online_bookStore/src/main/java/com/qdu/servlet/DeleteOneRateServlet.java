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

/**
 * 处理查询所有日志基本信息请求的Servlet
 *
 * @author Anna
 */
@WebServlet("/DeleteOneRateServlet")
public class DeleteOneRateServlet extends HttpServlet {
    RateDaoImpl rateDaoImpl = new RateDaoImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        
        int uidRateId = Integer.parseInt(req.getParameter("uidRateId"));
        //这里的did实际上就是uidRateId
        int uid = Integer.parseInt(req.getParameter("uid"));
        int bid = Integer.parseInt(req.getParameter("bid"));
        //调用业务逻辑 ，完成请求处理
        int result = rateDaoImpl.deleteRate(uid,bid,uidRateId);
        //生成动态响应
        req.setAttribute("rate",result);
        req.getRequestDispatcher("/UserRate_list.jsp").forward(req, resp);
    }
}
