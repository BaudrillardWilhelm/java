<%@ page import="com.qdu.model.Users" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发表新评论</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#btn_publish").click(function () {
                $.ajax({
                    url: 'anrs',
                    type: 'POST',
                    data: {
                        uid: ${uid},
                        bid: ${bid},
                        star: $("#star").val(),
                        content: $("#content").val()
                    },
                    success: function () {
                        alert("发表成功！");

                    },
                    error: function () {
                        alert("发表失败！");
                    }
                });
            });
        });
    </script>
</head>
<body>
<div class="container">
    <h1 class="text-center text-primary">发表新评论</h1>
    <hr>
    <div class="text-right">
        <button id="btn_publish" type="button" class="btn btn-sm btn-success">发表</button>
    </div>

    <span id="titleDisplay">${loggedUser.getUname()}</span>
    <input type="hidden" id="uid" value="${uid}">
    <input type="hidden" id="bid" value="${bid}">
    <div class="form-group">
        <label for="star">评价分数（1~10分):</label>
        <input type="number" id="star" min="1" max="10" value="1" class="form-control">
    </div>
    <div class="form-group">
        <label for="content">评论内容：</label>
        <textarea id="content" class="form-control" rows="5"></textarea>
    </div>
</div>
</body>
</html>
