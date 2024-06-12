<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.qdu.dao.impl.UserDaoImpl" %>
<%@ page import="com.qdu.model.Users" %>
<%@ page import="com.qdu.model.Collection" %>
<%@ page import="com.qdu.dao.impl.CollectionDaoImpl" %>
<%@ page import="java.util.List" %>
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
    <title>Collection List</title>
    <script src="js/jquery-3.4.1.min.js"></script>
</head>
<body>
<h1><%=loggedUser.getUname()%>的收藏列表</h1>
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
    <%for(Collection collection : collectionList){ %>
    <tr id="row-<%=collection.getBid()%>">
        <td><a href="SearchOneBookInfoServlet?bid=<%=collection.getBid()%>"><%=collection.getBook_name()%></a></td>
        <td><%=collection.getBook_time()%></td>
        <td><%=collection.getBook_type()%></td>
        <td>
            <button class="remove-btn" data-bid="<%=collection.getBid()%>">移除</button>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>

<button id="clearAllBtn">清空收藏夹</button>

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
                            $("tbody").empty();
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
