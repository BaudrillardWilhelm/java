<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.locale}" />
<fmt:setBundle basename="resources" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
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
    </style>
    <script>
        function showModal() {
            document.getElementById('addressModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('addressModal').style.display = 'none';
        }

        function selectAddress(address) {
            document.getElementById('selectedAddress').innerHTML = address.innerHTML;
            closeModal();
        }

        window.onclick = function(event) {
            if (event.target == document.getElementById('addressModal')) {
                closeModal();
            }
        }
    </script>
</head>
<body>
<h1>订单确认</h1>

<h2>订单信息</h2>
<p>图书名称: ${order.bname}</p>
<p>购买数量: ${order.book_num}</p>
<p>总价: ${order.sum_price}</p>

<h2>收货地址</h2>
<div class="address-box" onclick="showModal()" id="selectedAddress">
    <p>收货人: ${addressList[0].receiverName}</p>
    <p>地址: ${addressList[0].buyerAddress}</p>
    <p>电话: ${addressList[0].buyerTel}</p>
    <p>邮政编码: ${addressList[0].postalCode}</p>
</div>

<!-- 模态窗口 -->
<div id="addressModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>选择收货地址</h2>
        <c:forEach var="address" items="${addressList}">
            <div class="address-box" onclick="selectAddress(this)">
                <p>收货人: ${address.receiverName}</p>
                <p>地址: ${address.buyerAddress}</p>
                <p>电话: ${address.buyerTel}</p>
                <p>邮政编码: ${address.postalCode}</p>
            </div>
        </c:forEach>
        <a href="addAddress.jsp">新增收货地址</a>
    </div>
</div>

<form action="order" method="post">
    <input type="hidden" name="receiverName" value="${addressList[0].receiverName}">
    <input type="hidden" name="buyerAddress" value="${addressList[0].buyerAddress}">
    <input type="hidden" name="buyerTel" value="${addressList[0].buyerTel}">
    <input type="hidden" name="postalCode" value="${addressList[0].postalCode}">
    <input type="hidden" name="bid" value="${order.bid}">
    <input type="hidden" name="bname" value="${order.bname}">
    <input type="hidden" name="bookNum" value="${order.book_num}">
    <input type="hidden" name="sumPrice" value="${order.sum_price}">
    <button type="submit">确认下单</button>
</form>
</body>
</html>
