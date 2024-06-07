<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <title>登录页面</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/register.css">
    <script src="js/jquery-3.6.0.min.js" type="text/javascript"></script>
    <script src="js/RegisterTools.js" type="text/javascript"></script>
</head>
<body>
<form action="" method="post" id="registerFrom">
    <h2>用户注册</h2>
    <label>用户名</label><br>
    <input   type="text" id="userName" name="userName" required><br>
    <label>用户密码</label><br>
    <input   type="text" id="userPassword" name="userPassword" required><br>
    <label>再次输入密码</label><br>
    <input   type="text" id="userPasswordSure" name="userPasswordSure" required><br>
    <label>密保问题</label><br>
    <input   type="text" id="userQuestion" name="userQuestion" required><br>
    <label>密保答案</label><br>
    <input   type="text" id="userAnswer" name="userAnswer" required><br>
    <label>真实姓名</label><br>
    <input   type="text" id="userTrue_Name"name="userTrue_Name"required><br>
    <label>性别</label><br>
    <input   type="text" id="userGender"name="userGender"required><br>
    <label>手机号</label><br>
    <input   type="text" id="userTel" name="userTel"required><br>
    <label>电子邮件</label><br>
    <input   type="text" id="userE_Mail"name="userE_Mail" required><br>
    <label>职业</label><br>
    <input  type="text"  id="userCareer" name="userCareer"required><br>
    <label>收件地址</label><br>
    <input  type="text" id="userAddress" name="userAddress"required><br>
    <input type="button" value="注册" name="RegisterButton" id="RegisterButton">
</form>
</body>
</html>
