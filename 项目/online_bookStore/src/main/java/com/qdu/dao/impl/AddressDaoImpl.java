package com.qdu.dao.impl;

import com.qdu.dao.AddressDao;
import com.qdu.model.Address;
import com.qdu.model.Interest;
import com.qdu.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AddressDaoImpl implements AddressDao {
    @Override
    public List<Address> findAddressListById(int uid) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Address> address_List=new ArrayList();
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("select * from address where uid = ?");
            ps.setInt(1,uid);
            rs = ps.executeQuery();

            while (rs.next()) {
                Address address = new Address(
                        rs.getInt(1),      // 假设第一列是uid
                        rs.getString(2),   // 假设第二列是province
                        rs.getString(3),   // 假设第三列是city
                        rs.getString(4),   // 假设第四列是area
                        rs.getString(5),   // 假设第五列是info
                        rs.getString(6),   // 假设第六列是postal_code
                        rs.getString(7),   // 假设第七列是receiver_name
                        rs.getString(8),    // 假设第八列是tel
                        rs.getInt(9)    //9，user_address_id
                );
                address_List.add(address);
            }
            return address_List;
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            DatabaseUtil.close(rs,ps,con);
        }
        return null;
    }

    public int addAddress(Address address) {
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("INSERT INTO address (uid, province, city, area, info, postal_code, receiver_name, tel,user_address_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)");
            ps.setInt(1, address.getUid());
            ps.setString(2, address.getProvince());
            ps.setString(3, address.getCity());
            ps.setString(4, address.getArea());
            ps.setString(5, address.getInfo());
            ps.setString(6, address.getPostal_code());
            ps.setString(7, address.getReceiver_name());
            ps.setString(8, address.getTel());
            ps.setInt(9,address.getUser_address_id());
            rowsAffected = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(null, ps, con);
        }
        return rowsAffected;
    }

    public int removeAddress(int uid,int userAddressId) {
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0;
        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("DELETE FROM address WHERE uid = ? and user_address_id = ?");
            ps.setInt(1, uid);
            ps.setInt(2,userAddressId);
            rowsAffected = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(null, ps, con);
        }
        return rowsAffected;
    }

    public int updateAddress(Address address) {
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0;
        try {
            con = DatabaseUtil.getConnection();
            // 假设你有一个唯一标识来更新特定的地址记录，比如id
            // 这里我们使用address_id作为示例
            String sql = "UPDATE address SET province = ?, city = ?, area = ?, info = ?, postal_code = ?, receiver_name = ?, tel = ? WHERE uid = ? and user_address_id = ? "; // 注意：这里假设address表中有一个名为address_id的字段作为主键

            ps = con.prepareStatement(sql);

            // 设置要更新的值
            ps.setString(1, address.getProvince());
            ps.setString(2, address.getCity());
            ps.setString(3, address.getArea());
            ps.setString(4, address.getInfo());
            ps.setString(5, address.getPostal_code());
            ps.setString(6, address.getReceiver_name());
            ps.setString(7, address.getTel());
            ps.setInt(8, address.getUid());
            ps.setInt(9,address.getUser_address_id());

            rowsAffected = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(null, ps, con);
        }
        return rowsAffected;
    }


}
