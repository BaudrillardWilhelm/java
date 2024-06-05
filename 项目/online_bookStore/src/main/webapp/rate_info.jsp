<%@ page import="com.qdu.model.Rate" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>评论详情</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
<div class="container">
    <br>
    <h1 class="text-center text-success">评论详情</h1>
    <br>
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">评论编号: ${rate.uidRateId}</h5>
            <p class="card-text">发布人: ${rate.uid}</p>
            <p class="card-text">评价星级: ${rate.star}</p>
            <p class="card-text">评论内容: ${rate.info}</p>
            <a href="UserRate_list_1.jsp" class="btn btn-primary">返回</a>
        </div>
    </div>
</div>
</body>
</html>
