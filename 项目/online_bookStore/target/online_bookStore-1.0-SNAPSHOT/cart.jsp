<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.locale}" />
<fmt:setBundle basename="resources" />
<%@ page session="false" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="images/shortcut.png" rel="shortcut icon" type="image/x-icon"/>
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/style.css"/>
        <title>购物车信息</title>
    </head>
    <body>

        <div class="container">

            <a href="index1.html"><img src="网站图标.png" alt=""></a>

            <h1 class="text-center text-danger">购物车信息</h1>

            <c:if test="${empty sessionScope.cartList}">
                <hr><h1>尚未添加任何产品到购物车！！！</h1>
            </c:if>

            <c:if test="${not empty sessionScope.cartList}">
                <c:set var="total" value="0" />
                <c:forEach var="p" items="${sessionScope.cartList}">
                    <c:set var="subtotal" value="${p.productPrice * p.productQty}" />
                    <c:set var="total" value="${total + subtotal}" />
                    <div class="cartProduct">
                        <img src="images/${p.productImg}" width="120" height="120">
                        <hr>
                        产品名称：<c:out value="${p.productName}" />
                        <br>产品单价：<fmt:formatNumber value="${p.productPrice}" type="currency"  />
                        <br>包装单位：<c:out value="${p.productUnit}" />
                        <br>购买数量：<c:out value="${p.productQty}" />
                        <br><b class="text-primary">小计金额：<fmt:formatNumber value="${subtotal}" type="currency" /> </b>
                    </div>
                </c:forEach>
                <hr>
                <h3 class="text-danger">总计金额：<fmt:formatNumber value="${total}" type="currency" /></h3>
            </c:if>


            <a href="los" class="logout">
                退出登录
            </a>

        </div>
    </body>
</html>
