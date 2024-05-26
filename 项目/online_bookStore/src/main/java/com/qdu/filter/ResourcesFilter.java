/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.qdu.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author dell
 */
@WebFilter("/cart.jsp")
public class ResourcesFilter implements Filter
{
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
                //在该过滤器中，先拦截请求，判断用户是否登录
        //登陆了就放行请求资源，没登录就跳转到warning.html
//        可以直接输出
//        response.getWriter().println("<h1>您还未登录，请先登录！！！</h1>"); 
        //request.sendRedirect()方法是HttpServlet的，这里不是这个类型，暂不能用
        //先强转类型
        HttpServletRequest req=(HttpServletRequest)request;
        HttpServletResponse response_1=(HttpServletResponse)response;
        
        HttpSession session= req.getSession(false);
        if(null!=session && null!=session.getAttribute("isLogin"))
        {
            //已经登录
            chain.doFilter(request, response);
        }else{
            //如果没登录，跳转到warning.html页面提示用户
                    //如果发一个请求，这个请求的url是带前缀的，比如resources，那么重定向的时候，也会默认是这个前缀下的
        //退法：一：../
//                二：绝对路径
        String contextPath = req.getContextPath();
        String pathString=contextPath+"/warning.html";
        response_1.sendRedirect(pathString);
        }
    }
    
}
