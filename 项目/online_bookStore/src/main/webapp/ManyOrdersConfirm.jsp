<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.qdu.model.ShoppingCart" %>
<%
    List<ShoppingCart> cartList = (List<ShoppingCart>) request.getAttribute("cartList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单确认</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <style>
        .container {
            max-width: 800px;
            margin: 50px auto;
        }
        .order-row {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>订单确认</h2>
    <form id="confirmOrderForm" method="post">
        <div id="orderList">
            <c:choose>
                <c:when test="${cartList.isEmpty()}">
                    <hr><h3>暂无任何订单！</h3><hr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="order" items="${cartList}">
                        <div class="order-row">
                            <strong>${order.bookName}</strong><br>
                            数量：${order.bookNum}<br>
                            总价：<fmt:formatNumber value="${order.sum}" type="currency" />
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
        <div>
            <input type="text" name="receiverName" placeholder="收货人" required>
            <input type="text" name="buyerAddress" placeholder="收货地址" required>
            <input type="text" name="buyerTel" placeholder="电话" required>
            <input type="text" name="postalCode" placeholder="邮编" required>
            <button type="button" class="btn btn-success" onclick="confirmOrder()">去支付</button>
        </div>
    </form>

</div>

<script>
    function confirmOrder() {
        $.ajax({
            url: 'AddManyOrdersServlet',
            type: 'POST',
            data: $('#confirmOrderForm').serialize(),
            success: function(response) {
                if (response.status === "success") {
                    alert('订单提交成功！');
                    window.location.href = 'index.jsp';  // 跳转到成功页面
                } else if(response.status === "insufficient_funds") {
                    alert('账户余额不足，请先进行充值！');
                } else if(response.status === "user_false")
                {
                    alert('error：没扣钱   且   购物车清空成功，但是订单添加成功！！');
                }
                else {
                    alert('订单提交失败！');
                }
            },
            error: function() {
                alert('进入AddManyOrdersServlet失败！ 请求失败');
            }
        });
    }
</script>

<script src="js/bootstrap.min.js"></script>
</body>
</html>
