<%@ page import="com.qdu.dao.impl.UserDaoImpl" %>
<%@ page import="com.qdu.model.Users" %>
<%@ page import="com.qdu.model.Book_info" %>
<%@ page import="com.qdu.model.Collection" %>
<%@ page import="java.util.List" %>
<%@ page import="com.qdu.dao.impl.CollectionDaoImpl" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    UserDaoImpl userDaoImpl = new UserDaoImpl();
    HttpSession session = request.getSession(false);
    Users loggedUser = (session != null) ? (Users) session.getAttribute("LoggedUser") : null;
    if(null  == loggedUser)
    {
        response.sendRedirect("Userlogin.jsp");
        return;
    }
    String type_name = (String )request.getAttribute("type_name");
    CollectionDaoImpl collectionDao = new CollectionDaoImpl();
    int uid = (loggedUser != null) ? loggedUser.getUid() : 0;
    List<Collection> collectionList = (session != null ) ? collectionDao.getCollectionsByUserId(uid) : null;
%>
<% Book_info book = (Book_info) request.getAttribute("bookInfo"); %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="images/shortcut.png" rel="shortcut icon" type="image/x-icon"/>
    <title>详细信息</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <script src="js/wangEditor.min.js"></script>
    <script src="js/jquery-3.4.1.min.js"></script>
    <style>
        .iframe-container {
            margin-top: 30px; /* 调整 iframe 上边距 */
        }

        .iframe-content {
            border: none; /* 去掉 iframe 边框 */
            width: 100%;
            height: 600px; /* 设置 iframe 高度 */
        }
        .logout{
            top: 58px;
            right: 195px;
        }

        .cartImg img{
            width: 40px;
            height: 40px;
        }

        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #f9f9f9;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .content {
            display: flex;
            align-items: flex-start;
            margin: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .book-img {
            /*flex: 150px; !* 固定宽度 *!*/
            /*height: 300px; !* 固定高度 *!*/
            margin-right: 50px; /* 图片与信息之间的间距 */
            margin-top: 50px; /* 上边距 */
            margin-left: 90px; /* 左边距 */
        }

        .book-img img {
            flex: 200px; /* 固定宽度 */
            height: 450px; /* 固定高度 */
            object-fit: contain; /* 保持图片比例并尽量填充 */
            border-radius: 20px;
        }
        img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 10px;
        }
        .book-info {
            flex: 1;
            padding: 20px;
        }

        .btn-action {
            padding: 10px 20px;
            font-size: 12px;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s;
            display: inline-block;
            margin-right: 10px;
            width: 100px; /* 统一宽度 */
            text-align: center;
        }

        .btn-cart, .btn-link, .btn-warning {
            color: #fff;
            border: none;
        }

        .btn-cart {
            background-color: #f89406;
        }

        .btn-link {
            background-color: #FFB300;
        }

        .btn-warning {
            background-color: #f0ad4e;
        }

        .btn-action:hover {
            background-color: #d97806;
        }

        .product-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        .product-price {
            color: #f89406;
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .product-info {
            margin-bottom: 15px;
            font-size: 18px;
            color: #555;
        }
        .form-inline .form-group {
            margin-bottom: 15px;
        }
        .form-control {
            display: inline-block;
            width: auto;
            vertical-align: middle;
        }
    </style>
    <script>
        $(document).ready(function () {
            // 加入购物车
            $("#btn_cart").click(function (e) {
                e.preventDefault();
                $.ajax({
                    url: 'AddShoppingCartServlet',
                    type: 'POST',
                    data: {
                        qty: $("input[name='qty']").val(),
                        bid: <%=book.getBid()%>,
                        type_name: "<%=type_name%>"
                    },
                    success: function (response) {
                        var resArray = response.split(",");
                        if (resArray[0] == "1") {
                            alert("加入购物车成功！");
                        } else if (resArray[0] == "-1") {
                            alert("数据库报错，请重试！");
                        } else if (resArray[0] == "2") {
                            var confirmAdd = confirm("您已在购物车中添加过本书，书名:" + resArray[1] + " 数量:" + resArray[2] + " 总价:" + resArray[3] + "，是否继续追加？");
                            if (confirmAdd) {
                                $.ajax({
                                    url: 'SecondAddShoppingCartServlet',
                                    type: 'POST',
                                    data: {
                                        qty: $("input[name='qty']").val(),
                                        bid: <%=book.getBid()%>,
                                        type_name: "<%=type_name%>",
                                        add: true
                                    },
                                    success: function (response) {
                                        if (response == "1") {
                                            alert("加入购物车成功！");
                                        } else {
                                            alert("加入购物车失败，可能数据库报错，请重试！");
                                        }
                                    },
                                    error: function () {
                                        alert("加入购物车请求失败，请重试！");
                                    }
                                });
                            }
                        } else {
                            alert("加入购物车失败，请重试！");
                        }
                    },
                    error: function () {
                        alert("加入购物车请求失败，请重试！");
                    }
                });
            });

            // 收藏
            $("#btn_collect").click(function (e) {
                $.ajax({
                    url: 'collection',
                    type: 'POST',
                    data: {
                        uid: <%=loggedUser.getUid()%>,
                        bid: <%=book.getBid()%>,
                        type_name: "<%=type_name%>",
                        action: "collect"
                    },
                    success: function (response) {
                        if (response == 1) {
                            location.reload();
                        } else if (response == -1) {
                            alert("数据库报错，请重试！");
                        } else {
                            alert("收藏失败，请重试！");
                        }
                    },
                    error: function () {
                        alert("加入收藏请求失败，请重试！");
                    }
                });
            });

            // 取消收藏
            $("#btn_cancel_collect").click(function (e) {
                $.ajax({
                    url: 'collection',
                    type: 'POST',
                    data: {
                        uid: <%=loggedUser.getUid()%>,
                        bid: <%=book.getBid()%>,
                        type_name: "<%=type_name%>",
                        action: "remove"
                    },
                    success: function (response) {
                        if (response == 1) {
                            location.reload();
                        } else if (response == -1) {
                            alert("数据库报错，请重试！");
                        } else {
                            alert("取消收藏失败，请重试！");
                        }
                    },
                    error: function () {
                        alert("取消收藏请求失败，请重试！");
                    }
                });
            });
            // 立刻购买
            $("#link_buy").click(function (e) {
                var qty = $("input[name='qty']").val();
                var bid = <%=book.getBid()%>;
                var b_price = <%=book.getBPrice()%>;
                var link = 'ocs?qty=' + qty + '&bid=' + bid + '&b_price=' + b_price;
                window.location.href = link;
            });
        });
    </script>
</head>
<body>
<a href="ManageCart.jsp" class="cartImg">
    查看购物车<img src="images/cart.png" alt="购物车"/>
</a>
<a href="los" class="logout">
    退出登录
</a>
<div class="container">
    <h1 class="text-center text-primary">图书信息</h1>
    <hr>
    <br>

    <div class="content">
        <div class="book-img">
            <img src="<%=book.getBImgpath()%>" alt="<%=book.getBName()%>"/>
        </div>
        <div class="book-info">
            <p class="product-title"><%=book.getBName()%></p>
            <p class="product-info"><b>评分：</b> <%=book.getRateNumber()%></p>
            <p class="product-info"><b>作者：</b><%=book.getAuthor()%></p>
            <p class="product-info"><b>入库时间：</b><%=book.getStorageTime()%></p>
            <p class="product-info"><b>类型：</b><%=request.getAttribute("type_name")%></p>
            <p class="product-info"><b>图书详情：</b><%=book.getBInfo()%></p>
            <p class="product-price"><b>图书单价：</b> <fmt:formatNumber value="<%=book.getBPrice()%>" type="currency"/> </p>
            <p class="product-info"><b>剩余库存：</b><%=book.getBNum()%></p>
            <p class="product-info"><b>折扣：</b><%=book.getDiscount()%></p>

            <form class="form-inline">
                <div class="form-group">
                    <label>购买数量：</label>
                    <input type="number" min="1" name="qty" value="1" class="form-control">
                </div>
                <input type="hidden" name="bid" value="<%=book.getBid()%>">
                <input type="hidden" name="b_price" value="<%=book.getBPrice()%>">
                <br><br>
                <button class="btn-action btn-cart" id="btn_cart">加入购物车</button>
                <a href="#" class="btn-action btn-link" id="link_buy">立刻购买</a>
                <% boolean collectionExisted = false;
                    if(collectionList != null )
                    {
                        for(Collection collection:collectionList)
                        {
                            if(collection.getBid() == book.getBid())
                            {
                                collectionExisted = true;
                            }
                        }
                    }
                %>
                <% if(collectionExisted){ %>
                <button class="btn-action btn-warning" id="btn_cancel_collect" type="button">已收藏</button>
                <% }else{ %>
                <button class="btn-action btn-warning" id="btn_collect" type="button">收藏</button>
                <% } %>
            </form>

        </div>
    </div>
</div>
    <hr>
    <iframe class="iframe-content" src="sbars?uid=<%=loggedUser.getUid()%>&bid=<%=book.getBid()%>"></iframe>



</body>
</html>

