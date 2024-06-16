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
<div  id="ChooseAllDiv">
    <table id="ChooseAll"  class="table table-bordered">
        <tr>
            <td><button id="UserManagerShowButton" name="UserManagerShowButton">用户信息</button></td>
        </tr>
        <tr>
            <td><button id="UserRechargeButton" name="UserRechargeButton">充值</button></td>
        </tr>
    </table>
</div>



<div id="UserManagerShow" name="UserManagerShow" style="display: none;float: left">
    <label for="UserUid"style="white-space: pre;">用户id   </label>
    <input type="text" id="UserUid"  readonly>
    <br>
    <br>
    <label for="UserUname"style="white-space: pre;">用户名   </label>
    <input type="text" id="UserUname" readonly>
    <br>
    <br>
    <label for="UserUpassword"style="float: left;white-space: pre;">密码       </label>
    <input type="text" id="UserUpassword" name="UserUpassword" style="float: left" readonly>
    <button id="ChangePassword" name="ChangePassword" style="float: left">修改</button>
    <input type="text" id="UserUpasswordAgain" name="UserUpasswordAgain" style="display:none;float: left"  placeholder="请再次输入旧密码">
    <button id="ChangePasswordSure"name="ChangePasswordSure" style="display:none;float: left">确定</button>
    <br>
    <br>
    <label for="UserUquestion"style="float: left;white-space: pre;">密保问题</label>
    <input type="text" id="UserUquestion"name="UserUquestion" style="float: left"readonly>
    <button id="ChangeUquestion" name="ChangeUquestion"style="float: left">修改</button>
    <input type="text" id="ChangeUquestionGoal" name="ChangeUquestionGoal" style="display: none;float: left" placeholder="请输入要修改为的密保问题">
    <button id="ChangeUquestionSure"name="ChangeUquestionSure" style="display:none;float: left">确定</button>
    <br>
    <br>
    <label for="UserUanswer"style="float: left;white-space: pre;">密保答案</label>
    <input type="text" id="UserUanswer"style="float: left" readonly>
    <button id="ChangeUanswer" name="ChangeUanswer"style="float: left">修改</button>
    <input type="text" id="ChangeUanswerGoal" name="ChangeUanswerGoal" style="display: none;float: left" placeholder="请输入要修改为的密保答案">
    <button id="ChangeUanswerSure"name="ChangeUanswerSure" style="display:none;float: left">确定</button>
    <br>
    <br>
    <label for="UserTrue_name"style="float: left;white-space: pre;">真实姓名</label>
    <input type="text"  id="UserTrue_name"style="float: left" readonly>
    <button id="ChangeTrue_name" name="ChangeTrue_name"style="float: left">修改</button>
    <input type="text" id="ChangeTrue_nameGoal" name="ChangeTrue_nameGoal" style="display: none;float: left" placeholder="请输入要修改为的真实姓名">
    <button id="ChangeTrue_nameSure"name="ChangeTrue_nameSure" style="display:none;float: left">确定</button>
    <br>
    <br>
    <label for="UserGender"style="float: left;white-space: pre;">性别       </label>
    <input type="text" id="UserGender" style="float: left"readonly><br>
    <br>
    <br>
    <label for="UserTel"style="float: left;white-space: pre;">手机号    </label>
    <input type="text" id="UserTel"style="float: left" readonly>
    <button id="ChangeTel" name="ChangeTel"style="float: left">修改</button>
    <input type="text" id="ChangeTelGoal" name="ChangeTelGoal" style="display: none;float: left" placeholder="请输入要修改为的手机号">
    <button id="ChangeTelSure"name="ChangeTelSure" style="display:none;float: left">确定</button>
    <br>
    <br>
    <label for="UserE_mail"style="float: left;white-space: pre;">电子邮箱</label>
    <input type="text" id="UserE_mail" style="float: left"readonly>
    <button id="ChangeE_mail" name="ChangeE_mail"style="float: left">修改</button>
    <input type="text" id="ChangeE_mailGoal" name="ChangeE_mailGoal" style="display: none;float: left" placeholder="请输入要修改为的电子邮箱">
    <button id="ChangeE_mailSure"name="ChangeE_mailSure" style="display:none;float: left">确定</button>
    <br>
    <br>
    <label for="UserCareer"style="float: left;white-space: pre;">职业       </label>
    <input type="text" id="UserCareer"style="float: left" readonly>
    <button id="ChangeCareer" name="ChangeCareer"style="float: left">修改</button>
    <input type="text" id="ChangeCareerGoal" name="ChangeCareerGoal" style="display: none;float: left" placeholder="请输入要修改为的职业">
    <button id="ChangeCareerSure"name="ChangeCareerSure" style="display:none;float: left">确定</button>
    <br>
    <br>
    <label>感兴趣的书籍类型</label>
    <br>
    <form id="userInterestForm" name="userInterestForm">

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
        <button type="button" id="ChangeInterest" name="ChangeInterest">修改</button><br>
    </form>
        <label for="UserAddress"style="float: left">收货地址</label>
        <input type="text" id="UserAddress" name="UserAddress"style="float: left" readonly>
        <button id="ChangeAddress" name="ChangeAddress"style="float: left">修改</button>
        <input type="text" id="ChangeAddressGoal" name="ChangeAddressGoal" style="display: none;float: left" placeholder="请输入要修改为的收货地址">
        <button id="ChangeAddressSure"name="ChangeAddressSure" style="display:none;float: left">确定</button>

    <br>
    <br>
    <label for="UserMoney"style="float: left;white-space: pre;">账户余额</label>
    <input type="text" id="UserMoney" name="UserMoney" style="float: left" readonly>
    <br>
    <br>
    <label for="UserRegistration_time"style="float: left;white-space: pre;">注册时间</label>
    <input type="text" id="UserRegistration_time"style="float: left" readonly>

</div>
<div id="UserRecharge" name="UserRecharge" style="display: none;white-space: pre;">
    <div id="UserRechargeImage" name="UserRechargeImage">
        <img src="images/Rechage.png" alt="Description of image" style="width: 400px;height: 500px">
    </div>
    <div>
        <input type="number" id="RechargeGet" name="RechargeGet" placeholder="请输入充值金额">
        <button id="RechargeSure" name="RechargeSure">确认付款</button>
    </div>
</div>
</body>
</html>
