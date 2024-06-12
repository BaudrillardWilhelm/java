package com.qdu.dao.impl;

import com.qdu.dao.BaseDao;
import com.qdu.util.DatabaseUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 * BaseDao接口的实现类BaseDaoImpl
 *
 * @author Anna
 */
public class BaseDaoImpl implements BaseDao{

    @Override
    public int executeUpdate(String sql, Object... params) {
        
        Connection con = null;
        PreparedStatement ps = null;
        int rows = 0; 
        
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement(sql);
            //Object... params是可变参数，说明可以传入任意多个Object对象作为参数
            //操作这些参数的时候以数组操作即可，参数名params就是数组名
            for(int i=0;i<params.length;i++){
                ps.setObject(i+1,params[i]); //将sql语句中的第i+1个参数的值设置为数组中索引为i的元素的值
            }   
            rows = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(null, ps, con);
        }
        return rows;
    }
}
