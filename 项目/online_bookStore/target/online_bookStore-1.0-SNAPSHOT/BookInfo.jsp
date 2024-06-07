<%@ page import="com.qdu.dao.impl.UserDaoImpl" %>
<%@ page import="com.qdu.model.Users" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    UserDaoImpl userDaoImpl = new UserDaoImpl();
    Users loggedUser = (Users) session.getAttribute("LoggedUser");
    request.setAttribute("loggedUser", loggedUser);
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="images/shortcut.png" rel="shortcut icon" type="image/x-icon"/>
    <title>详细信息</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <script src="js/wangEditor.min.js"></script>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script>
        $(document).ready(function () {
            // 加入购物车
            $("#btn_cart").click(function (e) {
                e.preventDefault();
                $.ajax({
                    url: 'AddShoppingCartServlet',      //跳转到AddShoppingCartServlet
                    type: 'POST',
                    data: {
                        qty: $("input[name='qty']").val(),
                        bid: $("input[name='bid']").val(),
                        b_price: $("input[name='b_price']").val(),
                        bookName: $("#bookName").text(),
                        bookType: $("#bookType").text(),
                        action: "add"
                    },
                    success: function (response) {
                        if (response == 1) {
                            alert("加入购物车成功！");
                        } else if (response == -1) {
                            alert("数据库报错，请重试！");
                        } else {
                            alert("加入购物车失败，请重试！");
                        }
                    },
                    error: function () {
                        alert("请求失败，请重试！");
                    }
                });
            });

            // 收藏
            $("#btn_collect").click(function (e) {
                e.preventDefault();
                $.ajax({
                    url: 'collection',      //跳转到CollectionServlet
                    type: 'POST',
                    data: {
                        bid: $("input[name='bid']").val(),
                        action: "collect"
                    },
                    success: function (response) {
                        if (response == 1) {
                            alert("收藏成功！");
                        } else if (response == -1) {
                            alert("数据库报错，请重试！");
                        } else {
                            alert("收藏失败，请重试！");
                        }
                    },
                    error: function () {
                        alert("请求失败，请重试！");
                    }
                });
            });
        });
    </script>

    <style>
        .btn-link {
            color: #fff;
            background-color: #f89406;
            border-color: #f89406;
            padding: 6px 12px;
            font-size: 14px;
            line-height: 1.42857143;
            border-radius: 3px;
            text-decoration: none;
        }
    </style>

    <script>
        document.getElementById('link_buy').addEventListener('click', function (e) {
            e.preventDefault();
            var qty = document.getElementById('qty').value;
            var bid = ${b.bid};
            var b_price = ${b.b_price};
            var link = 'ocs?qty=' + qty + '&bid=' + bid + '&b_price=' + b_price;
            window.location.href = link;
        });
    </script>
</head>
<body>

<h1 class="text-center text-primary">产品信息</h1>
<hr>
<br>

<div class="content">
    <br>
    <c:set var="b" value="${requestScope.bookInfo}"/>
    <img src="images/${b.bid}" class="pic">
    <h3 id="bookName">图书名称： ${b.b_bname} </h3>
    <p>图书单价： <fmt:formatNumber value="${b.b_price}" type="currency"/> </p>
    <p>剩余库存： ${b.b_num} </p>
    <p id="bookType">类型： ${b.b_type} </p>

    <form class="form-inline">
        <b>购买数量：</b>
        <input type="number" min="1" name="qty" value="1" class="form-control">
        <input type="hidden" name="bid" value="${b.bid}">
        <input type="hidden" name="b_price" value="${b.b_price}">
        <br><br>
        <button class="btn btn-sm btn-danger" id="btn_cart">加入购物车</button>
        <a href="ocs" class="btn-link" id="link_buy">立刻购买</a>
        <button class="btn btn-sm btn-warning" id="btn_collect">收藏</button>
    </form>
</div>

<br>
<hr>
<hr>

<div class="container">
    <h4 class="text-center text-primary">查看评论/发表评论</h4>
    <hr>
    <ul class="list">
        <li><a href="sbars?bid=${b.bid}">1. 查看所有评论</a></li>
        <li><a href="add_rate.jsp">2. 发表新评论</a></li>
    </ul>
    <hr>
</div>

<a href="ManageCart.jsp" class="cartImg">
    查看购物车<img src="images/cart.png" alt="购物车"/>
</a>
<a href="los" class="logout">
    退出登录
</a>

</body>
</html>
