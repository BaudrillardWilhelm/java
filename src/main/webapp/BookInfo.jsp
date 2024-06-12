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
    String type_name = (String )request.getAttribute("type_name");
    CollectionDaoImpl collectionDao = new CollectionDaoImpl();
    int uid = (session != null) ? loggedUser.getUid(): 0;
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
    <link rel="stylesheet" href="css/style.css"/>
    <script src="js/wangEditor.min.js"></script>
    <script src="js/jquery-3.4.1.min.js"></script>
    <style>
        img {
            width: 50%;
            height: 100%;
            max-height: 200px;
            object-fit: cover;
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
                            alert("收藏成功！");
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
                            alert("已取消收藏！");
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
</head>
<body>

<h1 class="text-center text-primary">图书信息</h1>
<hr>
<br>

<div class="content">
    <br>

    <img src="<%=book.getBImgpath()%>" alt="<%=book.getBName()%>"/>
    <hr>
    图书名称：<%=book.getBName()%> <br>
    评分：<%=book.getRateNumber()%> <br>
    作者：<%=book.getAuthor()%> <br>
    入库时间：<%=book.getStorageTime()%> <br>
    类型：<%=request.getAttribute("type_name")%> <br>
    图书详情：<%=book.getBInfo()%> <br>
    <p>图书单价： <fmt:formatNumber value="<%=book.getBPrice()%>" type="currency"/> </p> <br>
    <p>剩余库存： <%=book.getBNum()%> </p> <br>
    <p>折扣：<%=book.getDiscount()%></p> <br>
    <p id="bookType">类型： <%=type_name%> </p>

    <form class="form-inline">
        <b>购买数量：</b>
        <input type="number" min="1" name="qty" value="1" class="form-control">
        <input type="hidden" name="bid" value="<%=book.getBid()%>">
        <input type="hidden" name="b_price" value="<%=book.getBPrice()%>">
        <br><br>
        <button class="btn btn-sm btn-danger" id="btn_cart" >加入购物车</button>
        <a href="#" class="btn-link" id="link_buy">立刻购买</a>
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
            <button class="btn btn-sm btn-warning" id="btn_cancel_collect" type="button">已收藏</button>
        <% }else{ %>
            <button class="btn btn-sm btn-warning" id="btn_collect" type="button">收藏</button>
        <% } %>
    </form>
</div>

<br>
<hr>
<hr>

<div class="container">
    <h4 class="text-center text-primary">查看评论/发表评论</h4>
    <hr>
    <ul class="list">
        <li><a href="sbars?uid=<%=loggedUser.getUid()%>&bid=<%=book.getBid()%>">1. 查看所有评论</a></li>
        <li><a href="banrs?uid=<%=loggedUser.getUid()%>&bid=<%=book.getBid()%>">2. 发表新评论</a></li>
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
