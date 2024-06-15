<%@ page import="com.qdu.dao.impl.UserDaoImpl" %>
<%@ page import="com.qdu.model.Users" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${loggedUser.getUname()}的评论列表</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js" charset="UTF-8"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .comment-section {
            margin-top: 20px;
        }
        .card {
            border: 1px solid #dee2e6;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card-body {
            position: relative;
        }
        .card-title {
            font-size: 3rem;
            color: #007bff;
        }
        .card-subtitle {
            font-size: 1rem;
            color: #6c757d;
        }
        .card-text {
            font-size: 25px;
            color: #212529;
            margin-bottom: 0.5rem;
        }
        .btn-sm {
            margin-top: 0.5rem;
        }
        .container {
            margin-top: 50px;
        }
        .alert {
            margin-top: 20px;
        }
        .btn-primary {

            background-color: #007bff;
            border-color: #007bff;

        }
        .modal-content {
            border-radius: 0.5rem;
        }
        /* Custom Styles */
        .modal-body {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        #content {
            width: 300px; /* Full width */
            height: 150px; /* Increased height */
            resize: vertical; /* Allow vertical resizing */
        }
        #star {
            width: 100px; /* Adjust width as needed */
        }
        button{
            padding-left: 10px;
            padding-bottom: 10px;
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
        <c:choose>
            <c:when test="${empty loggedUser}">
                <a href="Userlogin.jsp">
                    <img src="images/评论区.png" alt="" class="smallLogo">
                    评论
                </a>
                <a href="Userlogin.jsp">
                    <img src="images/个人中心.png" alt="" class="smallLogo">
                    个人中心
                </a>
            </c:when>
            <c:otherwise>
                <a href="suars?uid=${loggedUser.getUid()}">
                    <img src="images/评论区.png" alt="" class="smallLogo">
                    评论
                </a>
                <a href="UserManager.jsp">
                    <img src="images/个人中心.png" alt="" class="smallLogo">
                    ${loggedUser.getUname()}个人中心
                </a>
            </c:otherwise>
        </c:choose>


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

<div class="container mt-5">
    <c:if test="${not empty rateList}">
        <h1 class="text-center text-success" style="font-size: 28px;">评论列表</h1>
        <table id="dataTable" class="table table-striped table-hover text-center mt-4">
            <div class="comment-section">
                <c:forEach items="${rateList}" var="rate">
                    <div class="card">
                        <div class="card-body">
                            <c:set var="rateUserName" value="${rateDaoImpl.getRateUserName(rate.getUid())}" />
                            <h5 class="card-title">发布人：${rateUserName}</h5>
                            <h6 class="card-subtitle mb-2 text-muted">评论编号：${rate.getUidRateId()}</h6>
                            <p class="card-text">评分：${rate.getStar()}</p>
                            <p class="card-text">${rate.getInfo()}</p>
                            <c:if test="${loggedUser != null && loggedUser.getUid() == rate.getUid()}">
                                <button class="btn btn-danger btn-sm delete-btn" data-uid="${rate.getUid()}" data-bid="${rate.getBid()}" data-uidrateid="${rate.getUidRateId()}">删除</button>
                                <button class="btn btn-warning btn-sm edit-btn" data-uid="${rate.getUid()}" data-bid="${rate.getBid()}" data-uidrateid="${rate.getUidRateId()}" data-star="${rate.getStar()}" data-content="${rate.getInfo()}">修改</button>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>

        </table>

        <!-- Pagination -->
        <nav aria-label="评论分页">
            <ul class="pagination justify-content-center mt-4">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="?uid=${uid}&page=${currentPage - 1}" aria-label="上一页">
                            <span aria-hidden="true">&laquo;</span>
                            <span class="sr-only">上一页</span>
                        </a>
                    </li>
                </c:if>
                <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                    <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?uid=${uid}&page=${pageNumber}">${pageNumber}</a>
                    </li>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a class="page-link" href="?uid=${uid}&page=${currentPage + 1}" aria-label="下一页">
                            <span aria-hidden="true">&raquo;</span>
                            <span class="sr-only">下一页</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
        <!-- End Pagination -->

    </c:if>
</div>

<div class="modal fade" id="editRateModal" tabindex="-1" role="dialog" aria-labelledby="editRateModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editRateModalLabel">修改评论</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editRateForm">
                    <input type="hidden" id="editUidRateId" name="uidRateId">
                    <input type="hidden" id="editUid" name="uid">
                    <input type="hidden" id="editBid" name="bid">
                    <div class="form-group">
                        <label for="editStar">星级</label>
                        <input type="number" class="form-control" id="editStar" name="star" min="1" max="10" required>
                    </div>
                    <div class="form-group">
                        <label for="editContent">评论内容</label>
                        <textarea class="form-control" id="editContent" name="content"  required></textarea>
                    </div>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">确认修改</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function(){
        $(".delete-btn").click(function(){
            var button = $(this);
            var uidRateId = button.data("uidrateid");
            var uid = button.data("uid");
            var bid = button.data("bid");

            $.ajax({
                url: "DeleteOneRateServlet_1",
                type: "GET",
                data: {
                    uidRateId: uidRateId,
                    uid: uid,
                    bid: bid
                },
                success: function(response) {
                    if (response == 1) {
                        $("#tr" + uidRateId).remove();
                        location.reload();
                        // alert("评论删除成功");
                    } else if(response == -1) {
                        alert("数据库代码有问题，删除失败，请重试！");
                    } else {
                        alert("删除失败，请重试");
                    }
                },
                error: function() {
                    alert("请求失败，请重试");
                }
            });
        });

        $(".edit-btn").click(function(){
            var button = $(this);
            var uidRateId = button.data("uidrateid");
            var uid = button.data("uid");
            var bid = button.data("bid");
            var star = button.data("star");
            var content = button.data("content");

            $("#editUidRateId").val(uidRateId);
            $("#editUid").val(uid);
            $("#editBid").val(bid);
            $("#editStar").val(star);
            $("#editContent").val(content);

            $("#editRateModal").modal("show");
        });

        $("#editRateForm").submit(function(e){
            e.preventDefault();
            $.ajax({
                url: "alterRateServlet",
                type: "POST",
                data: $(this).serialize(),
                success: function(response) {
                    if (response == 1) {
                        // alert("修改成功");
                        location.reload();
                    } else if (response == 0) {
                        alert("修改失败，请重试");
                    } else if (response == -1) {
                        alert("修改失败，数据库语句有错误");
                    }
                },
                error: function() {
                    alert("请求失败，请重试");
                }
            });
        });

        $("#addRateForm").submit(function(e){
            e.preventDefault();
            $.ajax({
                url: "anrs",
                type: "POST",
                data: $(this).serialize(),
                success: function(response) {
                    if (response == 1) {
                        alert("发表成功");
                        location.reload();
                    } else if (response == 0) {
                        alert("发表失败，请重试");
                    } else if (response == -1) {
                        alert("发表失败，数据库语句有错误");
                    }
                },
                error: function() {
                    alert("请求失败，请重试");
                }
            });
        });
    });
</script>
<div class="footer">
    <p>&copy; 2024 网上书店. 保留所有权利.</p>
    <p>开发人员：董守昱，刘依洋，袁淇浩</p>
</div>
</body>
</html>
