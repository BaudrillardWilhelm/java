package com.qdu.dao;

import com.qdu.model.ShoppingCart;

import java.util.List;

public interface ShoppingCartDao {
    int addShoppingCart(ShoppingCart cart);
    int removeShoppingCart(int uid, int bid);
    int updateShoppingCart(ShoppingCart cart);
    ShoppingCart getShoppingCart(int uid, int bid);
    List<ShoppingCart> getAllShoppingCartsByUser(int uid);
}
