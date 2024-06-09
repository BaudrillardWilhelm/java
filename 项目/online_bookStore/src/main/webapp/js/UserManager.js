$(document).ready(function (){
    $("#UserManagerShowButton").click(function (){UserManagerShowButtonRun();});
});
function UserManagerShowButtonRun()
{
var first = document.getElementById("UserManagerShow");
var second = document.getElementById("UserRecharge");
    if(first.style.display == 'none')
{
    $.ajax({
        url: 'ums', // 指向你的Servlet的URL
        type: 'GET',
        dataType: 'json', // 告诉jQuery我们期望返回JSON数据
        contentType:false,
        processData: false,
        success: function(data) {
            var UserUid = document.getElementById("UserUid");
            UserUid.value = data.Uid
            var UserUname = document.getElementById("UserUname");
            UserUname.value = data.Uname
            var UserUpassword = document.getElementById("UserUpassword");
            UserUpassword.value = data.Upassword
            var UserUquestion = document.getElementById("UserUquestion");
            UserUquestion.value = data.uquestion
            var UserUanswer = document.getElementById("UserUanswer");
            UserUanswer.value = uanswer.uanswer
            var UserTrue_name = document.getElementById("UserTrue_name");
            UserTrue_name.value = data.true_name
            var UserGender = document.getElementById("UserGender");
            UserGender.value = data.gender
            var UserTel = document.getElementById("UserTel");
            UserTel.value = data.tel
            var UserE_mail = document.getElementById("UserE_mail");
            UserE_mail.value = data.e_mail
            var UserCareer = document.getElementById("UserCareer");
            UserCareer.value = data.career

            //兴趣是多选框
            var checkboxes = document.getElementsByName('Interest');
            for(var i = 0;i<checkboxes.length;i++)
            {
                if(data.receiveBack.get(checkboxes[i].value) == true)
                {
                    checkboxes[i].checked = true;
                }
            }

            var UserAddress = document.getElementById("UserAddress");
            UserAddress.value = data.address
            var UserMoney = document.getElementById("UserMoney");
            UserMoney.value = data.money
            var UserRegistration_time = document.getElementById("UserRegistration_time");
            UserRegistration_time.value = data.registration_time
        }
    });
    first.style.display = 'block';
    second.style.display = 'none';
}
}

$(document).ready(function (){
    $("#UserRechargeButton").click(function (){UserRechargeButtonRun();});
});
function UserRechargeButtonRun() {
    var first = document.getElementById("UserManagerShow");
    var second = document.getElementById("UserRecharge");
    if (second.style.display == 'none') {
        second.style.display = 'block';
        first.style.display = 'none';
    }
}

//修改用户密码
$(document).ready(function (){
    $("#ChangePassword").click(function (){ChangePasswordRun();});
});
function ChangePasswordRun()
{
    var receive1 = document.getElementById("UserUpasswordAgain");//处理隐藏input
    var receive2 = document.getElementById("UserUpassword");//处理原有输入框
    if(receive1.style.display = "none")
    {
        receive1.style.display = "block";
    }
    else
    {
        if(receive1.placeholder = "请再次输入旧密码")
        {
            if(receive1.value==receive2.value)
            {

            }
            else
            {
                alert("密码错误请重试");
                receive1.value = "";
            }
        }
        else
        {
            receive1.value = "";
            receive1.placeholder ="请输入修改后的密码"
        }
    }
}