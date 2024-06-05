package com.qdu.dao.impl;

import com.qdu.dao.UserDao;
import com.qdu.model.Users;
import com.qdu.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {
    public UserDaoImpl() {

    }

    public List<Users> getUserList()//获取所有用户
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Users> usersList = new ArrayList();

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Users");
            rs = ps.executeQuery();

            while (rs.next()) {
                usersList.add(new Users(rs.getInt("uid"), rs.getString("uname"), rs.getString("upassword"), rs.getString("uquestion"), rs.getString("uanswer"), rs.getString("true_name"), rs.getString("gender"), rs.getString("tel"), rs.getString("e_mail"), rs.getString("career"), rs.getString("interest"), rs.getString("address"), rs.getDouble("money"), rs.getDate("registration_time")));
            }
            return usersList;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
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
                return new Users(rs.getInt("uid"), rs.getString("uname"), rs.getString("upassword"), rs.getString("uquestion"), rs.getString("uanswer"), rs.getString("true_name"), rs.getString("gender"), rs.getString("tel"), rs.getString("e_mail"), rs.getString("career"), rs.getString("interest"), rs.getString("address"), rs.getDouble("money"), rs.getDate("registration_time"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
        return null;
    }

    public boolean haveThePeopleByUnameAndUpassword(String uname, String upassword)//根据用户名和密码判断用户是否存在
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Users where uname=? and upassword=?");
            ps.setString(1, uname);
            ps.setString(2, upassword);
            rs = ps.executeQuery();

            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
        return false;
    }

    @Override
    public Users GetInformationByNameAndPassword(String uname, String upassword) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Users Back = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Users where uname=? and upassword=?");
            ps.setString(1, uname);
            ps.setString(2, upassword);
            rs = ps.executeQuery();

            while (rs.next()) {
                Back = new Users(rs.getInt("uid"), rs.getString("uname"), rs.getString("upassword"), rs.getString("uquestion"), rs.getString("uanswer"), rs.getString("true_name"), rs.getString("gender"), rs.getString("tel"), rs.getString("e_mail"), rs.getString("career"), rs.getString("interest"), rs.getString("address"), rs.getDouble("money"), rs.getDate("registration_time"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            DatabaseUtil.close(rs, ps, con);
            return Back;
        }
    }

    @Override
    public String GetQuestionByPhone(String phone) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String Back = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select uquestion  from Users where tel=?");
            ps.setString(1, phone);
            rs = ps.executeQuery();

            while (rs.next()) {
                Back = new String(rs.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
            return Back;
        }
    }

    @Override
    public boolean AnswerJudge(String question, String answer) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean back = false;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select *  from Users where uquestion=? and uanswer=?");
            ps.setString(1, question);
            ps.setString(2, answer);
            rs = ps.executeQuery();
            while (rs.next()) {
                back = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
            return back;
        }
    }

    @Override
    public String GetPasswordByAnswerByQuestion(String answer, String question) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String back = "gg";
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select upassword  from Users where uquestion=? and uanswer=?");
            ps.setString(1, question);
            ps.setString(2, answer);
            rs = ps.executeQuery();
            while (rs.next()) {
                back = rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
            return back;
        }
    }

    @Override
    public boolean PushNewUser(Users in) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean back = false;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("insert into users (uname,upassword,uquestion,uanswer,true_name,gender,tel,Email,career,interest,address,money,registration_time) values (?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, in.getUname());
            ps.setString(2, in.getUpassword());
            ps.setString(3, in.getUquestion());
            ps.setString(4, in.getUanswer());
            ps.setString(5, in.getTrue_name());
            ps.setString(6, in.getGender());
            ps.setString(7, in.getTel());
            ps.setString(8, in.getE_mail());
            ps.setString(9, in.getCareer());
            ps.setString(10, in.getInterest());
            ps.setString(11, in.getAddress());
            ps.setDouble(12, in.getMoney());
            ps.setDate(13, new java.sql.Date(in.getRegistration_time().getTime()));
            ps.executeUpdate();
            back = true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
            return back;
        }
    }

    @Override
    public boolean HavePhone(String in) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean back = false;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select *  from Users where tel=?");
            ps.setString(1, in);
            rs = ps.executeQuery();
            while (rs.next()) {
                back = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
            return back;
        }
    }
}
