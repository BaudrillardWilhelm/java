package com.qdu.servlet;

import com.qdu.dao.impl.RateDaoImpl;
import com.qdu.dao.impl.UserDaoImpl;
import com.qdu.model.Rate;
import com.qdu.model.Users;
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
 * 向UserRate_list_1.jsp发送 List<Rate>
 */
@WebServlet("/suars")
public class SearchUserAllRateServlet extends HttpServlet {

    private static final int COMMENTS_PER_PAGE = 4;
    DiaryService diaryService=new DiaryServiceImpl();
    UserDaoImpl userDao = new UserDaoImpl();
    RateDaoImpl rateDaoImpl = new RateDaoImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int uid=Integer.parseInt(req.getParameter("uid"));
        int page = req.getParameter("page") != null ? Integer.parseInt(req.getParameter("page")) : 1;

        Users user = userDao.findUserListById(uid);


        int offset = (page - 1) * COMMENTS_PER_PAGE;
        List<Rate> rateList = rateDaoImpl.findRateListByUidPaged(uid, offset, COMMENTS_PER_PAGE);
        int totalComments = rateDaoImpl.countRatesByUid(uid);
        int totalPages = (int) Math.ceil((double) totalComments / COMMENTS_PER_PAGE);

        //调用业务逻辑 ，完成请求处理
        //生成动态响应

        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.setAttribute("uid",uid);
        req.setAttribute("rateList", rateList);
        req.setAttribute("loggedUser",user);
        req.setAttribute("rateDaoImpl",rateDaoImpl);
        req.getRequestDispatcher("/UserRate_list_1.jsp").forward(req, resp);
    }
}
