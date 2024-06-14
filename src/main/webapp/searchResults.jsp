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
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .proList {
            line-height: 30px;
            margin: 10px auto;
             text-align: left;
        }

        .content {
            display: flex;
            align-items: flex-start;
            margin: 20px;
            background-color: #fff;
            border-radius: 20px;
            box-shadow: 0 0 90px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            padding-left: 100px;
            width: 1200px;
        }

        .book-img {
            flex: 0 0 auto;
            margin: 20px;
        }

        .book-img img {
            width: 200px;
            height: 250px;
            object-fit: cover;
            border-radius: 20px;
            padding-left: 10px;
        }

        .book-info {
            flex: 1;
            padding: 20px;
        }

        .product-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .product-info {
            font-size: 16px;
            color: #555;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h3>搜索结果</h3>
        <c:forEach var="book" items="${bookList}">
            <a href="SearchOneBookInfoServlet?bid=${book.getBid()}">
            <div class="content">
                <div class="book-img">
                    <img src="${book.getBImgpath()}" alt="${book.getBName()}"/>
                </div>
                <div class="book-info">
                    <p class="product-title">${book.getBName()}</p>
                    <p class="product-info"><b>评分：</b> ${book.getRateNumber()}</p>
                    <p class="product-info"><b>作者：</b> ${book.getAuthor()}</p>
                    <p class="product-info"><b>图书详情：</b> ${book.getBInfo()}</p>
                    <p class="product-info"><b>剩余库存：</b> ${book.getBNum()}本</p>
                </div>
            </div>
            </a>
        </c:forEach>

    <!-- Pagination -->
    <nav aria-label="评论分页">
        <ul class="pagination justify-content-center mt-4">
            <c:if test="${currentPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="?keyword=${keyword}&searchType=${searchType}&page=${currentPage - 1}" aria-label="上一页">
                        <span aria-hidden="true">&laquo;</span>
                        <span class="sr-only">上一页</span>
                    </a>
                </li>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                    <a class="page-link" href="?keyword=${keyword}&searchType=${searchType}&page=${pageNumber}">${pageNumber}</a>
                </li>

            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <li class="page-item">
                    <a class="page-link" href="?keyword=${keyword}&searchType=${searchType}&page=${currentPage + 1}" aria-label="下一页">
                        <span aria-hidden="true">&raquo;</span>
                        <span class="sr-only">下一页</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>
</body>
</html>
