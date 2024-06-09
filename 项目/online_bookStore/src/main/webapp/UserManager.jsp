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
    <script src="js/UserManager.js" type="text/javascript"></script>
    <title>Title</title>
</head>
<body>
<button id="UserManagerShowButton" name="UserManagerShowButton">用户信息</button><br>
<button id="UserRechargeButton" name="UserRechargeButton">充值</button><br>

<div id="UserManagerShow" name="UserManagerShow" style="display: none">
    <label for="UserUid">用户id</label>
    <input type="text" id="UserUid"  readonly>

    <label for="UserUname">用户名</label>
    <input type="text" id="UserUname" readonly>

    <label for="UserUpassword">密码</label>
    <input type="text" id="UserUpassword" readonly>
    <button id="ChangePassword" name="ChangePassword">修改</button>
    <input type="text" id="UserUpasswordAgain" style="display:none;" placeholder="请再次输入旧密码">
    <br>

    <label for="UserUquestion">密保问题</label>
    <input type="text" id="UserUquestion" readonly>
    <button id="ChangeUquestion" name="ChangeUquestion">修改</button><br>

    <label for="UserUanswer">密保答案</label>
    <input type="text" id="UserUanswer" readonly>
    <button id="ChangeUanswer" name="ChangeUanswer">修改</button><br>

    <label for="UserTrue_name">真实姓名</label>
    <input type="text"  id="UserTrue_name" readonly>
    <button id="ChangeTrue_name" name="ChangeTrue_name">修改</button><br>

    <label for="UserGender">性别</label>
    <input type="text" id="UserGender" readonly><br>

    <label for="UserTel">手机号</label>
    <input type="text" id="UserTel" readonly>
    <button id="ChangeTel" name="ChangeTel">修改</button><br>

    <label for="UserE_mail">电子邮箱</label>
    <input type="text" id="UserE_mail" readonly>
    <button id="ChangeE_mail" name="ChangeE_mail">修改</button><br>

    <label for="UserCareer">职业</label>
    <input type="text" id="UserCareer" readonly>
    <button id="ChangeCareer" name="ChangeCareer">修改</button><br>

    <label>感兴趣的书籍类型</label>
    <br>
    <label for="userInterestLiterature">文学</label>
    <input type="checkbox" id="userInterestLiterature" name="Interest" value="文学">
    <label for="userInterestScienceFiction">科幻</label>
    <input type="checkbox" id="userInterestScienceFiction" name="Interest" value="科幻">
    <label for="userInterestHistory">历史</label>
    <input type="checkbox" id="userInterestHistory" name="Interest" value="历史">
    <br>
    <label for="userInterestDrama">戏剧</label>
    <input type="checkbox" id="userInterestDrama" name="Interest" value="戏剧">
    <label for="userInterestAdventure">冒险</label>
    <input type="checkbox" id="userInterestAdventure" name="Interest" value="冒险">
    <label for="userInterestClassical">经典</label>
    <input type="checkbox" id="userInterestClassical" name="Interest" value="经典">
    <br>
    <label for="userInterestLove">爱情</label>
    <input type="checkbox" id="userInterestLove" name="Interest" value="爱情">
    <label for="userInterestFantasy">幻想</label>
    <input type="checkbox" id="userInterestFantasy" name="Interest" value="幻想">
    <label for="userInterestSociety">社会</label>
    <input type="checkbox" id="userInterestSociety" name="Interest" value="社会">
    <button id="ChangeInterest" name="ChangeInterest">修改</button><br>

    <label for="UserAddress">收货地址</label>
    <input type="text" id="UserAddress" readonly>
    <button id="ChangeAddress" name="ChangeAddress">修改</button><br>

    <label for="UserMoney">账户余额</label>
    <input type="text" id="UserMoney" readonly>
    <button id="ChangeMoney" name="ChangeMoney">修改</button><br>

    <label for="UserRegistration_time">注册时间</label>
    <input type="text" id="UserRegistration_time" readonly>
    <button id="ChangeRegistration_time" name="ChangeRegistration_time">修改</button><br>

</div>
<form id="UserRecharge" name="UserRecharge" style="display: none"></form>
</body>
</html>
