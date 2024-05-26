package com.qdu.dao.impl;

import com.qdu.dao.ProductDao;
import com.qdu.model.Product;
import com.qdu.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Dao类-数据访问对象类，专门用于访问数据库中的表ProductDao包含方法用于对Product表执行增删改查
 * @author Anna
 */ 
public class ProductDaoImpl implements ProductDao {

    /**
     * 查询所有产品的列表
     * @return 产品列表
     */
    public List<Product> getProductList() {

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Product> productList=new ArrayList();

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Product");
            rs = ps.executeQuery();

            while (rs.next()) {
                productList.add(new Product(rs.getString(1),rs.getString(2),rs.getFloat(3),rs.getString(4),rs.getInt(5),rs.getString(6)));
            } 
            return productList;
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return null;
    }
    
    /**
     * 根据产品编号查询产品信息
     * @param productId 字符串表示的产品编号
     * @return 包含产品所有信息的一个Product对象，如果没有查询到该产品，则返回null
     */
    public Product findProductById(String productId) {

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Product where productId=?");
            ps.setString(1, productId);
            rs = ps.executeQuery();

            if (rs.next()) {
                return new Product(rs.getString(1),rs.getString(2),rs.getFloat(3),rs.getString(4),rs.getInt(5),rs.getString(6));
            } 
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return null;
    }
}
