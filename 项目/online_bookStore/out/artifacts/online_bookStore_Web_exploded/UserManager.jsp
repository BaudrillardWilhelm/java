<%--
  Created by IntelliJ IDEA.
  User: pc2099
  Date: 2024/6/6
  Time: 8:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<html>
<head>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/manager.css">
    <script src="js/jquery-3.6.0.min.js" type="text/javascript"></script>
    <title>Title</title>
</head>
<body>
<button id="UserManagerShowButton" name="UserManagerShowButton"></button>
<form id="UserManagerShow" name="UserManagerShow" style="display: none">
    <label for="UserUname"></label>
<input type="text" id="UserUname" readonly>
    <label for="UserUpassword"></label>
    <input type="text" id="UserUpassword" readonly><br>
    <label for="UserUquestion"></label>
    <input type="text" id="UserUquestion" readonly><br>
    <label for="UserUanswer"></label>
    <input type="text" id="UserUanswer" readonly><br>
    <label for="UserTrue_name"></label>
    <input type="text"  id="UserTrue_name" readonly><br>
    <label for="UserGender"></label>
    <input type="text" id="UserGender" readonly><br>
    <label for="UserTel"></label>
    <input type="text" id="UserTel" readonly><br>
    <label for="UserE_mail"></label>
    <input type="text" id="UserE_mail" readonly><br>
    <label for="UserCareer"></label>
    <input type="text" id="UserCareer" readonly><br>
    <label for="UserInterest"></label>
    <input type="text" id="UserInterest" readonly><br>
    <label for="UserAddress"></label>
    <input type="text" id="UserAddress" readonly><br>
    <label for="UserMoney"></label>
    <input type="text" id="UserMoney" readonly><br>
    <label for="UserRegistration_time"></label>
    <input type="text" id="UserRegistration_time" readonly><br>
    
</form>
<button id="UserRechargeButton" name="UserRechargeButton"></button>
<form id="UserRecharge" name="UserRecharge" style="display: none"></form>
</body>
</html>
