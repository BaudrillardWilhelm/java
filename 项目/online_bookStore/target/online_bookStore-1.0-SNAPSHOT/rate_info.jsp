<%@ page import="com.qdu.dao.impl.UserDaoImpl" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    UserDaoImpl userDaoImpl = new UserDaoImpl();
    request.setAttribute("userDaoImpl", userDaoImpl);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>评论信息</title>
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/style.css"/>
        <script src="js/jquery-3.4.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/script.js" charset="UTF-8"></script>
    </head>
    <body>

        <div class="container">

            <br>
            <h1 class="text-center text-success">评论信息</h1>
            <hr>

<%--        走这里之前，先走SearchOneRateServlet，提供给这个页面一个rate对象--%>
            <div class="padding10">
                <c:set var="uid" value="${rate.getUid()}"></c:set>
                <c:set var="user" value="${userDaoImpl.findUserById(uid)}"/>
                <b>发表人：</b>${user.getUname()}
                <br><br><b>评论编号：</b>${rate.getUidRateId()}
                <br><br><b>星级：</b>${rate.getstar()}
                <br><br><b>评论内容：</b>
                <br><br>
                <div class="content">    
                    ${rate.info}
                </div>
            </div>

        </div>
    </body>
</html>
