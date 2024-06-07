<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="images/shortcut.png" rel="shortcut icon" type="image/x-icon"/>
    <title>产品信息</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>

<h1 class="text-center text-primary">产品信息</h1>
<hr>
<br>

<!--在此div中显示从数据库查询到的一个产品的所有信息-->
<div class="content">
    <br>

    <!--使用EL表达式获取产品对象-->
    <c:set var="p" value="${requestScope.product}"/>

    <!--显示产品图片-->
    <img src="images/${p.productImg}" class="pic">

    <h3>产品名称： ${p.productName} </h3>
    <p>产品单价：  <fmt:formatNumber value="${p.productPrice}" type="currency"/> </p>
    <p>包装单位：  ${p.productUnit} </p>
    <p>剩余库存：  ${p.productQty} </p>

    <!--提交表单，请求发送给cs，将产品添加到购物车-->
    <form action="cs" class="form-inline">
        <b>购买数量：</b>
        <input type="number" min="1" name="qty" value="1" class="form-control">
        <!--隐藏字段提交产品编号-->
        <input type="hidden" name="proId" value="${p.productId}">
        <!--提交其他产品信息-->
        <input type="hidden" name="proName" value="${p.productName}">
        <input type="hidden" name="proPrice" value="${p.productPrice}">
        <input type="hidden" name="proUnit" value="${p.productUnit}">
        <input type="hidden" name="proImg" value="${p.productImg}">
        <br><br>
        <button class="btn btn-sm btn-danger">加入购物车</button>
        &nbsp;
        <button class="btn btn-sm btn-warning">立刻购买</button>
    </form>
</div>

<br>
<a href="cart.jsp" class="cartImg">
    查看购物车<img src="images/cart.png" alt="购物车"/>
</a>
<a href="los" class="logout">
    退出登录
</a>

</body>
</html>
