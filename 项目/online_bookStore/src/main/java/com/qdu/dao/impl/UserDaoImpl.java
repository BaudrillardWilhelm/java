package com.qdu.dao.impl;

import com.qdu.dao.UserDao;
import com.qdu.model.Users;
import com.qdu.util.DatabaseUtil;

import java.security.MessageDigest;
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
            ps = con.prepareStatement("select * from users");
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
            ps = con.prepareStatement("select * from users where uid=?");
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                return new Users(
                        rs.getInt("uid"),
                        rs.getString("uname"),
                        rs.getString("upassword"),
                        rs.getString("uquestion"),
                        rs.getString("uanswer"),
                        rs.getString("true_name"),
                        rs.getString("gender"),
                        rs.getString("tel"),
                        rs.getString("Email"),
                        rs.getString("career"),
                        rs.getString("interest"),
                        rs.getString("address"),
                        rs.getDouble("money"),
                        rs.getDate("registration_time"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
        return null;
    }

    public boolean haveThePeopleByUidAndUpassword(String uid, String upassword)//根据用户名和密码判断用户是否存在
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from users where uid=? and upassword=?");
            ps.setString(1, uid);
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
    public Users GetInformationByidAndPassword(String uid, String upassword) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Users Back = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from users where uid=? and upassword=?");
            ps.setString(1, uid);
            ps.setString(2, upassword);
            rs = ps.executeQuery();

            while (rs.next()) {
                Back = new Users(
                        rs.getInt("uid"),
                        rs.getString("uname"),
                        rs.getString("upassword"),
                        rs.getString("uquestion"),
                        rs.getString("uanswer"),
                        rs.getString("true_name"),
                        rs.getString("gender"),
                        rs.getString("tel"),
                        rs.getString("Email"),
                        rs.getString("career"),
                        rs.getString("interest"),
                        rs.getString("address"),
                        rs.getDouble("money"),
                        rs.getDate("registration_time"));
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
            ps = con.prepareStatement("select uquestion  from users where tel=?");
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
            ps = con.prepareStatement("select *  from users where uquestion=? and uanswer=?");
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
            ps = con.prepareStatement("select upassword  from users where uquestion=? and uanswer=?");
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
            ps = con.prepareStatement("select *  from users where tel=?");
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

    @Override
    public int GetUidByUnameAndUpassword(String uname, String upassword) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int back = -1;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select uid  from users where uname=? and upassword=?");
            ps.setString(1, uname);
            ps.setString(2, upassword);
            rs = ps.executeQuery();
            while (rs.next()) {
                back = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
            return back;
        }
    }

    @Override
    public void ChangePassword(String uid, String password) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("update users set upassword=? where  uid=?");
            ps.setString(1, password);
            ps.setString(2, uid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
    }

    @Override
    public void ChangeQuestion(String uid, String Question) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("update users set uquestion=? where  uid=?");
            ps.setString(1, Question);
            ps.setString(2, uid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
    }

    @Override
    public void ChangeAnswer(String uid, String Answer) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("update users set uanswer=? where  uid=?");
            ps.setString(1, Answer);
            ps.setString(2, uid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
    }

    @Override
    public void ChangeTrue_name(String uid, String True_name) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("update users set true_name=? where  uid=?");
            ps.setString(1, True_name);
            ps.setString(2, uid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
    }

    @Override
    public void ChangeTel(String uid, String Tel) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("update users set tel=? where  uid=?");
            ps.setString(1, Tel);
            ps.setString(2, uid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
    }

    @Override
    public void ChangeE_mail(String uid, String E_mail) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("update users set Email=? where  uid=?");
            ps.setString(1, E_mail);
            ps.setString(2, uid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
    }

    @Override
    public void ChangeCareer(String uid, String Career) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("update users set career=? where  uid=?");
            ps.setString(1, Career);
            ps.setString(2, uid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
    }

    @Override
    public void ChangeAddress(String uid, String Address) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("update users set address=? where  uid=?");
            ps.setString(1, Address);
            ps.setString(2, uid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
    }

    @Override
    public void ChangeMoney(String uid, String money) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("update users set money=? where  uid=?");
            ps.setString(1, money);
            ps.setString(2, uid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
    }

    @Override
    public String GetMoney(String uid) {

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String Back = null;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select money  from users where uid=?");
            ps.setString(1, uid);
            rs = ps.executeQuery();

            while (rs.next()) {
                Back = String.valueOf(rs.getDouble(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
            return Back;
        }
    }

    public void updateUser(Users loggedUser) {
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("UPDATE users SET uname=?, upassword=?, uquestion=?, uanswer=?, true_name=?, gender=?, tel=?, e_mail=?, career=?, interest=?, address=?, money=?, registration_time=? WHERE uid=?");

            ps.setString(1, loggedUser.getUname());
            ps.setString(2, loggedUser.getUpassword());
            ps.setString(3, loggedUser.getUquestion());
            ps.setString(4, loggedUser.getUanswer());
            ps.setString(5, loggedUser.getTrue_name());
            ps.setString(6, loggedUser.getGender());
            ps.setString(7, loggedUser.getTel());
            ps.setString(8, loggedUser.getE_mail());
            ps.setString(9, loggedUser.getCareer());
            ps.setString(10, loggedUser.getInterest());
            ps.setString(11, loggedUser.getAddress());
            ps.setDouble(12, loggedUser.getMoney());
            ps.setDate(13, (java.sql.Date)loggedUser.getRegistration_time());
            ps.setInt(14, loggedUser.getUid());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(null, ps, con);
        }
    }

}
