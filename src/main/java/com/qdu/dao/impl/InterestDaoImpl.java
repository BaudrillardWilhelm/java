package com.qdu.dao.impl;

import com.qdu.dao.InterestDao;
import com.qdu.model.Book_info;
import com.qdu.model.Interest;
import com.qdu.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class InterestDaoImpl implements InterestDao {
    public InterestDaoImpl() {
    }

    /**
     *
     * @param uid
     * @return这个函数估计又是脑子不清醒的时候写的
     */
    @Override
    public List<Interest> findInterestListByUid(int uid) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Interest> list=null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from interest where uid = ?");
            ps.setInt(1,uid);
            rs = ps.executeQuery();

            while (rs.next()) {
                Interest interest = new Interest(
                        rs.getInt(1),      // 假设列名是"interest_id"，对应于uid
                        rs.getString(2), // 假设列名是"type_name_column"，对应于type_name
                        rs.getInt(3)
                );
                list.add(interest);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return null;
    }

    public String  findInterestChineseNameByUid(int uid,int type_id)
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String ChineseName = "";
        try{
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select type_name from interest where uid = ? and type_id = ?");
            ps.setInt(1,uid);
            ps.setInt(2,type_id);
            rs = ps.executeQuery();
            if(rs.next())
            {
                ChineseName = rs.getString(1);
                return ChineseName;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return "null";
    }

    public String  findInterestChineseNameBytypeId(int type_id)
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String ChineseName = "";
        try{
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select type_name from interest where type_id = ? limit 1;");
            ps.setInt(1,type_id);
            rs = ps.executeQuery();
            if(rs.next())
            {
                ChineseName = rs.getString(1);
                return ChineseName;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return "null";
    }


    public int addInterest(Interest interest) {
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("INSERT INTO interest (uid, type_name, type_id) VALUES (?, ?, ?)");
            ps.setInt(1, interest.getUid());
            ps.setString(2, interest.getType_name());
            ps.setInt(3, interest.getType_id());

            rowsAffected = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(null, ps, con);
        }
        return rowsAffected;
    }

    public int removeInterest(int uid,int type_id) {
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("DELETE FROM interest WHERE uid = ? and type_id = ?");
            ps.setInt(1,uid);
            ps.setInt(2,type_id);
            rowsAffected = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(null, ps, con);
        }
        return rowsAffected;
    }



}
