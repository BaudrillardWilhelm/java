<%@ page import="java.util.List" %>
<%@ page import="com.qdu.model.Book_info" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Book_info> bookList = (List<Book_info>) request.getAttribute("bookList");
%>

<!DOCTYPE html>
<html>
<head>
    <title>搜索结果</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
<div class="container">
    <h3>搜索结果</h3>
    <ul class="proList">
        <c:forEach var="book" items="${bookList}">
            <li>
                <a href="SearchOneBookInfoServlet?bid=${book.bid}" class="img-rounded img-thumbnail">
                    <img src="images/${book.image}" alt="${book.title}"/><hr>
                        ${book.title} - ${book.rate_number}
                </a>
            </li>
        </c:forEach>
    </ul>
</div>
</body>
</html>
