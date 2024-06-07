<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<html>
<head>
    <title>Title</title>
    <title>登录页面</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/login.css">
    <script src="js/jquery-3.6.0.min.js" type="text/javascript"></script>
    <script src="js/loginTools.js" type="text/javascript"></script>
</head>
<body>
<form action="ls" method="post" id="Logininformation">
    <h2>用户登录</h2>
    <label for="name">名字</label><br>
    <input type="text" id="name" name="name"  placeholder="请输入用户名"required><br>
    <label for="password">密码</label><br>
    <input type="text" id="password" name="password"  placeholder="请输入密码"><br>
    <br>
    <input type="button" value="登录" name="loginButton" id="loginButton">
</form>

<button name="findPassword" id="findPassword">密码找回</button>

<form action="gq" method="post" id="findForm"  style="display: none" method="post">
    <h2>密码找回</h2><br>
    <label>手机号</label><br>
    <input type="text" name="findPhone" placeholder="请输入手机号" required><br>
    <input type="button" value="获取" name="findButton" id="findButton">
</form>
<form id="findForm2"  style="display: none" method="post">
    <h2>密码找回</h2><br>
    <label>问题</label><br>
    <input type="text" name="findQuestion" id="findQuestion" value="密保问题" readonly><br>
    <label>答案</label><br>
    <input type="text" name="findAnswer" id="findAnswer" placeholder="请输入答案" required><br>
    <br>
    <input type="button" value="找回" name="findButton2" id="findButton2">
</form>
</body>
</html>
