<%@ page session="false" %>
<%@ page import="com.qdu.model.Users" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    HttpSession session = request.getSession(false);
    Users loggedUser = (session != null)?(Users) session.getAttribute("LoggedUser"):null;
    if (loggedUser == null) {
        response.sendRedirect("Userlogin.jsp");
        return;
    }
    int uid = loggedUser.getUid();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单管理</title>
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
        .button-group {
            margin: 20px;
        }
        .button-group button {
            margin-right: 10px;
        }
        iframe {
            width: 100%;
            height: 600px;
            border: none;
        }
    </style>
    <script>

        function openPage(page) {
            var filter ;
            var iframe = document.getElementById('iframe');
            iframe.src = page;
        }

        $(document).ready(function() {
            openPage('OrdersContent.jsp'); // 默认加载所有订单
        });
    </script>
</head>
<body>
<div class="container">
    <h2><%= loggedUser.getUname() %>的订单管理</h2>

    <!-- Search Bar -->
    <form id="searchForm" class="form-inline mb-4">
        <input type="text" class="form-control mr-2" id="searchKeyword" placeholder="搜索图书名">
        <button type="submit" class="btn btn-primary">搜索</button>
    </form>

    <!-- 功能选择按钮组 -->
    <div class="button-group">
        <button class="btn btn-primary" onclick="openPage('OrdersContent.jsp?filter=all')">所有订单</button>
        <button class="btn btn-secondary" onclick="openPage('OrdersContent.jsp?filter=week')">最近一周</button>
        <button class="btn btn-secondary" onclick="openPage('OrdersContent.jsp?filter=month')">最近一个月</button>
        <button class="btn btn-secondary" onclick="openPage('OrdersContent.jsp?filter=half-year')">最近半年</button>
        <button class="btn btn-secondary" onclick="openPage('OrdersContent.jsp?filter=delivered')">已送达</button>
        <button class="btn btn-secondary" onclick="openPage('OrdersContent.jsp?filter=rated')">已评价</button>
        <button class="btn btn-secondary" onclick="openPage('OrdersContent.jsp?filter=undelivered')">未送达</button>
    </div>

    <!-- 分区内容 -->
    <div class="content">
        <iframe src="" id="iframe"></iframe>
    </div>
</div>
</body>
</html>
