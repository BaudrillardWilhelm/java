<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.qdu.dao.impl.UserDaoImpl" %>
<%@ page import="com.qdu.model.Users" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    UserDaoImpl userDaoImpl = new UserDaoImpl();
    request.setAttribute("userDaoImpl", userDaoImpl);
    Users loggedUser = (Users) session.getAttribute("LoggedUser");
    request.setAttribute("loggedUser", loggedUser);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Collection List</title>
</head>
<body>
<h1>${loggedUser.uname}的收藏列表</h1>
<table border="1">
    <thead>
    <tr>
        <th>书名</th>
        <th>收藏日期</th>
        <th>类型</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="collection" items="${collection_List}">
        <tr>
            <td>${collection.book_name}</td>
            <td>${collection.book_time}</td>
            <td>${collection.book_type}</td>
            <td>
                <form action="collection" method="post">
                    <input type="hidden" name="action" value="remove">
                    <input type="hidden" name="uid" value="${collection.uid}">
                    <input type="hidden" name="bid" value="${collection.bid}">
                    <button type="submit">移除</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<form id="clearAllForm" action="collection" method="post" onsubmit="return confirmSubmit()">
    <input type="hidden" name="action" value="clearAll">
    <input type="hidden" id="uidInput" name="uid" value="${collection_List[0].uid}">
    <!-- Assuming uid is the same for all collections -->
    <button type="submit">清空收藏夹</button>
</form>

<script>
    function confirmSubmit() {
        // 显示一个带有确认和取消按钮的对话框
        return confirm("你确定要清空所有内容吗？");
    }
</script>
    </body>
</html>
