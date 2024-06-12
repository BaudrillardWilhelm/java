<%@ page import="com.qdu.dao.impl.ShoppingCartDaoImpl" %>
<%@ page import="com.qdu.model.Users" %>
<%@ page import="com.qdu.model.ShoppingCart" %>
<%@ page import="java.util.List" %>
<%@ page import="com.qdu.dao.impl.UserDaoImpl" %>
<%@ page import="com.qdu.dao.impl.OrderDaoImpl" %>
<%@ page import="com.qdu.model.Order" %>
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
    int uid = loggedUser.getUid();
    UserDaoImpl userDaoImpl = new UserDaoImpl();
    request.setAttribute("userDaoImpl", userDaoImpl);

    OrderDaoImpl orderDao = new OrderDaoImpl();
    List<Order> orderList = orderDao.getOrdersByUserId(uid);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单信息</title>
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
        function showDeleteModal(oid, bookName) {
            $('#deleteCartId').val(oid);
            $('#deleteBookName').text(bookName);
            $('#deleteCartModal').modal('show');
        }

        function deleteCart() {
            var oid = $('#deleteCartId').val();

            $.ajax({
                url: 'deleteOrderServlet',
                type: 'POST',
                data: {oid: oid},
                success: function (response) {

                    if (response == 1) {
                        alert('删除成功');
                        location.reload(true);
                    } else if (response == 0) {
                        alert('删除失败');
                    } else if (response== -1) {
                        alert('数据库错误');
                    }
                },
                error: function () {
                    alert('请求失败');
                }
            });
        }

        function showClearCartModal() {
            $('#clearCartModal').modal('show');
        }

        function showReturnModal(uid, oid) {
            $('#ReturnOrderId').val(oid);
            $('#UserId').val(uid);
            $('#ReturnModal').modal('show');
        }

        function showConfirmReceivedModal(uid, oid) {
            $('#ConfirmReceivedOrderId').val(oid);
            $('#ConfirmReceivedUserId').val(uid);
            $('#ConfirmReceivedModal').modal('show');
        }

        function clearCart() {
            $.ajax({
                url: 'clearOrdersServlet',
                type: 'POST',
                success: function (response) {
                    // alert(response);
                    if (response.status == 1) {
                        alert('订单已清空');
                        location.reload();
                    } else {
                        alert('清空订单失败');
                    }
                },
                error: function () {
                    alert('请求失败');
                }
            });
        }

        function Return() {
            var oid = $('#ReturnOrderId').val();
            var uid = $('#UserId').val();
            $.ajax({
                url: 'ReturnOrderServlet',
                type: 'POST',
                data: {uid: uid, oid: oid},
                success: function (response) {
                    if (response == 1) {
                        alert('订单退回');
                        location.reload();
                    } else {
                        alert('退货失败');
                    }
                },
                error: function () {
                    alert('请求失败');
                }
            });
        }

        function ConfirmReceived() {
            var oid = $('#ConfirmReceivedOrderId').val();
            var uid = $('#ConfirmReceivedUserId').val();
            $.ajax({
                url: 'ConfirmReceivedServlet',
                type: 'POST',
                data: {uid: uid, oid: oid},
                success: function (response) {
                    // alert(response);
                    if (response == 1) {
                        alert('确认收货成功！');
                        location.reload();
                    } else {
                        alert('确认收货失败');
                    }
                },
                error: function () {
                    alert('确认收货请求失败');
                }
            });
        }
    </script>
</head>
<body>
<div class="container">
    <h2><%= loggedUser.getUname() %>的订单管理</h2>
    <% if (orderList.isEmpty()) { %>
    <hr>
    <h3>您还没买过东西哦~</h3>
    <% } else { %>
    <% for (Order order : orderList) { %>
    <div class="cart-row">
        <div>
            <strong><%= order.getB_name() %></strong><br>
            订单编号：<%= order.getOid() %><br>
            收货人姓名：<%= order.getReceiver_name() %><br>
            客户联系方式：<%= order.getBuyer_tel() %><br>
            邮政编码：<%= order.getPostal_code() %><br>
            收货地址：<%= order.getBuyer_address() %><br>
            下单日期：<%= order.getOrder_date() %><br>
            数量：<input type="number" id="qty-<%= order.getBook_num() %>" value="<%= order.getBook_num() %>" min="1" style="width: 50px;" readonly><br>
            总价：<fmt:formatNumber value="<%= order.getSum_price() %>" type="currency"/><br>
            状态：<% if(order.getOrder_type() == 1){ %>
                已送达<br>
                <% }else if(order.getOrder_type() == 0){ %>
                运输中<br>
                <% }else if(order.getOrder_type() == -1){ %>
                已退货<br>
                <% } %>
        </div>
        <div class="cart-actions">
            <button class="btn btn-sm btn-danger" onclick="showDeleteModal('<%= order.getOid() %>', '<%= order.getB_name() %>')">删除</button>
            <% if (order.getOrder_type() == 0) { %>
            <button class="btn btn-sm btn-danger" onclick="showReturnModal('<%= order.getUid() %>', '<%= order.getOid() %>')">退货</button>
            <button class="btn btn-sm btn-danger" onclick="showConfirmReceivedModal('<%= order.getUid() %>', '<%= order.getOid() %>')">确认收货</button>
            <% } %>
        </div>
        <div style="clear: both;"></div>
    </div>
    <% } %>
    <button class="btn btn-warning" onclick="showClearCartModal()">清空订单</button>
    <% } %>
</div>

<!-- Delete Cart Modal -->
<div class="modal fade" id="deleteCartModal" tabindex="-1" role="dialog" aria-labelledby="deleteCartModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteCartModalLabel">删除历史订单</h5>
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
<div class="modal fade" id="clearCartModal" tabindex="-1" role="dialog" aria-labelledby="clearCartModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="clearCartModalLabel">清空历史订单（包括运送中的订单）</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>确定要清空历史订单吗？</p>
                <button type="button" class="btn btn-danger" onclick="clearCart()" data-dismiss="modal">清空</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<!-- Return Modal -->
<div class="modal fade" id="ReturnModal" tabindex="-1" role="dialog" aria-labelledby="ReturnModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="ReturnModalLabel">退货</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="ReturnOrderId">
                <input type="hidden" id="UserId">
                <p>确定要退货吗？</p>
                <button type="button" class="btn btn-danger" onclick="Return()" data-dismiss="modal">退货</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<!-- Confirm Received Modal -->
<div class="modal fade" id="ConfirmReceivedModal" tabindex="-1" role="dialog" aria-labelledby="ConfirmReceivedModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="ConfirmReceivedModalLabel">确定已经收到货了吗？</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="ConfirmReceivedOrderId">
                <input type="hidden" id="ConfirmReceivedUserId">
                <p>确定已经收到货了吗？</p>
                <button type="button" class="btn btn-danger" onclick="ConfirmReceived()" data-dismiss="modal">确认收货</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
