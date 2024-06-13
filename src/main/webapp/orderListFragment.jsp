<%@ page import="java.util.List" %>
<%@ page import="com.qdu.model.Order" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    List<Order> orderList = (List<Order>) request.getAttribute("orderList");
    if (orderList != null && !orderList.isEmpty()) {
        for (Order order : orderList) {
%>
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
<%
    }
} else {
%>
<hr>
<h3>未找到符合条件的订单</h3>
<%
    }
%>
