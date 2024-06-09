package com.qdu.dao.impl;

import com.qdu.dao.OrderDao;
import com.qdu.model.Order;
import com.qdu.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDaoImpl implements OrderDao {

    // order_type: 1是已送达，-1是已取消，0运送中

    @Override
    public int addOrder(Order order) {
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0;

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("INSERT INTO orders (oid, uid, receiver_name, buyer_address, buyer_tel, postal_code, order_date, order_type, bid, b_name, book_num, sum_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setInt(1, order.getOid());
            ps.setInt(2, order.getUid());
            ps.setString(3, order.getReceiver_name());
            ps.setString(4, order.getBuyer_address());
            ps.setString(5, order.getBuyer_tel());
            ps.setString(6, order.getPostal_code());
            ps.setDate(7, new java.sql.Date(order.getOrder_date().getTime()));
            ps.setInt(8, order.getOrder_type());
            ps.setInt(9, order.getBid());
            ps.setString(10, order.getB_name());
            ps.setInt(11, order.getBook_num());
            ps.setDouble(12, order.getSum_price());

            rowsAffected = ps.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        } finally {
            DatabaseUtil.close(null, ps, con);
        }
        return rowsAffected;
    }

    @Override
    public List<Order> getOrdersByUserId(int uid) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Order> orderList = new ArrayList<>();

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("SELECT * FROM orders WHERE uid = ?");
            ps.setInt(1, uid);
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("oid"),
                        rs.getInt("uid"),
                        rs.getString("receiver_name"),
                        rs.getString("buyer_address"),
                        rs.getString("buyer_tel"),
                        rs.getString("postal_code"),
                        rs.getDate("order_date"),
                        rs.getInt("order_type"),
                        rs.getInt("bid"),
                        rs.getString("b_name"),
                        rs.getInt("book_num"),
                        rs.getDouble("sum_price")
                );
                orderList.add(order);
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
        return orderList;
    }

    @Override
    public int removeOrder(int uid, int oid) {
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0;

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("DELETE FROM orders WHERE uid = ? AND oid = ?");
            ps.setInt(1, uid);
            ps.setInt(2, oid);

            rowsAffected = ps.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        } finally {
            DatabaseUtil.close(null, ps, con);
        }
        return rowsAffected;
    }

    @Override
    public int alterOrder(Order order) {
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0;

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("UPDATE orders SET uid=?, receiver_name=?, buyer_address=?, buyer_tel=?, postal_code=?, order_date=?, order_type=?, bid=?, b_name=?, book_num=?, sum_price=? WHERE oid=?");
            ps.setInt(1, order.getUid());
            ps.setString(2, order.getReceiver_name());
            ps.setString(3, order.getBuyer_address());
            ps.setString(4, order.getBuyer_tel());
            ps.setString(5, order.getPostal_code());
            ps.setDate(6, new java.sql.Date(order.getOrder_date().getTime()));
            ps.setInt(7, order.getOrder_type());
            ps.setInt(8, order.getBid());
            ps.setString(9, order.getB_name());
            ps.setInt(10, order.getBook_num());
            ps.setDouble(11, order.getSum_price());
            ps.setInt(12, order.getOid());

            rowsAffected = ps.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        } finally {
            DatabaseUtil.close(null, ps, con);
        }
        return rowsAffected;
    }

    @Override
    public List<Order> getOrdersByUserIdSortedByDate(int uid) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Order> orderList = new ArrayList<>();

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("SELECT * FROM orders WHERE uid = ? ORDER BY order_date DESC");
            ps.setInt(1, uid);
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("oid"),
                        rs.getInt("uid"),
                        rs.getString("receiver_name"),
                        rs.getString("buyer_address"),
                        rs.getString("buyer_tel"),
                        rs.getString("postal_code"),
                        rs.getDate("order_date"),
                        rs.getInt("order_type"),
                        rs.getInt("bid"),
                        rs.getString("b_name"),
                        rs.getInt("book_num"),
                        rs.getDouble("sum_price")
                );
                orderList.add(order);
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
        return orderList;
    }

    @Override
    public List<Order> searchOrdersByBookName(int uid, String keyword) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Order> orderList = new ArrayList<>();

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("SELECT * FROM orders WHERE uid = ? AND b_name LIKE ?");
            ps.setInt(1, uid);
            ps.setString(2, "%" + keyword + "%");
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("oid"),
                        rs.getInt("uid"),
                        rs.getString("receiver_name"),
                        rs.getString("buyer_address"),
                        rs.getString("buyer_tel"),
                        rs.getString("postal_code"),
                        rs.getDate("order_date"),
                        rs.getInt("order_type"),
                        rs.getInt("bid"),
                        rs.getString("b_name"),
                        rs.getInt("book_num"),
                        rs.getDouble("sum_price")
                );
                orderList.add(order);
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
        return orderList;
    }


    public List<Order> getOrdersWithinTimeFrame(int uid, java.util.Date startDate, java.util.Date endDate) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Order> orderList = new ArrayList<>();

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("SELECT * FROM orders WHERE uid = ? AND order_date BETWEEN ? AND ?");
            ps.setInt(1, uid);
            ps.setDate(2, new java.sql.Date(startDate.getTime()));
            ps.setDate(3, new java.sql.Date(endDate.getTime()));
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("oid"),
                        rs.getInt("uid"),
                        rs.getString("receiver_name"),
                        rs.getString("buyer_address"),
                        rs.getString("buyer_tel"),
                        rs.getString("postal_code"),
                        rs.getDate("order_date"),
                        rs.getInt("order_type"),
                        rs.getInt("bid"),
                        rs.getString("b_name"),
                        rs.getInt("book_num"),
                        rs.getDouble("sum_price")
                );
                orderList.add(order);
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
        return orderList;
    }

    @Override
    public List<Order> getDeliveredOrders(int uid) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Order> orderList = new ArrayList<>();

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("SELECT * FROM orders WHERE uid = ? AND order_type = 1");
            ps.setInt(1, uid);
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("oid"),
                        rs.getInt("uid"),
                        rs.getString("receiver_name"),
                        rs.getString("buyer_address"),
                        rs.getString("buyer_tel"),
                        rs.getString("postal_code"),
                        rs.getDate("order_date"),
                        rs.getInt("order_type"),
                        rs.getInt("bid"),
                        rs.getString("b_name"),
                        rs.getInt("book_num"),
                        rs.getDouble("sum_price")
                );
                orderList.add(order);
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
        return orderList;
    }

    @Override
    public List<Order> getReviewedOrders(int uid) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Order> orderList = new ArrayList<>();

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("SELECT * FROM orders WHERE uid = ? AND reviewed = 1");
            ps.setInt(1, uid);
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("oid"),
                        rs.getInt("uid"),
                        rs.getString("receiver_name"),
                        rs.getString("buyer_address"),
                        rs.getString("buyer_tel"),
                        rs.getString("postal_code"),
                        rs.getDate("order_date"),
                        rs.getInt("order_type"),
                        rs.getInt("bid"),
                        rs.getString("b_name"),
                        rs.getInt("book_num"),
                        rs.getDouble("sum_price")
                );
                orderList.add(order);
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
        return orderList;
    }

    @Override
    public List<Order> getUndeliveredOrders(int uid) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Order> orderList = new ArrayList<>();

        try {
            con = DatabaseUtil.getConnection();
            ps = con.prepareStatement("SELECT * FROM orders WHERE uid = ? AND order_type = 0");
            ps.setInt(1, uid);
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("oid"),
                        rs.getInt("uid"),
                        rs.getString("receiver_name"),
                        rs.getString("buyer_address"),
                        rs.getString("buyer_tel"),
                        rs.getString("postal_code"),
                        rs.getDate("order_date"),
                        rs.getInt("order_type"),
                        rs.getInt("bid"),
                        rs.getString("b_name"),
                        rs.getInt("book_num"),
                        rs.getDouble("sum_price")
                );
                orderList.add(order);
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        } finally {
            DatabaseUtil.close(rs, ps, con);
        }
        return orderList;
    }
}
