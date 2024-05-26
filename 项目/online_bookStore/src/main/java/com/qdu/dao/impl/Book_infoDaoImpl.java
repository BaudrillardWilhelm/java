package com.qdu.dao.impl;

import com.qdu.dao.Book_infoDao;
import com.qdu.model.Book_info;
import com.qdu.model.Product;
import com.qdu.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

public class Book_infoDaoImpl implements Book_infoDao {
    public Book_infoDaoImpl() {
    }

    /**
     * 查询所有书信息的列表
     * @return 书信息列表
     */
    public List<Book_info> getBook_infoList()
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Book_info> book_infoList=new ArrayList();
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Book_info");
            rs = ps.executeQuery();

            while (rs.next()) {
                Book_info book_info = new Book_info(
                        rs.getInt(1),                 // bid
                        rs.getString(2),              // b_name
                        rs.getDouble(3),              // b_price
                        rs.getInt(4),                 // b_num
                        rs.getString(5),              // b_imgpath
                        rs.getInt(6),                 // type_id
                        rs.getString(7),              // publisher（注意索引可能需要调整，因为您只提供了6个参数）
                        // 这里假设b_time是Timestamp类型，并且您想将其转换为java.util.Date
                        rs.getDate(8),
                        rs.getInt(9),                 // rate_number
                        rs.getString(10),             // author（注意索引可能需要调整，因为您只提供了9个参数）
                        rs.getDate(11),
                        // storage_time的处理方式与b_time类似
                        rs.getString(12),             // b_info（注意索引可能需要调整，因为您只提供了10个参数）
                        rs.getDouble(13)              // discount（注意索引可能需要调整，因为您只提供了11个参数）
                );
                book_infoList.add(book_info);
            }
            return book_infoList;
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return null;
    }

    @Override
    public Book_info findBookById(int bid)
    {
        /*
        精确搜索，根据书id搜索
         */
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Book_info where bid = ?");
            ps.setInt(1,bid);
            rs = ps.executeQuery();
            Book_info book_info=null;
            if (rs.next()) {
                book_info = new Book_info(
                        rs.getInt(1),                 // bid
                        rs.getString(2),              // b_name
                        rs.getDouble(3),              // b_price
                        rs.getInt(4),                 // b_num
                        rs.getString(5),              // b_imgpath
                        rs.getInt(6),                 // type_id
                        rs.getString(7),              // publisher（注意索引可能需要调整，因为您只提供了6个参数）
                        // 这里假设b_time是Timestamp类型，并且您想将其转换为java.util.Date
                        rs.getDate(8),
                        rs.getInt(9),                 // rate_number
                        rs.getString(10),             // author（注意索引可能需要调整，因为您只提供了9个参数）
                        // storage_time的处理方式与b_time类似
                        rs.getDate(11),
                        rs.getString(12),             // b_info（注意索引可能需要调整，因为您只提供了10个参数）
                        rs.getDouble(13)              // discount（注意索引可能需要调整，因为您只提供了11个参数）
                );
            }
            return book_info;
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return null;
    }

    public List<Book_info> findBookByName(String keyword)
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Book_info where b_name like ?");
            ps.setString(1,keyword);
            rs = ps.executeQuery();
            List<Book_info> book_info_name_list=null;
            while (rs.next()) {
                Book_info book_info = new Book_info(
                        rs.getInt(1),                 // bid
                        rs.getString(2),              // b_name
                        rs.getDouble(3),              // b_price
                        rs.getInt(4),                 // b_num
                        rs.getString(5),              // b_imgpath
                        rs.getInt(6),                 // type_id
                        rs.getString(7),              // publisher（注意索引可能需要调整，因为您只提供了6个参数）
                        // 这里假设b_time是Timestamp类型，并且您想将其转换为java.util.Date
                        rs.getDate(8),
                        rs.getInt(9),                 // rate_number
                        rs.getString(10),             // author（注意索引可能需要调整，因为您只提供了9个参数）
                        // storage_time的处理方式与b_time类似
                        rs.getDate(11),
                        rs.getString(12),             // b_info（注意索引可能需要调整，因为您只提供了10个参数）
                        rs.getDouble(13)              // discount（注意索引可能需要调整，因为您只提供了11个参数）
                );
                book_info_name_list.add(book_info);
            }
            return book_info_name_list;
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return null;
    }

    public List<Book_info> findRecommendedBookByUid(int uid)
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Book_info> book_infoList=new ArrayList();
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("SELECT book_info.*  FROM book_info  JOIN interest ON book_info.type_id = interest.type_id  WHERE interest.uid = ?;");
            rs = ps.executeQuery();

            while (rs.next()) {
                Book_info book_info = new Book_info(
                        rs.getInt(1),                 // bid
                        rs.getString(2),              // b_name
                        rs.getDouble(3),              // b_price
                        rs.getInt(4),                 // b_num
                        rs.getString(5),              // b_imgpath
                        rs.getInt(6),                 // type_id
                        rs.getString(7),              // publisher（注意索引可能需要调整，因为您只提供了6个参数）
                        // 这里假设b_time是Timestamp类型，并且您想将其转换为java.util.Date
                        rs.getDate(8),
                        rs.getInt(9),                 // rate_number
                        rs.getString(10),             // author
                        // storage_time的处理方式与b_time类似
                        rs.getDate(11),
                        rs.getString(12),             // b_info
                        rs.getDouble(13)              // discount
                );
                book_infoList.add(book_info);
            }
            return book_infoList;
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return null;
    }
}