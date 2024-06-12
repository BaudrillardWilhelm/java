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

    Users loggedUser=null;

    if(null==session.getAttribute("LoggedUser")){
        bookList = bookInfoDao.findTopRatedBooks();
    }else{
        loggedUser=(Users)session.getAttribute("LoggedUser");
        int uid = loggedUser.getUid();
        bookList = bookInfoDao.findRecommendedBookByUid(uid);
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
        .proList {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .proList a {
            display: block;
            width: calc(25% - 10px);
            margin: 5px;
            text-align: center;
            text-decoration: none;
            color: black;
        }
        .proList img {
            width: 50%;
            height: 100%;
            max-height: 200px;
            object-fit: cover;
        }
        .proList a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="top">
        <div class="top_left"><img src="images/tmall.png" alt="网上书店logo"></div>
        <div class="top_right"><h1>欢迎来到网上书店，购尽好书......</h1></div>
    </div>
    <hr>
    <h3>为您推荐</h3>
    <ul class="proList">
        <% for(Book_info book : bookList) { %>
        <a href="SearchOneBookInfoServlet?bid=<%=book.getBid()%>" class="img-rounded img-thumbnail">
            <img src="<%=book.getBImgpath()%>" alt="<%=book.getBName()%>"/><hr><%=book.getBName()%> - <%=book.getRateNumber()%>
        </a>
        <% } %>
    </ul>
    <br>
    <a href="ManageCart.jsp" class="cartImg">
        查看购物车<img src="images/cart.png" alt="购物车"/>
    </a>
    <a href="LogoutServlet" class="logout">
        退出登录
    </a>
    <a href="Collection.jsp">我的收藏</a>
    <a href="ManageOrders.jsp">我的订单</a>
    <br><br>
    <c:if test="${LoggedUser==null}">
        <a href="Userlogin.jsp">我的评论</a>
    </c:if>
    <c:if test="${LoggedUser!=null}">
        <a href="suars?uid=${LoggedUser.uid}">我的评论</a>
    </c:if>
    <c:if test="${LoggedUser == null}">
        <a href="Userlogin.jsp.jsp">个人中心</a>
    </c:if>
    <c:if test="${LoggedUser != null}">
        <a href="UserManager.jsp">个人中心</a>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div style="color: red;">${errorMessage}</div>
    </c:if>

    <form action="SearchBooksServlet" method="get">
        <select name="searchType">
            <option value="name">按书名搜索</option>
            <option value="author">按作者搜索</option>
        </select>
        <input type="text" name="keyword" placeholder="搜索书籍...">
        <button type="submit">搜索</button>
    </form>

    <script>
        <% if (errorMessage != null) { %>
        alert("<%= errorMessage %>");
        <% } %>
    </script>

</div>
</body>
</html>
