package com.qdu.servlet.Impl;

import com.qdu.model.Product;
import com.qdu.servlet.CartServlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 点击“加入购物车”按钮，添加产品到购物车，该Servlet负责处理添加产品到购物车的请求
 * 
 * @author Anna
 */
@WebServlet("/cs")  //购物车 shopping cart
public class CartServletImpl extends HttpServlet implements CartServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //byte,short,int,long,float,double,boolean,char
        //Byte, Short, Integer, Long, Float, Double, Boolean, Character
        //1. 获取请求参数
        String proId = req.getParameter("proId");
        String proName = req.getParameter("proName");
        //Float类提供parseFloat()方法将String类型转换为float类型
        float proPrice = Float.parseFloat(req.getParameter("proPrice"));
        String proUnit = req.getParameter("proUnit");
        //Integer类提供parseInt()方法将String类型转换为int类型
        int qty = Integer.parseInt(req.getParameter("qty"));
        String proImg = req.getParameter("proImg");

        //为了方便维护购物车中的产品，加入购物车的每个产品现在有6项信息，可以将6个信息封装成一个Product对象
        Product p = new Product(proId, proName, proPrice, proUnit, qty, proImg);

        //2. 执行请求处理逻辑： 将当前产品添加到购物车中
        //为了模拟购物车功能，可以随时向购物车添加或删除产品，可以使用一个列表存储加入购物车的所有产品
        HttpSession session = req.getSession();

        //需要判断是否是第一次添加产品，如果是第一次，创建购物车列表，添加第一个产品
        //如果不是第一次添加产品，那么直接拿到购物车列表，继续添加产品
        List<Product> cart = null;

        //如果会话中名为cartList的属性的值为null，表示还没有将购物车列表添加到会话对象中
        if (null == session.getAttribute("cartList")) {
            //为了在会话期间可以随时访问购物车列表，向购物车列表添加产品或查看购物车列表
            //可以考虑将购物车列表放入会话对象，这样就可以在整个会话期间随时使用购物车列表
            cart = new ArrayList(); //创建购物车列表
            cart.add(p); //添加第一个产品到购物车列表
            session.setAttribute("cartList", cart); //将购物车列表加入会话对象中
        } else {
            //else说明不是第一次添加产品，会话中已经有购物车列表了，获得列表继续添加产品即可
            cart = (List<Product>)session.getAttribute("cartList");
            cart.add(p); //添加本次产品到购物车
        }

        //跳转到cart.jsp页面显示购物车列表
        //这里我们将购物车列表放入了会话对象，而不是请求对象，所以不需要转发请求，直接跳转页面即可
        resp.sendRedirect("cart.jsp");
    }
}
