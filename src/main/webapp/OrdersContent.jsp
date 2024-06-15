<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page session="false" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.qdu.model.Order" %>
<%@ page import="com.qdu.model.Users" %>
<%@ page import="com.qdu.dao.impl.OrderDaoImpl" %>
<%@ page import="com.qdu.util.DateUtil" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%

    HttpSession session = request.getSession(false);
    Users loggedUser = (session != null) ? (Users) session.getAttribute("LoggedUser") : null;
    if (loggedUser == null) {
        response.sendRedirect("Userlogin.jsp");
        return;
    }
    int uid = loggedUser.getUid();
    String filter = request.getParameter("filter");
    if (filter == null) {
        filter = "all"; // 设置一个默认值，可以根据实际情况调整
    }
    System.out.println("-------------------------------------------" + filter);
    OrderDaoImpl orderDao = new OrderDaoImpl();
    List<Order> orderList;

    switch (filter) {

        case "week":
            orderList = orderDao.getOrdersWithinTimeFrame(uid, DateUtil.getStartDate(-7), new Date());
            break;
        case "month":
            orderList = orderDao.getOrdersWithinTimeFrame(uid, DateUtil.getStartDate(-30), new Date());
            break;
        case "half-year":
            orderList = orderDao.getOrdersWithinTimeFrame(uid, DateUtil.getStartDate(-180), new Date());
            break;
        case "delivered":
            orderList = orderDao.getDeliveredOrders(uid);
            break;
        case "rated":
            orderList = orderDao.getRatedOrderList(uid);
            break;
        case "undelivered":
            orderList = orderDao.getUndeliveredOrders(uid);
            break;
        default:
            orderList = orderDao.getOrdersByUserId(uid);
            break;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单列表</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</head>
<style>
    body {
        background-color: #f8f9fa;
        font-family: 'Arial', sans-serif;
        background-image: url("images/Bookbackground.png");
        background: no-repeat center center;
        background-size: cover;
    }
    .container {
        margin-top: 50px;
    }
    .card {
        border: none;
        margin-bottom: 20px;
        background-color: rgba(255, 255, 255, 0.8);
        border-radius: 10px;
        box-shadow: 0 0 90px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }
    .card-title {
        font-size: 1.5rem;
        color: #007bff;
        margin-bottom: 10px;
    }
    .card-subtitle {
        font-size: 1rem;
        color: #6c757d;
        margin-bottom: 5px;
    }
    .card-text {
        font-size: 1rem;
        color: #212529;
        margin-bottom: 0.5rem;
    }
    .btn-sm {
        margin-top: 0.5rem;
    }
    .btn-danger {
        background-color: #dc3545;
        border-color: #dc3545;
    }
    .btn-danger:hover {
        background-color: #c82333;
        border-color: #bd2130;
    }
    .cart-actions {
        display: flex;
        justify-content: space-between;
        margin-top: 10px;
    }
    .cart-row {
        border: 1px solid #ccc;
        padding: 10px;
        border-radius: 10px;
        margin-bottom: 20px;
    }
</style>
</head>
<body>
<div class="container">
    <div id="orderList">
        <% if (orderList.isEmpty()) { %>
        <div class="card">
            <h3>没有符合条件的订单!</h3>
        </div>
        <% } else { %>
        <% for (Order order : orderList) { %>
        <div class="card cart-row">
            <div class="card-body">
                <h5 class="card-title"><%= order.getB_name() %></h5>
                <p class="card-text">订单编号：<%= order.getOid() %></p>
                <p class="card-text">收货人姓名：<%= order.getReceiver_name() %></p>
                <p class="card-text">客户联系方式：<%= order.getBuyer_tel() %></p>
                <p class="card-text">邮政编码：<%= order.getPostal_code() %></p>
                <p class="card-text">收货地址：<%= order.getBuyer_address() %></p>
                <p class="card-text">下单日期：<%= order.getOrder_date() %></p>
                <p class="card-text">数量：<input type="number" id="qty-<%= order.getBook_num() %>" value="<%= order.getBook_num() %>" min="1" style="width: 50px;" readonly></p>
                <p class="card-text">总价：<%= new java.text.DecimalFormat("￥#,##0.00").format(order.getSum_price()) %></p>
                <p class="card-text">状态：<% if(order.getOrder_type() == 1){ %>已送达<% }else if(order.getOrder_type() == 0){ %>运输中<% }else if(order.getOrder_type() == -1){ %>已退货<% } %></p>
                <div class="cart-actions">
                    <button class="btn btn-sm btn-danger" onclick="showDeleteModal('<%= order.getOid() %>', '<%= order.getB_name() %>')">删除</button>
                    <% if (order.getOrder_type() == 0) { %>
                    <button class="btn btn-sm btn-danger" onclick="showReturnModal('<%= order.getUid() %>', '<%= order.getOid() %>')">退货</button>
                    <button class="btn btn-sm btn-danger" onclick="showConfirmReceivedModal('<%= order.getUid() %>', '<%= order.getOid() %>')">确认收货</button>
                    <% } %>
                </div>
            </div>
        </div>
        <% } %>
        <% } %>
    </div>
</div>

<!-- Delete Cart Modal -->
<!-- 修改后的 Delete Cart Modal -->
<div class="modal fade" id="deleteOrderModal" tabindex="-1" role="dialog" aria-labelledby="deleteOrderModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteOrderIdModalLabel">确认删除订单</h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                您确定要删除订单 <span id="deleteBookName"></span> 吗？
                <input type="hidden" id="deleteOrderId">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="deleteOrder()">删除</button>
            </div>
        </div>
    </div>
</div>

<script>
    function showDeleteModal(orderId, bookName) {
        $('#deleteBookName').text(bookName);
        $('#deleteOrderId').val(orderId); // 设置 orderId
        $('#deleteOrderModal').modal('show');
    }

    function deleteOrder() {
        var orderId = $('#deleteOrderId').val();
        $.ajax({
            type: 'POST',
            url: 'DeleteOrderServlet',
            data: { oid: orderId },
            success: function(response) {
                alert('订单已删除');
                location.reload();
            },
            error: function() {
                alert('删除失败');
            }
        });
    }
</script>


<script>
    function showReturnModal(uid, oid) {
        if (confirm('您确定要退货吗？')) {
            $.ajax({
                type: 'POST',
                url: 'OrderReturnServlet',
                data: { uid: uid, oid: oid },
                success: function(response) {
                    alert('退货成功');
                    location.reload();
                },
                error: function() {
                    alert('退货失败');
                }
            });
        }
    }


    function showConfirmReceivedModal(uid, oid) {
        if (confirm('您确定已经收到货物了吗？')) {
            $.ajax({
                type: 'POST',
                url: 'OrderReceiveServlet',
                data: { uid: uid, oid: oid },
                success: function(response) {
                    if(response == 1)
                    {
                        alert('确认收货成功');
                        location.reload();
                    }
                    else{
                        alert('result =0 ,失败！');
                    }
                },
                error: function() {
                    alert('确认收货失败');
                }
            });
        }
    }

    function showClearCartModal() {
        // alert('clear');
        if (confirm('您确定要清空订单吗？')) {
            $.ajax({
                type: 'POST',
                url: 'OrderClearServlet',
                success: function(response) {
                    alert('订单已清空');
                    location.reload();
                },
                error: function() {
                    alert('清空订单失败');
                }
            });
        }
    }
</script>

</body>
</html>
