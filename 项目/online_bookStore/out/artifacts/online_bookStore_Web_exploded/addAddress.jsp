<%@ page import="com.qdu.dao.impl.UserDaoImpl" %>
<%@ page import="com.qdu.model.Users" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    Users loggedUser = (Users) session.getAttribute("LoggedUser");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>新增收货地址</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <style>
        .container {
            max-width: 600px;
            margin: 50px auto;
        }
    </style>
    <script>
        function addAddress() {
            var province = $('#province').val();
            var city = $('#city').val();
            var area = $('#area').val();
            var info = $('#info').val();
            var receiverName = $('#receiverName').val();
            var buyerTel = $('#buyerTel').val();
            var postalCode = $('#postalCode').val();
            var accurateAddress = province + city + area + info;

            $.ajax({
                url: 'addAddressServlet',
                type: 'POST',
                data: {
                    province:province,
                    city:city,
                    area:area,
                    info:info,
                    receiverName: receiverName,
                    buyerTel: buyerTel,
                    postalCode: postalCode
                },
                success: function(response) {
                    if (response == 1) {
                        alert('地址添加成功');
                        window.location.href = 'OneOrderConfirm.jsp';
                    } else if (response == 0) {
                        alert('地址添加失败');
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
    <h2>新增收货地址</h2>
    <form onsubmit="addAddress(); return false;">
        <div class="form-group">
            <label for="receiverName">收货人姓名</label>
            <input type="text" class="form-control" id="receiverName" required>
        </div>
        <div class="form-group">
            <label for="buyerTel">电话</label>
            <input type="text" class="form-control" id="buyerTel" required>
        </div>
        <div class="form-group">
            <label for="postalCode">邮政编码</label>
            <input type="text" class="form-control" id="postalCode" required>
        </div>
        <div class="form-group">
            <label for="province">省</label>
            <select class="form-control" id="province" required>
                <!-- Add options for provinces -->
            </select>
        </div>
        <div class="form-group">
            <label for="city">市</label>
            <select class="form-control" id="city" required>
                <!-- Add options for cities -->
            </select>
        </div>
        <div class="form-group">
            <label for="area">区</label>
            <select class="form-control" id="area" required>
                <!-- Add options for areas -->
            </select>
        </div>
        <div class="form-group">
            <label for="info">详细地址</label>
            <input type="text" class="form-control" id="info" required>
        </div>
        <button type="submit" class="btn btn-primary">提交</button>
    </form>
</div>
</body>
</html>
