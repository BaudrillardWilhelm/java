package com.qdu.model;

public class Product {

    private String productId ;
    private String productName ;
    private float productPrice ;
    private String productUnit ;
    private int productQty ; //quantity  
    private String productImg;

    public Product(String productId, String productName, float productPrice, String productUnit, int productQty) {
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productUnit = productUnit;
        this.productQty = productQty;
    } 
    
    public Product(String productId, String productName, float productPrice, String productUnit, int productQty, String productImg) {
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productUnit = productUnit;
        this.productQty = productQty;
        this.productImg = productImg;
    }

    public String getProductImg() {
        return productImg;
    }

    public void setProductImg(String productImg) {
        this.productImg = productImg;
    }

    //对于实体类，一般建议保留一个不带参数的构造函数
    public Product() {
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public float getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(float productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductUnit() {
        return productUnit;
    }

    public void setProductUnit(String productUnit) {
        this.productUnit = productUnit;
    }

    public int getProductQty() {
        return productQty;
    }

    public void setProductQty(int productQty) {
        this.productQty = productQty;
    }
}
