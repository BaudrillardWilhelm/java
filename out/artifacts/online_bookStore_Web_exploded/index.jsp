<%@ page import="com.qdu.model.Users" %>
<%@ page import="com.qdu.dao.impl.UserDaoImpl" %>
<%@ page import="com.qdu.model.Interest" %>
<%@ page import="java.util.List" %>
<%@ page import="com.qdu.dao.impl.InterestDaoImpl" %>
<%@ page import="com.qdu.dao.impl.Book_infoDaoImpl" %>
<%@ page import="com.qdu.model.Book_info" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    UserDaoImpl userDaoImpl = new UserDaoImpl();
    Book_infoDaoImpl bookInfoDao = new Book_infoDaoImpl();
    InterestDaoImpl interestDao = new InterestDaoImpl();

    List<Book_info> bookList = new ArrayList<>();
    Users loggedUser = null;

    if (null == session.getAttribute("LoggedUser")) {
        bookList = bookInfoDao.findTopRatedBooks();
    } else {
        loggedUser = (Users) session.getAttribute("LoggedUser");
        int uid = loggedUser.getUid();
        bookList = bookInfoDao.findRecommendedBookByUid(uid);
    }

    if (bookList.size() < 10) {
        List<Book_info> topRatedBooks = bookInfoDao.findTopRatedBooks();
        for (Book_info book : topRatedBooks) {
            if (bookList.size() >= 10) break;
            if (!bookList.contains(book)) {
                bookList.add(book);
            }
        }
    } else if (bookList.size() > 10) {
        bookList = bookList.subList(0, 10);
    }

    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html>
<head>
    <title>网上书店首页</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="images/shortcut.png" rel="shortcut icon" type="image/x-icon"/>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>

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
        .webSitelogo{
            height: 80px; /* 等比放大 logo */
            margin-right: 10px;
        }
        .navbar h1 {
            font-size: 1.5em;
            margin: 0;
            color: #343a40; /* 美化标题颜色 */
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

        .proList {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .proList a {
            display: block;
            width: 200px;
            text-align: center;
            text-decoration: none;
            color: black;
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .proList a:hover {
            transform: translateY(-10px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .proList img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .proList hr {
            margin: 10px 0;
        }
        .proList .book-info {
            padding: 10px;
        }
        .smallLogo{
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
            /* 添加你想要的样式，例如更换背景色、边框样式等 */
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
</head>
<body>
<div class="navbar">
    <div class="logo-title">
        <img src="images/logo.png" alt="网上书店logo" style="            height: 80px; /* 等比放大 logo */
            margin-right: 10px;">
        <h1>欢迎来到网上书店，购尽好书！</h1>
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
    <ul class="proList">
        <% for (Book_info book : bookList) { %>
        <a href="SearchOneBookInfoServlet?bid=<%= book.getBid() %>" class="img-rounded img-thumbnail">
            <img src="<%= book.getBImgpath() %>" alt="<%= book.getBName() %>"/>
            <div class="book-info">
                <hr><%= book.getBName() %> - <%= book.getRateNumber() %>
            </div>
        </a>
        <% } %>
    </ul>
    <br>

    <c:if test="${not empty errorMessage}">
        <div style="color: red;">${errorMessage}</div>
    </c:if>

    <script>
        <% if (errorMessage != null) { %>
        alert("<%= errorMessage %>");
        <% } %>
    </script>
</div>

<div class="footer">
    <p>&copy; 2024 网上书店. 保留所有权利.</p>
    <p>开发人员：董守昱，刘依洋，袁淇浩</p>
</div>
</body>
</html>
