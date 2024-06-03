<%@ page import="com.qdu.dao.impl.ShoppingCartDaoImpl" %>
<%@ page import="com.qdu.model.Users" %>
<%@ page import="com.qdu.model.ShoppingCart" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    Users loggedUser = (Users) session.getAttribute("LoggedUser");
    ShoppingCartDaoImpl cartDao = new ShoppingCartDaoImpl();
    List<ShoppingCart> cartList = cartDao.getAllShoppingCartsByUser(loggedUser.getUid());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>购物车信息</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <style>
        .container {
            max-width: 800px;
            margin: 50px auto;
        }
        .cart-row {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .cart-actions {
            float: right;
        }
    </style>
    <script>
        function showDeleteModal(cart) {
            $('#deleteCartId').val(cart.bid);
            $('#deleteBookName').text(cart.bookName);
            $('#deleteCartModal').modal('show');
        }

        function deleteCart() {
            var bid = $('#deleteCartId').val();
            $.ajax({
                url: 'deleteCartServlet',
                type: 'POST',
                data: { bid: bid },
                success: function(response) {
                    if (response == 1) {
                        alert('删除成功');
                        location.reload();
                    } else if (response == 0) {
                        alert('删除失败');
                    } else if (response == -1) {
                        alert('数据库错误');
                    }
                },
                error: function() {
                    alert('请求失败');
                }
            });
        }
    </script>
</head>
<body>
<div class="container">
    <h2>购物车信息</h2>
    <c:if test="${empty cartList}">
        <hr><h3>尚未添加任何产品到购物车！！！</h3>
    </c:if>
    <c:if test="${not empty cartList}">
        <c:forEach var="cart" items="${cartList}">
            <div class="cart-row">
                <div>
                    <strong>${cart.bookName}</strong><br>
                    单价：<fmt:formatNumber value="${cart.price}" type="currency" /><br>
                    类型：${cart.bookType}<br>
                    数量：${cart.bookNum}<br>
                    总价：<fmt:formatNumber value="${cart.sum}" type="currency" />
                </div>
                <div class="cart-actions">
                    <button class="btn btn-sm btn-danger" onclick='showDeleteModal(${cart})'>删除</button>
                </div>
                <div style="clear: both;"></div>
            </div>
        </c:forEach>
    </c:if>
</div>

<!-- Delete Cart Modal -->
<div class="modal fade" id="deleteCartModal" tabindex="-1" role="dialog" aria-labelledby="deleteCartModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteCartModalLabel">删除购物车商品</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="deleteCartId">
                <p>确定要删除 <strong id="deleteBookName"></strong> 吗？</p>
                <button type="button" class="btn btn-danger" onclick="deleteCart()">删除</button>
            </div>
        </div>
    </div>
</div>

<script src="js/bootstrap.min.js"></script>
</body>
</html>
