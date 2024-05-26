package com.qdu.dao.impl;

import com.qdu.dao.UserDao;
import com.qdu.model.Users;
import com.qdu.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {
    public UserDaoImpl()
    {

    }
    public List<Users> getUserList()//获取所有用户
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Users> usersList=new ArrayList();

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Users");
            rs = ps.executeQuery();

            while (rs.next()) {
                usersList.add(new Users(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getBoolean(6),rs.getString(7),rs.getString(8),rs.getString(9),rs.getString(10),rs.getString(11),rs.getString(12),rs.getString(13),rs.getInt(14),rs.getTime(15)));
            }
            return usersList;
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return null;
    }
    public Users findUserListById(int id)//获取某个用户信息
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Users where uid=?");
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                return new Users(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getBoolean(6),rs.getString(7),rs.getString(8),rs.getString(9),rs.getString(10),rs.getString(11),rs.getString(12),rs.getString(13),rs.getInt(14),rs.getTime(15));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return null;
    }
    public boolean haveThePeopleByUnameAndUpassword(String uname,String upassword)//根据用户名和密码判断用户是否存在
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Users where uname=? and upassword=?");
            ps.setString(1,uname);
            ps.setString(2,upassword);
            rs = ps.executeQuery();

            while (rs.next()) {
                return  true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return false;
    }
    public boolean ifPeopleIsTheAdministratorsByUnameAndUpassword (String uname,String upassword)//判断这个用户是否为管理员且是否存在
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Users where uname=? and upassword=? and identity=1");
            ps.setString(1,uname);
            ps.setString(2,upassword);
            rs = ps.executeQuery();

            while (rs.next()) {
                return  true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return false;
    }
}
