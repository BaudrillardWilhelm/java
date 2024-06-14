package com.qdu.dao.impl;

import com.qdu.dao.Book_infoDao;
import com.qdu.model.Book_info;
import com.qdu.model.Product;
import com.qdu.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
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

    /**
     * 获得库存数量
     * @return
     */
    public int getBookInventoryByBid(int bid)
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int result = 0;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select b_num from book_info where bid = ?");
            ps.setInt(1,bid);

            if (rs.next()) {
                result = rs.getInt(1);
                return result;
            }
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return result;
    }

    /**
     * 改书的数目的
     * @param newNum
     * @return
     */
    public int UpdateBookNum(int bid,int newNum) {
        int flag=1;
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DatabaseUtil.getConnection();
            // 构造SQL更新语句
            String sql = "UPDATE book_info SET b_num = ? WHERE bid = ?;";
            ps = con.prepareStatement(sql);
            ps.setInt(1, newNum);
            ps.setInt(2,bid);

            // 设置参数，注意这里假设Book_info类有相应的getter方法
            // 执行更新操作
            ps.executeUpdate();
            flag=1;
        } catch (SQLException e) {
            flag = -1;

        }finally {
            DatabaseUtil.close(null, ps, con); // 注意这里不需要ResultSet，所以是null
        }
        // 返回更新的行数，通常1表示成功更新了一行
        return flag;
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

    public List<Book_info> findBookByName(String keyword, int offset, int limit)
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Book_info where b_name like ?  LIMIT ? OFFSET ?;");
            ps.setString(1,"%"+keyword+"%");
            ps.setInt(2,limit);
            ps.setInt(3,offset);
            rs = ps.executeQuery();
            List<Book_info> book_info_name_list= new ArrayList<>();
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


    public List<Book_info> findBookByAuhor(String keyword, int offset, int limit)
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Book_info where author like ? LIMIT ? OFFSET ?;");
            ps.setString(1,"%"+keyword+"%");
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            rs = ps.executeQuery();
            List<Book_info> book_info_name_list= new ArrayList<>();
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
            ps.setInt(1,uid);
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


    public List<Book_info> findTopRatedBooks() {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Book_info> book_infoList=new ArrayList();
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("SELECT *   FROM Book_info   ORDER BY rate_number DESC   LIMIT 6;");
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

    public int UpdateBookRateNum(int bid) {
        int flag=1;
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DatabaseUtil.getConnection();
            // 构造SQL更新语句
            String sql = "UPDATE book_info bi  JOIN (SELECT bid, AVG(star) AS avg_star  FROM rate GROUP BY bid ) r ON bi.bid = r.bid  SET bi.rate_number = r.avg_star;";
            ps = con.prepareStatement(sql);

            // 设置参数，注意这里假设Book_info类有相应的getter方法
            // 执行更新操作
            ps.executeUpdate();
            flag=1;
        } catch (SQLException e) {
            flag = 0;
        }finally {
            DatabaseUtil.close(null, ps, con); // 注意这里不需要ResultSet，所以是null
        }
        // 返回更新的行数，通常1表示成功更新了一行
        return flag;
    }

    public int countBooksByNameAsKeyword(String keyword)
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = 0;
        try {
            con = DatabaseUtil.getConnection();
            String sql = "SELECT COUNT(*) AS total FROM book_info WHERE b_name like ? ;";
            ps = con.prepareStatement(sql);
            ps.setString(1,"%"+keyword+"%");
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // 异常处理，可以根据需要抛出自定义异常或返回零等
        }
        return count;
    }

    public int countBooksByAuthorAsKeyword(String keyword)
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = 0;
        try {
            con = DatabaseUtil.getConnection();
            String sql = "SELECT COUNT(*) AS total FROM book_info WHERE author like ? ;";
            ps = con.prepareStatement(sql);
            ps.setString(1,"%"+keyword+"%");
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // 异常处理，可以根据需要抛出自定义异常或返回零等
        }
        return count;
    }
}