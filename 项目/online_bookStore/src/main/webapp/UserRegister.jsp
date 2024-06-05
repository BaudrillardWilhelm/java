<%--
  Created by IntelliJ IDEA.
  User: pc2099
  Date: 2024/5/29
  Time: 9:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/register.css">
    <script src="js/RegisterTools.js.js" type="text/javascript"></script>
</head>
<body>
<form action="" method="post" id="registerFrom">
    <h2>用户注册</h2>
    <label>用户名</label>
    <input id="userName" name="userName" required>
    <label>用户密码</label>
    <input id="userPassword" name="userPassword" required>
    <label>再次输入密码</label>
    <input id="userPasswordSure" name="userPasswordSure" required>
    <label>输入密保问题</label>
    <input id="userQuestion" name="userQuestion" required>
    <label>输入密保答案</label>
    <input id="UserAnswer" required>
    <label></label>
</form>
</body>
</html>
