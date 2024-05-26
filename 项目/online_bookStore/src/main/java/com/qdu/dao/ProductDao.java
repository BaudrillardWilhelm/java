package com.qdu.dao;

import com.qdu.model.Product;

import java.util.List;

public interface ProductDao {
    List<Product> getProductList();
    Product findProductById(String productId);
}
