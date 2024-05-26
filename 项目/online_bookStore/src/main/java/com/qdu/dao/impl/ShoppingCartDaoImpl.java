package com.qdu.dao.impl;

import com.qdu.dao.ShoppingCartDao;
import com.qdu.model.ShoppingCart;
import com.qdu.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShoppingCartDaoImpl implements ShoppingCartDao {

    @Override
    public int addShoppingCart(ShoppingCart cart) {
        String sql = "INSERT INTO shopping_cart (uid, bid, book_name, price, book_type, book_num, sum) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DatabaseUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cart.getUid());
            ps.setInt(2, cart.getBid());
            ps.setString(3, cart.getBookName());
            ps.setDouble(4, cart.getPrice());
            ps.setString(5, cart.getBookType());
            ps.setString(6, cart.getBookNum());
            ps.setDouble(7, cart.getSum());
            return ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public int removeShoppingCart(int uid, int bid) {
        String sql = "DELETE FROM shopping_cart WHERE uid = ? AND bid = ?";
        try (Connection con = DatabaseUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, uid);
            ps.setInt(2, bid);
            return ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public int updateShoppingCart(ShoppingCart cart) {
        String sql = "UPDATE shopping_cart SET book_name = ?, price = ?, book_type = ?, book_num = ?, sum = ? WHERE uid = ? AND bid = ?";
        try (Connection con = DatabaseUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, cart.getBookName());
            ps.setDouble(2, cart.getPrice());
            ps.setString(3, cart.getBookType());
            ps.setString(4, cart.getBookNum());
            ps.setDouble(5, cart.getSum());
            ps.setInt(6, cart.getUid());
            ps.setInt(7, cart.getBid());
            return ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public ShoppingCart getShoppingCart(int uid, int bid) {
        String sql = "SELECT * FROM shopping_cart WHERE uid = ? AND bid = ?";
        try (Connection con = DatabaseUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, uid);
            ps.setInt(2, bid);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new ShoppingCart(
                            rs.getInt("uid"),
                            rs.getInt("bid"),
                            rs.getString("book_name"),
                            rs.getDouble("price"),
                            rs.getString("book_type"),
                            rs.getString("book_num"),
                            rs.getDouble("sum")
                    );
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public List<ShoppingCart> getAllShoppingCartsByUser(int uid) {
        String sql = "SELECT * FROM shopping_cart WHERE uid = ?";
        List<ShoppingCart> carts = new ArrayList<>();
        try (Connection con = DatabaseUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, uid);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ShoppingCart cart = new ShoppingCart(
                            rs.getInt("uid"),
                            rs.getInt("bid"),
                            rs.getString("book_name"),
                            rs.getDouble("price"),
                            rs.getString("book_type"),
                            rs.getString("book_num"),
                            rs.getDouble("sum")
                    );
                    carts.add(cart);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return carts;
    }
}
