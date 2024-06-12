<%@ page import="com.qdu.dao.impl.UserDaoImpl" %>
<%@ page import="com.qdu.model.Users" %>
<%@ page import="com.qdu.model.Book_info" %>
<%@ page session="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    UserDaoImpl userDaoImpl = new UserDaoImpl();
    request.setAttribute("userDaoImpl", userDaoImpl);
    HttpSession session = request.getSession(false);

    Users loggedUser = (Users) session.getAttribute("LoggedUser");
    request.setAttribute("loggedUser", loggedUser);
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <c:choose>
        <c:when test="${not empty book}">
            <title>${book.getBName()}的评论列表</title>
        </c:when>
        <c:otherwise>
            <title>？？？的评论列表</title>
        </c:otherwise>
    </c:choose>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js" charset="UTF-8"></script>
</head>
<body>

<div class="container mt-5">
    <c:if test="${empty rateList}">
        <div class="alert alert-warning text-center" role="alert">
            本书暂无评论，快来发表你的感受吧！
        </div>
    </c:if>
    <c:if test="${not empty rateList}">
        <h1 class="text-center text-success">评论列表</h1>
        <table id="dataTable" class="table table-striped table-hover text-center mt-4">
            <thead class="thead-dark">
            <tr>
                <th scope="col">评论编号</th>
                <th scope="col">发布人</th>
                <th scope="col">评价星级</th>
                <th scope="col">内容</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${rateList}" var="rate">
                <c:set var="uid" value="${rate.getUid()}"/>
                <tr id="tr${rate.getUidRateId()}">
                    <td>${rate.getUidRateId()}</td>
                    <td>${user.getUname()}</td>
                    <td>${rate.getStar()}</td>
                    <td>
                            ${rate.getInfo()}
                        <c:if test="${loggedUser != null && loggedUser.getUid() == rate.getUid()}">
                            <button class="btn btn-danger btn-sm delete-btn" data-uid="${rate.getUid()}" data-bid="${rate.getBid()}" data-uidrateid="${rate.getUidRateId()}">删除</button>
                        </c:if>
                        <c:if test="${loggedUser != null && loggedUser.getUid() == rate.getUid()}">
                            <button class="btn btn-warning btn-sm edit-btn" data-uid="${rate.getUid()}" data-bid="${rate.getBid()}" data-uidrateid="${rate.getUidRateId()}" data-star="${rate.getStar()}" data-content="${rate.getInfo()}">修改</button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <button type="button" class="btn btn-primary mt-4" data-toggle="modal" data-target="#addRateModal">发表评论</button>
</div>

<!-- Add Rate Modal -->
<div class="modal fade" id="addRateModal" tabindex="-1" role="dialog" aria-labelledby="addRateModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addRateModalLabel">发表新评论</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addRateForm">
                    <input type="hidden" id="uid" name="uid" value="${loggedUser.getUid()}">
                    <input type="hidden" id="bid" name="bid" value="${book.getBid()}">
                    <div class="form-group">
                        <label for="star">评价星级</label>
                        <input type="number" class="form-control" id="star" name="star" min="1" max="10" required>
                    </div>
                    <div class="form-group">
                        <label for="content">评论内容</label>
                        <textarea class="form-control" id="content" name="content" required>说亿点好听的.....</textarea>
                    </div>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary" data-hidden="modal">发表</button>
                </form>
            </div>
        </div>
    </div>
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
                    <textarea class="form-control" id="editContent" name="content" required></textarea>
                </div>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="submit" class="btn btn-primary">确认修改</button>
            </form>
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
                        alert("评论删除成功");
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
                        alert("修改成功");
                        $("#editRateModal").modal("hide");
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
                        $("#addRateModal").modal("hide");
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
</body>
</html>
