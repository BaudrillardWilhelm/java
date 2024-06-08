<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
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
    <label for="userName">用户名</label><br>
    <input   type="text" id="userName" name="userName" required><br>
    <label for="userPassword">用户密码</label><br>
    <input   type="text" id="userPassword" name="userPassword" required><br>
    <label for="userPasswordSure">再次输入密码</label><br>
    <input   type="text" id="userPasswordSure" name="userPasswordSure" required><br>
    <label for="userQuestion">密保问题</label><br>
    <input   type="text" id="userQuestion" name="userQuestion" required><br>
    <label for="userAnswer">密保答案</label><br>
    <input   type="text" id="userAnswer" name="userAnswer" required><br>
    <label for="userTrue_Name">真实姓名</label><br>
    <input   type="text" id="userTrue_Name"name="userTrue_Name"required><br>
    <label for="userGender">性别</label><br>
    <input   type="text" id="userGender"name="userGender"required><br>
    <label for="userTel">手机号</label><br>
    <input   type="text" id="userTel" name="userTel"required><br>
    <label for="userE_Mail">电子邮件</label><br>
    <input   type="text" id="userE_Mail"name="userE_Mail" required><br>
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
    <br>
    <label for="userInterestPoetry">诗歌</label>
    <input type="checkbox" id="userInterestPoetry" name="Interest" value="诗歌">
    <label for="userInterestNovel">小说</label>
    <input type="checkbox" id="userInterestNovel" name="Interest" value="小说">
    <label for="userInterestBiography">传记</label>
    <input type="checkbox" id="userInterestBiography" name="Interest" value="传记">
    <br>
    <label for="userInterestReligion">宗教</label>
    <input type="checkbox" id="userInterestReligion" name="Interest" value="宗教">
    <br>
    <label>职业</label><br>
    <input  type="text"  id="userCareer" name="userCareer"required><br>
    <label>收件地址</label><br>
    <input  type="text" id="userAddress" name="userAddress"required><br>
    <input type="button" value="注册" name="RegisterButton" id="RegisterButton">
</form>
</body>
</html>
