<%@ page import="com.qdu.dao.impl.UserDaoImpl" %>
<%@ page import="com.qdu.model.Users" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    UserDaoImpl userDaoImpl = new UserDaoImpl();
    request.setAttribute("userDaoImpl", userDaoImpl);
    HttpSession session = request.getSession(false);
    Users loggedUser = (Users) session.getAttribute("LoggedUser");
    request.setAttribute("loggedUser", loggedUser);

%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${loggedUser.uname}的评论列表</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js" charset="UTF-8"></script>
</head>
<script>
    $(document).ready(function(){
        // 删除评论的逻辑
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

        // 修改评论的逻辑
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

        // 表单提交的逻辑
        $("#editRateForm").submit(function(e){
            e.preventDefault();
            $.ajax({
                url: "ars", // 注意这个 URL 需要与 AlterRateServlet 的 URL 相匹配
                type: "POST",
                data: $(this).serialize(),
                success: function(response) {
                    if (response == 1) {
                        alert("修改成功");
                        location.reload(); // 刷新页面以反映修改后的内容
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
    });


</script>
<body>

<div class="container">
    <br>
    <h1 class="text-center text-success">评论列表</h1>
    <br>
    <table id="dataTable" class="table table-hover text-center">
        <tr>
            <th>评论编号</th>
            <th>发布人</th>
            <th>评价星级</th>
            <th>操作</th>
        </tr>

        <c:forEach items="${rateList}" var="rate">

            <c:set var="uid" value="${rate.getUid()}"></c:set>
            <c:set var="user" value="${userDaoImpl.findUserById(uid)}"/>
            <tr id="tr${rate.getUidRateId()}">
                <td>${rate.getUidRateId()}</td>
                <td>${user.getUserName()}</td>
                <td>${rate.getStar()}</td>
                <td>
                    <button class="btn btn-danger delete-btn" data-uid="${rate.getUid()}" data-bid="${rate.getBid()}" data-uidrateid="${rate.getUidRateId()}">删除</button>
                </td>
                <td>
<%--            我希望弹出一个框，不是alert那样的，而是在本页面弹出一个悬浮的表单，上面有评论原本的信息--%>
                    <a href="sors?uidRateId=${rate.getUidRateId()}&uid=${rate.getUid()}">查看详情</a>
                </td>
<%--            修改评论，我希望弹出一个框，不是alert那样的，而是在本页面弹出一个悬浮的表单，(最下面是两个按钮，一个是取消，不作修改，
                另一个是确认修改，保存本次修改，（通过als这个servlet）)上面有评论原本的信息，用户可以在上面进行修改原本的文本内容。
                点击确认保存后，会根据反馈弹出提示，如果是1，则提示修改成功，0则是修改失败，-1则“修改失败，数据库语句有错误” --%>

                <td>
                    <button class="btn btn-warning edit-btn" data-uid="${rate.getUid()}" data-bid="${rate.getBid()}" data-uidrateid="${rate.getUidRateId()}" data-star="${rate.getStar()}" data-content="${rate.getInfo()}">修改</button>
                </td>

            </tr>
        </c:forEach>
    </table>

    <!-- 修改评论的模态框 -->
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
                            <input type="number" class="form-control" id="editStar" name="star" min="1" max="5" required>
                        </div>
                        <div class="form-group">
                            <label for="editContent">评论内容</label>
                            <textarea class="form-control" id="editContent" name="content" rows="3" required></textarea>
                        </div>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-primary">确认修改</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>


</body>
</html>
