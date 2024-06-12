<%@ page import="com.qdu.model.Users" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<% HttpSession session = request.getSession(false); %>
<!--<!DOCTYPE html>-->
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>发表新日志</title>
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/style.css"/>
        <script src="js/jquery-3.4.1.min.js"></script>
<%--        <script src="https://cdn.jsdelivr.net/npm/wangeditor@latest/dist/wangEditor.min.js"></script>--%>
        <script src="js/wangEditor.min.js"></script>
        <script>
            $(document).ready(function () {

                const E = window.wangEditor;
                const editor = new E('#div1');
                // 设置编辑区域高度
                editor.config.height = 100;

                // 配置 server 接口地址
                // 如果希望能够上传本地图片，需要配置uploadImgServer
                // 指定处理上传文件的请求的组件的url
                // 这里的uploadServlet是后台处理文件上传请求的一个servlet的url
                editor.config.uploadImgServer = 'uploadServlet';

                editor.create();

                $("#btn_publish").click(function () {
                    $.ajax({
                        url: 'anrs',
                        type: 'POST',
                        data: {uid: $("#uid").val(), bid: $("bid"), star: $("#star").val(), content: editor.txt.html()},
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

            <!-- 显示用户名的span元素 -->
            <% Users user = (Users) session.getAttribute("LoggedUser"); %>


            <span id="titleDisplay">${user.uname}</span>

            <!-- 可选的隐藏输入框，用于编辑模式（如果需要） -->
            <input type="text" id="uid" placeholder="${user.uid}" class="form-control" style="display: none;">
            <br>
            <input type="text" id="bid" placeholder=${"bid"} class="form-control" style="display: none;">
            <br>评价星级：<input type="number" min="1" max="5"  name="star" value="10" class="form-control">
            评论内容：<br><br>
            <!--Alt+Shift+F 格式化-->
            <p>说亿点好听的......</p>
            <p>不笑天灾，不笑人祸，不笑贫穷</p>
            <div id="div1"></div>
            <hr>
        </div>

    </body>
</html>

