package com.qdu.servlet;

import com.qdu.dao.impl.Book_infoDaoImpl;
import com.qdu.dao.impl.RateDaoImpl;
import com.qdu.model.Book_info;
import com.qdu.model.Rate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 该Servlet负责处理发表新评论的请求
 */
@WebServlet("/anrs")
public class AddNewRateServlet extends HttpServlet {
    RateDaoImpl rateDaoImpl = new RateDaoImpl();
    Book_infoDaoImpl  book_infoDao = new Book_infoDaoImpl();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 获取请求参数并设置字符编码
        req.setCharacterEncoding("utf-8");

        try {
            int uid = Integer.parseInt(req.getParameter("uid"));
            int bid = Integer.parseInt(req.getParameter("bid"));
            double star = Double.parseDouble(req.getParameter("star"));
            String content = req.getParameter("content");

            // 日志编号最好生成，这里简单化，直接使用毫秒表示的当前时间作为日志编号
            long currentTimeMillis = System.currentTimeMillis();
            int uidRateId = (int) (currentTimeMillis % Integer.MAX_VALUE);

            // 将一个评论的所有内容封装到一个Rate对象中，方便参数传递
            Rate rate = new Rate(uid, bid, star, content, uidRateId);

            Book_info book = book_infoDao.findBookById(bid);
            int result_rateNum = book_infoDao.UpdateBookRateNum(bid);
            if(result_rateNum == 0)
            {
                resp.getWriter().write("{\"message\":\"本书评分更新失败！\"}");
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
            // 调用逻辑，将评论添加到数据库
            int success = rateDaoImpl.addRate(rate);

            // 设置响应类型为JSON
            resp.setContentType("application/json");
            resp.setCharacterEncoding("utf-8");

            // 发送响应
            if (success > 0) {
                resp.getWriter().write("{\"message\":\"发表成功！\"}");
                resp.setStatus(HttpServletResponse.SC_OK);
            } else {
                resp.getWriter().write("{\"message\":\"发表失败！请稍后再试。\"}");
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } catch (NumberFormatException e) {
            resp.getWriter().write("{\"message\":\"输入数据格式有误。\"}");
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            resp.getWriter().write("{\"message\":\"服务器内部错误。\"}");
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
