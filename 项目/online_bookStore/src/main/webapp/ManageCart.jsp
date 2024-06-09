<%@ page import="com.qdu.dao.impl.ShoppingCartDaoImpl" %>
<%@ page import="com.qdu.model.Users" %>
<%@ page import="com.qdu.model.ShoppingCart" %>
<%@ page import="java.util.List" %>
<%@ page import="com.qdu.dao.impl.UserDaoImpl" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    HttpSession session = request.getSession(false);
    Users loggedUser = (Users) session.getAttribute("LoggedUser");
    if (loggedUser == null) {
        response.sendRedirect("Userlogin.jsp");
        return;
    }

    UserDaoImpl userDaoImpl = new UserDaoImpl();
    request.setAttribute("userDaoImpl", userDaoImpl);

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
    <script src="js/bootstrap.min.js"></script>
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
        function showDeleteModal(bid, bookName) {
            $('#deleteCartId').val(bid);
            $('#deleteBookName').text(bookName);
            $('#deleteCartModal').modal('show');
        }

        function deleteCart() {
            var bid = $('#deleteCartId').val();
            $.ajax({
                url: 'deleteCartServlet',
                type: 'POST',
                data: {bid: bid},
                success: function (response) {
                    if (response.status == 1) {
                        alert('删除成功');
                        location.reload(true);
                    } else if (response.status == 0) {
                        alert('删除失败');
                    } else if (response.status == -1) {
                        alert('数据库错误');
                    }
                },
                error: function () {
                    alert('请求失败');
                }
            });
        }

        function updateCart(bid) {
            var newQty = $('#qty-' + bid).val();
            $.ajax({
                url: 'updateCartServlet',
                type: 'POST',
                data: {bid: bid, newQty: newQty},
                success: function (response) {
                    if (response.status === "success") {
                        alert('数量更新成功');
                        location.reload();
                    } else if (response.status === "false") {
                        alert('更新数量失败');
                    } else if (response.status === "error") {
                        alert('error');
                    } else {
                        alert(response.status);
                    }
                },
                error: function () {
                    alert('请求失败');
                }
            });
        }

        function submitForm() {
            document.getElementById('checkoutForm').submit();
        }

        function showClearCartModal() {
            $('#clearCartModal').modal('show');
        }

        function clearCart() {
            $.ajax({
                url: 'clearCartServlet',
                type: 'POST',
                success: function (response) {
                    if (response.status == 1) {
                        alert('购物车已清空');
                        location.reload();
                    } else {
                        alert('清空购物车失败');
                    }
                },
                error: function () {
                    alert('请求失败');
                }
            });
        }
    </script>
</head>
<body>
<div class="container">
    <h2>购物车信息</h2>
    <% if (cartList.isEmpty()) { %>
    <hr>
    <h3>尚未添加任何产品到购物车！！！</h3>
    <% } else { %>
    <% for (ShoppingCart cart : cartList) { %>
    <div class="cart-row">
        <div>
            <strong><%= cart.getBookName() %>
            </strong><br>
            单价：<fmt:formatNumber value="<%= cart.getPrice() %>" type="currency"/><br>
            类型：<%= cart.getBookType() %><br>
            数量：
            <input type="number" id="qty-<%= cart.getBid() %>" value="<%= cart.getBookNum() %>" min="1"
                   style="width: 50px;">
            <button class="btn btn-sm btn-primary" onclick="updateCart(<%= cart.getBid() %>)">更新数量</button>
            <br>
            总价：<fmt:formatNumber value="<%= cart.getSum() %>" type="currency"/>
        </div>
        <div class="cart-actions">
            <button class="btn btn-sm btn-danger"
                    onclick="showDeleteModal('<%= cart.getBid() %>', '<%= cart.getBookName() %>')">删除
            </button>
        </div>
        <div style="clear: both;"></div>
    </div>
    <% } %>
    <button class="btn btn-warning" onclick="showClearCartModal()">清空购物车</button>
    <button class="btn btn-primary" onclick="submitForm()">去支付</button>
    <% } %>
</div>


<form id="checkoutForm" action="manyOrdersConfirmServlet" method="post"></form>


<!-- Delete Cart Modal -->
<div class="modal fade" id="deleteCartModal" tabindex="-1" role="dialog" aria-labelledby="deleteCartModalLabel"
     aria-hidden="true">
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
                <button type="button" class="btn btn-danger" onclick="deleteCart()" data-dismiss="modal">删除</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<!-- Clear Cart Modal -->
<div class="modal fade" id="clearCartModal" tabindex="-1" role="dialog" aria-labelledby="clearCartModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="clearCartModalLabel">清空购物车</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>确定要清空购物车吗？</p>
                <button type="button" class="btn btn-danger" onclick="clearCart()" data-dismiss="modal">清空</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>


</body>
</html>
