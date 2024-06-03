package com.qdu.servlet;

import com.qdu.dao.impl.RateDaoImpl;
import com.qdu.model.Rate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 该Servlet负责处理发表新日志的请求
 *
 * @author Anna
 */
@WebServlet("/anrs")
public class AddNewRateServlet extends HttpServlet {
    RateDaoImpl rateDaoImpl = new RateDaoImpl();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        ///1. 获取请求参数
        req.setCharacterEncoding("utf-8");
        
        int uid =  Integer.parseInt(req.getParameter("uid"));
        int bid = Integer.parseInt(req.getParameter("bid"));
        double star = Double.parseDouble(req.getParameter("star"));
        String content = req.getParameter("content");
        //日志编号最好生成，这里是简单化，直接使用毫秒表示的当前时间作为日志编号
        int uidRateId= Integer.parseInt(System.currentTimeMillis()+"");


        //将一个日志的所有内容封装到一个Diary对象中，方便参数传递
//        Diary diary=new Diary(uidRateId, title, content, downer);
        Rate rate = new Rate(uid,bid,star,content,uidRateId);
        //调用给的逻辑，添加日志到数据库
//        diaryService.addNewDiary(diary);
        rateDaoImpl.addRate(rate);
        //这个Servlet处理的是ajax请求，这里没有返回任何数据
    }
}
