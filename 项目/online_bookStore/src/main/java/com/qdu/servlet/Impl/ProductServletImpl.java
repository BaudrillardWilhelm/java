package com.qdu.servlet.Impl;

import com.qdu.dao.impl.ProductDaoImpl;
import com.qdu.model.Product;
import com.qdu.servlet.ProductServlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 该Servlet处理根据产品编号查询产品的请求,然后将查询出来的产品信息交给productInfo.jsp显示
 *
 * @author Anna
 */
@WebServlet("/ps")
public class ProductServletImpl extends HttpServlet implements ProductServlet {
     
    ProductDaoImpl productDaoImpl =new ProductDaoImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //1. 获取请求参数
        String pid=req.getParameter("pid");
        
        //2. 执行请求的处理逻辑：根据产品编号查询产品的详细信息
        //调用ProductDao的findProductById()方法根据产品编号查询产品的所有信息，以一个Product对象返回
        Product p= productDaoImpl.findProductById(pid);
        
        //3. 显示响应内容
        //将查到的数据共享给productInfo.jsp页面显示
        //如果希望将一个Servlet(A)产生的数据共享给下个组件（servlet或jsp，叫B）
        //那么可以将产生的数据作为属性添加到请求对象中，然后将请求对象转发给下个组件
        //这样两个组件处理的是同一个请求对象
        //A转发请求给B，整个过程只有一个请求对象和一个响应对象
        
        //这里将查到的产品对象作为一个属性添加到请求对象
        req.setAttribute("product", p);
        
        //转发当前请求和当前响应给productInfo.jsp页面
        //这里实现了页面跳转，跳转到指定productInfo.jsp页面，并且将请求对象和响应对象转发给了它
        req.getRequestDispatcher("/productInfo.jsp").forward(req, resp);
    }
}
