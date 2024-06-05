package com.qdu.dao.impl;

import com.qdu.dao.RateDao;
import com.qdu.model.Address;
import com.qdu.model.Rate;
import com.qdu.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RateDaoImpl implements RateDao {

    @Override
    public List<Rate> getAllRateList() {
        /*
            获取所有评论
         */
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Rate> rate_List=null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from rate");
            rs = ps.executeQuery();

            while (rs.next()) {
                Rate rate = new Rate(
                        rs.getInt(1),      // 假设第一列是uid
                        rs.getInt(2),      // 假设第二列是bid
                        rs.getDouble(3),  // 假设第十列是star
                        rs.getString(4),   // 假设第五列是info
                        rs.getInt(5)       // 假设第九列是uidRateId
                );

                rate_List.add(rate);
            }
            return rate_List;
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return null;
    }

    @Override
    public List<Rate> findRateListByUserId(int uid) {
        /*
            获取用户个人所有评论
         */
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Rate> rate_List=null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from rate where uid = ?");
            ps.setInt(1, uid); // 将参数 uid 设置为第一个问号的值
            rs = ps.executeQuery();

            while (rs.next()) {
                Rate rate = new Rate(
                        rs.getInt(1),      // 假设第一列是uid
                        rs.getInt(2),      // 假设第二列是bid
                        rs.getDouble(3),  // 假设第十列是star
                        rs.getString(4),   // 假设第五列是info
                        rs.getInt(5)       // 假设第九列是uidRateId
                );

                rate_List.add(rate);
            }
            return rate_List;
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return null;
    }

    @Override
    public List<Rate> findRateListByBookId(int bid) {
        /*
            获取对这个图书的所有评论
         */
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Rate> rate_List=null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from rate where bid = ?");
            ps.setInt(1, bid); // 将参数 uid 设置为第一个问号的值
            rs = ps.executeQuery();

            while (rs.next()) {
                Rate rate = new Rate(
                        rs.getInt(1),      // 假设第一列是uid
                        rs.getInt(2),      // 假设第二列是bid
                        rs.getDouble(3),  // 假设第十列是star
                        rs.getString(4),   // 假设第五列是info
                        rs.getInt(5)       // 假设第九列是uidRateId
                );

                rate_List.add(rate);
            }
            return rate_List;
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return null;
    }

    public int alterRate(int uid,int bid,int uidRateId,double newStar,String newInfo) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int rowsAffected = 0; // 用于记录受影响的行数
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("UPDATE rate SET star = ?, info = ? WHERE uid = ? AND bid = ? AND uidRateId = ?");
            ps.setDouble(1, newStar); // 将新的 star 值设置为第一个问号的值
            ps.setString(2, newInfo); // 将新的 info 值设置为第二个问号的值
            ps.setInt(3, uid); // 将 uid 设置为第三个问号的值
            ps.setInt(4, bid); // 将 bid 设置为第四个问号的值
            ps.setInt(5, uidRateId); // 将 uidRateId 设置为第五个问号的值
            rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) { // 如果更新了至少一行
                return 1;
            } else { // 如果没有更新任何行
                return 0;
            }

        }
        catch (SQLException e) { // 捕获数据库异常
            e.printStackTrace();
            return -1;
        }finally{
            DatabaseUtil.close(rs,ps,con);
        }
    }

    public int deleteRate(int uid, int bid, int uidRateId) {
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0; // 用于记录受影响的行数

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("DELETE FROM rate WHERE uid = ? AND bid = ? AND uidRateId = ?");
            ps.setInt(1, uid);
            ps.setInt(2, bid);
            ps.setInt(3, uidRateId);
            rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) { // 如果删除了至少一行
                return 1;
            } else { // 如果没有删除任何行
                return 0;
            }
        } catch (SQLException e) { // 捕获数据库异常
            e.printStackTrace();
            return -1;
        } finally {
            DatabaseUtil.close(null, ps, con);
        }
    }

    public int addRate(Rate rate) {
        /**
         * 要求传过来一个rate对象
         */
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("INSERT INTO rate (uid, bid, star, info, uidRateId) VALUES (?, ?, ?, ?, ?)");
            ps.setInt(1, rate.getUid());
            ps.setInt(2, rate.getBid());
            ps.setDouble(3,rate.getStar());
            ps.setString(4, rate.getInfo());
            ps.setInt(5, rate.getUidRateId());
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) { // 如果插入了至少一行
                return 1;
            } else { // 如果没有插入任何行
                return 0;
            }
        } catch (SQLException e) { // 捕获数据库异常
            e.printStackTrace();
            return -1;
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
    }

    public Rate getOneRate(int uid, int uidRateId) {
        return null;
    }
}
