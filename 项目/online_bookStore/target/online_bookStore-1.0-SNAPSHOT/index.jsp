<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <head>
        <title>网上书店首页</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="images/shortcut.png" rel="shortcut icon" type="image/x-icon"/>
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/style.css"/>
    </head>
    <body> 
        
        <div class="container">

            <div class="top">
                <div class="top_left"><img src="images/tmall.png" alt="网上书店logo"></div>
                <div class="top_right"><h1>欢迎来到网上书店，购尽好书......</h1></div>
            </div>

            <hr>

            <hr>
            <h3>为您推荐</h3>

            <ul class="proList">
                <!--这里针对超链接使用URL重写追加要查询的产品的产品编号-->
                <c:forEach begin="1" end="6">
                    <li>
                        <a href="ps?pid=P001" class="img-rounded img-thumbnail">
                            <img src="images/P001.jpg" alt="卫龙辣条"/><hr>
                            卫龙辣条，你值得拥有
                        </a>
                    </li>
                </c:forEach>

            </ul>

            <br>
            <a href="ManageCart.jsp" class="cartImg">
                查看购物车<img src="images/cart.png" alt="购物车"/>
            </a>
            <a href="los" class="logout">
                退出登录
            </a>
            <br>
            <br>
        </div>
    </body>
</html>
