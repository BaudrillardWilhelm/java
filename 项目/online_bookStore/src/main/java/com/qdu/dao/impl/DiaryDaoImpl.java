package com.qdu.dao.impl;

import com.qdu.model.Diary;
import com.qdu.util.DatabaseUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.qdu.dao.DiaryDao;

/**
 * DiaryDaoImpl类，是DiaryDao接口的实现类，包含了Diary表相关数据库操作的实现代码
 *
 * @author Anna
 */
public class DiaryDaoImpl extends BaseDaoImpl implements DiaryDao {

    @Override
    public int insert(Diary d) {
        return executeUpdate("insert into Diary(Did,Dtitle,Dtext,Downer) values(?,?,?,?)",
                d.getDid(),
                d.getDtitle(),
                d.getDtext(),
                d.getDowner());
    }

    @Override
    public Diary getOneById(String id) {

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Diary diary = null;

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Diary where Did=?");
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                diary = new Diary(rs.getString(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(6));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
        return diary;
    }

    @Override
    public List<Diary> getAll() {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Diary> list = new ArrayList<>();

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from Diary");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Diary(rs.getString(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(6)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
        return list;
    }
    
    @Override
    public List<Diary> getAllBasicInfo() {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Diary> list = new ArrayList<>();

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select Did, Dtitle,Dtime,Downer from Diary");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Diary(rs.getString(1), rs.getString(2), rs.getTimestamp(3), rs.getString(4)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
        return list;
    }

}
