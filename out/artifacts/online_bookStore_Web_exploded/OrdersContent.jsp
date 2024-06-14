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
<body>
<div class="container">
    <div id="orderList">
        <% if (orderList.isEmpty()) { %>
        <hr>
        <h3>没有符合条件的订单!</h3>
        <% } else { %>
        <% for (Order order : orderList) { %>
        <div class="cart-row">
            <hr>
            <div>
                <strong><%= order.getB_name() %></strong><br>
                订单编号：<%= order.getOid() %><br>
                收货人姓名：<%= order.getReceiver_name() %><br>
                客户联系方式：<%= order.getBuyer_tel() %><br>
                邮政编码：<%= order.getPostal_code() %><br>
                收货地址：<%= order.getBuyer_address() %><br>
                下单日期：<%= order.getOrder_date() %><br>
                数量：<input type="number" id="qty-<%= order.getBook_num() %>" value="<%= order.getBook_num() %>" min="1" style="width: 50px;" readonly><br>
                总价：<%= new java.text.DecimalFormat("￥#,##0.00").format(order.getSum_price()) %><br>
                状态：<% if(order.getOrder_type() == 1){ %>
                已送达<br>
                <% }else if(order.getOrder_type() == 0){ %>
                运输中<br>
                <% }else if(order.getOrder_type() == -1){ %>
                已退货<br>
                <% } %>
            </div>
            <div class="cart-actions justify-content: space-between;">
                <button class="btn btn-sm btn-danger" onclick="showDeleteModal('<%= order.getOid() %>', '<%= order.getB_name() %>')">删除</button>
                <% if (order.getOrder_type() == 0) { %>
                <button class="btn btn-sm btn-danger" onclick="showReturnModal('<%= order.getUid() %>', '<%= order.getOid() %>')">退货</button>
                <button class="btn btn-sm btn-danger" onclick="showConfirmReceivedModal('<%= order.getUid() %>', '<%= order.getOid() %>')">确认收货</button>
                <hr>
                <% } %>
            </div>
            <div style="clear: both;"></div>
        </div>
        <% } %>
        <button class="btn btn-warning" onclick="showClearCartModal()">清空订单</button>
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
