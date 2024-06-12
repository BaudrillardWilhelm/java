<%@ page import="com.qdu.model.Book_info" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.locale}"/>
<fmt:setBundle basename="resources"/>
<%@ page session="false" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单确认</title>
    <style>
        .address-box {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 10px;
            cursor: pointer;
        }
        .address-box.selected {
            border-color: #007bff;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            padding-top: 60px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .order-info {
            margin-bottom: 15px;
        }
        .order-info span {
            font-weight: bold;
        }
        .form-control[readonly] {
            background-color: #f9f9f9;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function showAddressModal() {
            $('#addressModal').show();
        }
        function hideAddressModal() {
            $('#addressModal').hide();
        }
        function selectAddress() {
            var selectedOption = $('#addressSelect option:selected');
            $('#receiver_name').val(selectedOption.data('receiver'));
            $('#buyer_address').val(selectedOption.data('address'));
            $('#buyer_tel').val(selectedOption.data('tel'));
            $('#postal_code').val(selectedOption.data('postal'));
            hideAddressModal();
        }
        function confirmOrder() {
            var formData = $('#orderForm').serializeArray();
            $.ajax({
                url: 'addOneOrder',
                type: 'POST',
                data: formData,
                success: function (response) {
                    if (response.status === "success") {
                        alert('订单提交成功！');
                        window.location.href = 'index.jsp';  // 跳转到成功页面
                    } else if (response.status === "insufficient_funds") {
                        alert('账户余额不足，请先进行充值！');
                    } else if(response.status === "bookNumFalse") {
                        alert('很抱歉，此书库存不足！');
                    } else if (response.status === "Change_money_failed") {
                        alert('改钱失败了！');
                    } else {
                        alert('订单提交失败！');
                    }
                },
                error: function () {
                    alert('进入AddOrderServlet失败！ 请求失败');
                }
            });
        }
    </script>
</head>
<body>
<h1>订单确认</h1>
<h2>订单信息</h2>
<div class="container">
    <form id="orderForm" action="addOneOrder" method="post" class="form-horizontal">
        <div class="order-info">
            <label for="b_name">订单名称：</label>
            <input type="text" id="b_name" name="b_name" class="form-control" value="${order.b_name}" readonly>
        </div>
        <div class="order-info">
            <label for="book_num">数量：</label>
            <input type="number" id="book_num" name="book_num" class="form-control" value="${order.book_num}" readonly>
        </div>
        <div class="order-info">
            <label for="receiver_name">收货人：</label>
            <input type="text" id="receiver_name" name="receiver_name" class="form-control" value="${order.receiver_name}" readonly>
        </div>
        <div class="order-info">
            <label for="buyer_tel">联系方式：</label>
            <input type="text" id="buyer_tel" name="buyer_tel" class="form-control" value="${order.buyer_tel}" readonly>
        </div>
        <div class="order-info">
            <label for="buyer_address">收货地址：</label>
            <input type="text" id="buyer_address" name="buyer_address" class="form-control" value="${order.buyer_address}" readonly>
            <input type="text" id="postal_code" name="postal_code" class="form-control" value="${order.postal_code}" hidden>
            <input type="text" id="bid" name="bid" class="form-control" value="${order.bid}" hidden>
        </div>
        <div class="order-info">
            <label for="order_date">订单日期：</label>
            <input type="text" id="order_date" class="form-control" value="<fmt:formatDate value="${order.order_date}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly>
        </div>
        <div class="order-info">
            <label for="sum_price">总价格：</label>
            <input type="text" id="sum_price" name="sum_price" class="form-control" value="<fmt:formatNumber value="${order.sum_price}"/>" readonly>
        </div>
        <button type="button" class="btn btn-primary" onclick="confirmOrder()">确认下单</button>
    </form>
</div>
<button type="button" class="btn btn-primary" onclick="showAddressModal()">修改地址信息</button>
<!-- 模态窗口 -->
<div class="modal" id="addressModal">
    <div class="modal-content">
        <span class="close" onclick="hideAddressModal()">&times;</span>
        <h5>选择地址</h5>
        <select class="form-control address-select" id="addressSelect">
            <c:forEach var="address" items="${addressList}">
                <c:set var="buyer_address" value="${address.province},${address.city},${address.area},${address.info}" />
                <option value="${address.user_address_id}"
                        data-receiver="${address.receiver_name}"
                        data-address="${buyer_address}"
                        data-tel="${address.tel}"
                        data-postal="${address.postal_code}">
                        ${address.receiver_name} ${buyer_address} ${address.tel} ${address.postal_code}
                </option>
            </c:forEach>
        </select>
        <button type="button" class="btn btn-primary" onclick="selectAddress()">确定</button>
        <button type="button" class="btn btn-secondary" onclick="window.location.href='addAddress.jsp'">添加地址信息</button>
    </div>
</div>
</body>
</html>
