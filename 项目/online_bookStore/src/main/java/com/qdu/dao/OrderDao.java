package com.qdu.dao;

import com.qdu.model.Collection;
import com.qdu.model.Order;

import java.sql.Date;
import java.util.List;

public interface OrderDao {
    int addOrder(Order order);
    List<Order> getOrdersByUserId(int uid);
    int removeOrder(int uid, int oid);
    int alterOrder(Order order);
    List<Order> getOrdersByUserIdSortedByDate(int uid);
    List<Order> searchOrdersByBookName(int uid, String keyword);


    List<Order> getDeliveredOrders(int uid);
    List<Order> getReviewedOrders(int uid);
    List<Order> getUndeliveredOrders(int uid);
}
