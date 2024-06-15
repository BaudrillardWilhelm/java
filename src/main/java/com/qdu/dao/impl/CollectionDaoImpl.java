package com.qdu.dao.impl;

import com.qdu.dao.CollectionDao;
import com.qdu.model.Collection;
import com.qdu.model.Rate;
import com.qdu.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CollectionDaoImpl implements CollectionDao {

    @Override
    public List<Collection> getCollectionsByUserId(int uid) {
        /**
         * 根据用户uid查询其收藏列表
         */
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Collection> collectionList = new ArrayList<>(); // Initialize the list

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * FROM collection where uid = ?");
            ps.setInt(1, uid);
            rs = ps.executeQuery();

            while (rs.next()) {
                Collection collection = new Collection(
                        rs.getInt("uid"),
                        rs.getInt("bid"),
                        rs.getString("book_name"),
                        rs.getDate("book_time"),
                        rs.getString("book_type")
                );
                collectionList.add(collection);
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex); // Throw exception instead of returning null
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
        return collectionList; // Return the list of collections
    }


    @Override
    public int addCollection(Collection collection) {
        /**
         * 添加收藏
         */
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0;

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("INSERT INTO collection (uid, bid, book_name, book_time, book_type) VALUES (?, ?, ?, ?, ?)");
            ps.setInt(1, collection.getUid());
            ps.setInt(2, collection.getBid());
            ps.setString(3, collection.getBook_name());
            ps.setObject(4, collection.getBook_time());
            ps.setString(5, collection.getBook_type());
            rowsAffected = ps.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException(ex); // Throw exception if SQL operation fails
        } finally {
            DatabaseUtil.close(null, ps, con);
        }
        return rowsAffected; // Return the number of rows affected
    }

    @Override
    public int removeCollection(int uid, int bid) {
        /**
         * 删一个收藏
         */
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0;

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("DELETE FROM collection WHERE uid = ? AND bid = ?");
            ps.setInt(1, uid);
            ps.setInt(2, bid);
            rowsAffected = ps.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException(ex); // Throw exception if SQL operation fails
        } finally {
            DatabaseUtil.close(null, ps, con);
        }
        return rowsAffected; // Return the number of rows affected
    }

    public int removeAllCollection(int uid)
    {
        /**
         * 清除所有收藏
         */
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0;

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("DELETE FROM collection WHERE uid = ?;");
            ps.setInt(1, uid);
            rowsAffected = ps.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException(ex); // Throw exception
        }finally {
            DatabaseUtil.close(null, ps, con);
        }
        return rowsAffected;
    }
}
