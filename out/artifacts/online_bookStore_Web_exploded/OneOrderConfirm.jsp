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
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
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
        .order-info label {
            font-weight: bold;
        }
        .form-control[readonly] {
            background-color: #f9f9f9;
        }
        .btn-container {
            margin-top: 20px;
        }
    </style>

    <style>
        .navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #f8f9fa;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .navbar .logo-title {
            display: flex;
            align-items: center;
        }
        .webSitelogo {
            height: 80px;
            margin-right: 10px;
        }
        .navbar h1 {
            font-size: 1.5em;
            margin: 0;
            color: #343a40;
        }
        .navbar a {
            margin: 0 5px;
            padding: 10px 5px;
            text-decoration: none;
            color: #007bff;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .navbar a:hover {
            background-color: #007bff;
            color: white;
        }
        .smallLogo {
            margin-right: 4px;
            height: 40px;
            width: 40px;
        }
        .line-form-input {
            outline: 0 !important;
            border: none;
            display: block;
            width: 50%;
            padding: 1em 2em .4em .3em;
            opacity: .8;
            transition: .3s;
            background: 0 0 !important;
            border-bottom: 2px solid transparent; /* 初始状态下的下划线 */
        }
        .line-form-input:focus {
            border-bottom: 2px solid blue; /* 获得焦点时的下划线 */
        }
        .navbar form {
            display: flex;
            align-items: center;
        }
        .navbar form select, .navbar form input, .navbar form button {
            margin-left: 5px;
        }
        .navbar form button {
            padding: 8px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .navbar form button:hover {
            background-color: #0056b3;
        }
        .navbar form select {
            background-color: #f0f0f0;
            border: 1px solid #ddd;
            padding: 5px;
            border-radius: 5px;
        }
    </style>
    <style>
        .navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #f8f9fa;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .navbar .logo-title {
            display: flex;
            align-items: center;
        }

        .webSitelogo {
            height: 80px;
            margin-right: 10px;
        }
        .navbar h1 {
            font-size: 1.5em;
            margin: 0;
            color: #343a40;
        }
        .navbar a {
            margin: 0 5px;
            padding: 10px 5px;
            text-decoration: none;
            color: #007bff;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .navbar a:hover {
            background-color: #007bff;
            color: white;
        }
        .smallLogo {
            margin-right: 4px;
            height: 40px;
            width: 40px;
        }
        .line-form-input {
            outline: 0 !important;
            border: none;
            display: block;
            width: 50%;
            padding: 1em 2em .4em .3em;
            opacity: .8;
            transition: .3s;
            background: 0 0 !important;
            border-bottom: 2px solid transparent; /* 初始状态下的下划线 */
        }
        .line-form-input:focus {
            border-bottom: 2px solid blue; /* 获得焦点时的下划线 */
        }
        .navbar form {
            display: flex;
            align-items: center;
        }
        .navbar form select, .navbar form input, .navbar form button {
            margin-left: 5px;
        }
        .navbar form button {
            padding: 8px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .navbar form button:hover {
            background-color: #0056b3;
        }
        .navbar form select {
            background-color: #f0f0f0;
            border: 1px solid #ddd;
            padding: 5px;
            border-radius: 5px;
        }
    </style>
    <style>
        .footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            background-color: gray;
            padding: 20px;
            text-align: center;
            border-top: 1px solid #ddd;
        }

        /* 如果需要样式 p 和 a，可以继续添加 */
        .footer p {
            margin: 0;
            color: #343a40;
        }

        .footer a {
            color: #007bff;
            text-decoration: none;
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

<div class="navbar">
    <div class="logo-title">
        <img src="images/logo.png" alt="网上书店logo" class="webSitelogo">
        <a href="index.jsp"><h1>欢迎来到网上书店，购尽好书！</h1></a>
    </div>
    <div>
        <a href="Collection.jsp">
            <img src="images/收藏.png" alt="" class="smallLogo">
            收藏
        </a>
        <a href="ManageOrders.jsp">
            <img src="images/订单.png" alt="" class="smallLogo">
            订单
        </a>
        <c:choose>
            <c:when test="${empty loggedUser}">
                <a href="Userlogin.jsp">
                    <img src="images/评论区.png" alt="" class="smallLogo">
                    评论
                </a>
                <a href="Userlogin.jsp">
                    <img src="images/个人中心.png" alt="" class="smallLogo">
                    个人中心
                </a>
            </c:when>
            <c:otherwise>
                <a href="suars?uid=${loggedUser.getUid()}">
                    <img src="images/评论区.png" alt="" class="smallLogo">
                    评论
                </a>
                <a href="UserManager.jsp">
                    <img src="images/个人中心.png" alt="" class="smallLogo">
                        ${loggedUser.getUname()}个人中心
                </a>
            </c:otherwise>
        </c:choose>


        <a href="ManageCart.jsp">
            <img src="images/购物车.png" alt="" class="smallLogo">
            购物车
        </a>
        <a href="LogoutServlet">
            <img src="images/离开-1.png" alt="" class="smallLogo">
            退出
        </a>
    </div>
    <form action="SearchBooksServlet" method="get">
        <select name="searchType">
            <option value="name">按书名搜索</option>
            <option value="author">按作者搜索</option>
        </select>
        <input type="text" name="keyword" placeholder="搜索书籍..." class="line-form-input">
        <button type="submit">搜索</button>
    </form>
</div>

<div class="container">
    <h1>订单确认</h1>
    <h2>订单信息</h2>
    <form id="orderForm" action="addOneOrder" method="post">
        <div class="form-group order-info">
            <label for="b_name">订单名称：</label>
            <input type="text" id="b_name" name="b_name" class="form-control" value="${order.b_name}" readonly>
        </div>
        <div class="form-group order-info">
            <label for="book_num">数量：</label>
            <input type="number" id="book_num" name="book_num" class="form-control" value="${order.book_num}" readonly>
        </div>
        <div class="form-group order-info">
            <label for="receiver_name">收货人：</label>
            <input type="text" id="receiver_name" name="receiver_name" class="form-control" value="${order.receiver_name}" readonly>
        </div>
        <div class="form-group order-info">
            <label for="buyer_tel">联系方式：</label>
            <input type="text" id="buyer_tel" name="buyer_tel" class="form-control" value="${order.buyer_tel}" readonly>
        </div>
        <div class="form-group order-info">
            <label for="buyer_address">收货地址：</label>
            <input type="text" id="buyer_address" name="buyer_address" class="form-control" value="${order.buyer_address}" readonly>
            <input type="text" id="postal_code" name="postal_code" class="form-control" value="${order.postal_code}" hidden>
            <input type="text" id="bid" name="bid" class="form-control" value="${order.bid}" hidden>
        </div>
        <div class="form-group order-info">
            <label for="order_date">订单日期：</label>
            <input type="text" id="order_date" class="form-control" value="<fmt:formatDate value="${order.order_date}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly>
        </div>
        <div class="form-group order-info">
            <label for="sum_price">总价格：</label>
            <input type="text" id="sum_price" name="sum_price" class="form-control" value="<fmt:formatNumber value="${order.sum_price}"/>" readonly>
        </div>
        <div class="btn-container">
            <button type="button" class="btn btn-primary" onclick="confirmOrder()">确认下单</button>
            <button type="button" class="btn btn-secondary" onclick="showAddressModal()">修改地址信息</button>
        </div>
    </form>
</div>

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
        <div class="btn-container">
            <button type="button" class="btn btn-primary" onclick="selectAddress()">确定</button>
            <button type="button" class="btn btn-secondary" onclick="window.location.href='addAddress.jsp'">添加地址信息</button>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<div class="footer">
    <p>&copy; 2024 网上书店. 保留所有权利.</p>
    <p>开发人员：董守昱，刘依洋，袁淇浩</p>
</div>
</body>
</html>
