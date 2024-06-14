<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.qdu.dao.impl.UserDaoImpl" %>
<%@ page import="com.qdu.model.Users" %>
<%@ page import="com.qdu.model.Collection" %>
<%@ page import="com.qdu.dao.impl.CollectionDaoImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="com.qdu.dao.impl.Book_infoDaoImpl" %>
<%@ page import="com.qdu.model.Book_info" %>
<%@ page session="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    UserDaoImpl userDaoImpl = new UserDaoImpl();
    request.setAttribute("userDaoImpl", userDaoImpl);
    HttpSession session = request.getSession();
    Users loggedUser = (session != null) ? (Users) session.getAttribute("LoggedUser") : null;
    if (loggedUser == null) {
        // 如果loggedUser为null，重定向到Userlogin.jsp
        response.sendRedirect("Userlogin.jsp");
        return; // 确保在重定向后不再执行JSP页面的其余部分
    }
    request.setAttribute("loggedUser", loggedUser);
    CollectionDaoImpl collectionDao = new CollectionDaoImpl();
    int uid = loggedUser.getUid();
    List<Collection> collectionList = collectionDao.getCollectionsByUserId(uid);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${loggedUser.uname}的收藏列表</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js" charset="UTF-8"></script>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
            background-image: url("images/Bookbackground.png");
            background: no-repeat center center;
            background-size: cover;
        }
        .content {
            display: flex;
            align-items: flex-start;
            margin: 20px 0;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            box-shadow: 0 0 90px rgba(0, 0, 0, 0.1);
            width: 1200px;
        }
        .book-img img {
            padding-top: 20px;
            padding-left: 20px;
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 10px;
            padding-right: 30px;
        }
        .card {
            flex: 1;
            border: none;
        }
        .card-title a {
            font-size: 1.5rem;
            color: #007bff;
            text-decoration: none;
        }
        .card-subtitle {
            font-size: 1rem;
            color: #6c757d;
        }
        .card-text {
            font-size: 1rem;
            color: #212529;
            margin-bottom: 0.5rem;
        }
        .btn-sm {
            margin-top: 0.5rem;
        }
        .container {
            margin-top: 50px;
        }
        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }
        .product-info {
            margin-bottom: 15px;
            font-size: 2rem;
            color: #555;
        }
        .btn-danger:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        h1 {
            font-size: 5rem;
            margin: 0;
        }
        #clearAllBtn {
            background-color: #dc3545;
            border-color: #dc3545;
        }
        #clearAllBtn:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }

        .card-title {
            font-size: 3rem;
            color: #007bff;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1><b><center>${loggedUser.uname}的收藏列表</center> </b></h1>
        <button id="clearAllBtn" class="btn btn-danger">清空收藏夹</button>
    </div>

    <% Book_infoDaoImpl bookInfoDao = new Book_infoDaoImpl(); %>
    <%for(Collection collection:collectionList){ %>
    <a href="SearchOneBookInfoServlet?bid=<%=collection.getBid()%>">
        <div class="comment-section content">

            <% Book_info book = bookInfoDao.findBookById(collection.getBid()); %>
            <div class="book-img">
                <img src="<%=book.getBImgpath()%>" alt="<%=book.getBName()%>"/>
            </div>
            <div class="card" id="row-<%=collection.getBid()%>">
                <div class="card-body">
                    <h5 class="card-title">书名：<%=collection.getBook_name()%></h5>
                    <p class="product-info"><b>评分：</b> <%=book.getRateNumber()%></p>
                    <p class="product-info"><b>作者：</b><%=book.getAuthor()%></p>
                    <p class="product-info"><b>图书详情：</b><%=book.getBInfo()%></p>
                    <p class="product-info"><b>加入收藏时间：<%=collection.getBook_time()%> </b></p>
                    <div style="justify-content: space-between;">
                        <p class="product-info"><b>类型：<%=collection.getBook_type()%></b></p>
                        <button class="btn btn-danger btn-sm remove-btn" data-bid="<%=collection.getBid()%>">移除</button>
                    </div>
                </div>
            </div>
        </div>
    </a>
    <% } %>
</div>

<script>
    $(document).ready(function() {
        $(".remove-btn").click(function() {
            var bid = $(this).data("bid");
            $.ajax({
                url: 'collection',
                type: 'POST',
                data: {
                    action: 'remove',
                    bid: bid
                },
                success: function(response) {
                    if (response == 1) {
                        $("#row-" + bid).remove();
                        alert("移除成功！");
                    } else {
                        alert("移除失败！");
                    }
                },
                error: function() {
                    alert("请求失败！");
                }
            });
        });

        $("#clearAllBtn").click(function() {
            if (confirm("你确定要清空所有内容吗？")) {
                $.ajax({
                    url: 'collection',
                    type: 'POST',
                    data: {
                        action: 'clearAll'
                    },
                    success: function(response) {
                        if (response == 1) {
                            $(".content").remove();
                            alert("收藏夹已清空！");
                        } else {
                            alert("清空失败！");
                        }
                    },
                    error: function() {
                        alert("请求失败！");
                    }
                });
            }
        });
    });
</script>
</body>
</html>
