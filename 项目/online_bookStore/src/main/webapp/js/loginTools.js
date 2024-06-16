
$(document).ready(function (){
    $("#loginButton").click(function (){upLoadAll();});
});
function upLoadAll()
{
    let formData = new FormData($("#Logininformation")[0]);//建立formdata对象
    $.ajax(
        {
            url:'ls',//目标
            type:'POST',
            contentType:false,
            processData: false,
            data:formData,//要传递的内容
            success:function (data)//接受返回值
            {
                if(data.isLogin==true)
                {

                }
                else
                {
                    alert("用户名或密码错误");
                }
            }
        }
    )
}
$(document).ready(function (){
    $("#findPassword").click(function (){findPassword();});
});
$(document).ready(function (){
    $("#findButton").click(function (){findQuestion();});
});
$(document).ready(function (){
    $("#findButton2").click(function (){findPasswordByAnswer();});
});
function findPassword()
{
    var form =  document.getElementById("findForm");
    var form2 =  document.getElementById("findForm2");
    var Question2 =  document.getElementById("findQuestion");
    form2.style.display = 'none';
    Question2.value = "密保问题";
    if(form.style.display == 'none')
    {
        form.style.display = 'block';
    }
    else
    {
        form.style.display = 'none';
    }
}
function findQuestion()
{
    let formData = new FormData($("#findForm")[0]);//建立formdata对象
    $.ajax(
        {
            url:"gq",//目标
            type:'POST',
            contentType:false,
            processData: false,
            data:formData,//要传递的内容
            success:function (data)//接受返回值
            {
                if(data.question!=="gg")
                {
                    var form =  document.getElementById("findForm");
                    var form2 =  document.getElementById("findForm2");
                    var Question2 =  document.getElementById("findQuestion");
                    form.style.display = 'none';
                    form2.style.display = "block";
                    Question2.value = data.question;
                }
                else
                {
                    alert("手机号未注册");
                }
            }
        }
    )
}
function findPasswordByAnswer()
{
    let formData = new FormData($("#findForm2")[0]);//建立formdata对象
    $.ajax(
        {
            url:"qj",//目标
            type:'POST',
            contentType:false,
            processData: false,
            data:formData,//要传递的内容
            success:function (data)//接受返回值
            {
                if(data.right=true)
                {
                    alert("密码为"+data.answer);
                }
                else
                {
                    alert("密保错误");
                }
            }
        }
    )
}