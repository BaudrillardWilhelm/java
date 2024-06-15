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

    <style>
        .display-4 {
            font-size: 2.5rem; /* 自定义标题字体大小 */
            color: #333; /* 自定义标题颜色 */
        }
        .form-control {
            width: 300px; /* 自定义输入框宽度 */
            font-size: 1.2rem; /* 自定义输入框字体大小 */
        }
        .btn-primary {
            font-size: 1.2rem; /* 自定义按钮字体大小 */
            background-color: #007bff; /* 自定义按钮背景色 */
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3; /* 自定义按钮鼠标悬停背景色 */
            border-color: #0056b3;
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
    <div class="row align-items-center mb-4">
        <div class="col-8">
            <h1 class="display-4"><%= loggedUser.getUname() %>的订单管理</h1>
        </div>
        <div class="col-4">
            <!-- Search Bar -->
            <form id="searchForm" class="form-inline">
                <input type="text" class="form-control mr-2" id="searchKeyword" placeholder="搜索图书名">
                <button type="submit" class="btn btn-primary">搜索</button>
            </form>
        </div>
    </div>



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

<div class="footer">
    <p>&copy; 2024 网上书店. 保留所有权利.</p>
    <p>开发人员：董守昱，刘依洋，袁淇浩</p>
</div>
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
</body>
</html>
