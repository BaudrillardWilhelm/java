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
        <% if(null == loggedUser) { %>
        <a href="Userlogin.jsp">
            <img src="images/评论区.png" alt="" class="smallLogo">
            评论
        </a>
        <a href="Userlogin.jsp">
            <img src="images/个人中心.png" alt="" class="smallLogo">
            个人中心
        </a>
        <% }else{ %>
        <a href="suars?uid=<%=loggedUser.getUid()%>">
            <img src="images/评论区.png" alt="" class="smallLogo">
            评论
        </a>
        <a href="UserManager.jsp">
            <img src="images/个人中心.png" alt="" class="smallLogo">
            <%=loggedUser.getUname()%>个人中心
        </a>
        <% } %>
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
    <div class="header">
        <h1><b><center>${loggedUser.uname}的收藏列表</center> </b></h1>
        <button id="clearAllBtn" class="btn btn-danger">清空收藏夹</button>
    </div>
    <% if(collectionList.size() == 0){ %>
    <h1 style="color: #46b8da"><b>您还没有收藏哦！快去收藏书籍吧</b>！</h1>
    <% }else{ %>
        <% Book_infoDaoImpl bookInfoDao = new Book_infoDaoImpl(); %>
        <%for(Collection collection:collectionList){ %>
            <div class="comment-section content" id="part-<%=collection.getBid()%>">
                <% Book_info book = bookInfoDao.findBookById(collection.getBid()); %>
                <div class="book-img">
                    <img src="<%=book.getBImgpath()%>" alt="<%=book.getBName()%>"/>
                </div>
                <div class="card" id="row-<%=collection.getBid()%>">
                    <div class="card-body">
                        <a href="SearchOneBookInfoServlet?bid=<%=collection.getBid()%>">
                        <h5 class="card-title">书名：<%=collection.getBook_name()%></h5>
                        <p class="product-info"><b>评分：</b> <%=book.getRateNumber()%></p>
                        <p class="product-info"><b>作者：</b><%=book.getAuthor()%></p>
                        <p class="product-info"><b>图书详情：</b><%=book.getBInfo()%></p>
                        <p class="product-info"><b>加入收藏时间：<%=collection.getBook_time()%> </b></p>
                        </a>
                        <div style="justify-content: space-between;">
                            <p class="product-info"><b>类型：<%=collection.getBook_type()%></b></p>
                            <button class="btn btn-danger btn-sm remove-btn" data-bid="<%=collection.getBid()%>">移除</button>
                        </div>
                    </div>
                </div>
            </div>

        <% } %>
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
                    if (response > 0) {
                        $("#part-" + bid).remove();
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
    <div class="footer">
        <p>&copy; 2024 网上书店. 保留所有权利.</p>
        <p>开发人员：董守昱，刘依洋，袁淇浩</p>
    </div>
</body>
</html>
