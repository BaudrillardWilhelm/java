$(document).ready(function (){
    $("#UserManagerShowButton").click(function (){UserManagerShowButtonRun();});
});
function UserManagerShowButtonRun()
{
var first = document.getElementById("UserManagerShow");
var second = document.getElementById("UserRecharge");
    if(true)
{
    alert("ggg");
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
            UserUanswer.value = data.uanswer
            var UserTrue_name = document.getElementById("UserTrue_name");
            UserTrue_name.value = data.true_name
            var UserGender = document.getElementById("UserGender");
            UserGender.value = data.gender
            var UserTel = document.getElementById("UserTel");
            UserTel.value = data.Tel
            var UserE_mail = document.getElementById("UserE_mail");
            UserE_mail.value = data.e_mail
            var UserCareer = document.getElementById("UserCareer");
            UserCareer.value = data.career

            //兴趣是多选框
            var checkboxes = document.getElementsByName('Interest');
            if(data.a== true)
            {
                checkboxes[0].checked  = true;
            }
            if(data.b== true)
            {
                checkboxes[1].checked  = true;
            }
            if(data.c== true)
            {
                checkboxes[2].checked  = true;
            }
            if(data.d== true)
            {
                checkboxes[3].checked  = true;
            }
            if(data.e== true)
            {
                checkboxes[4].checked  = true;
            }
            if(data.f== true)
            {
                checkboxes[5].checked  = true;
            }
            if(data.g== true)
            {
                checkboxes[6].checked  = true;
            }
            if(data.h== true)
            {
                checkboxes[7].checked  = true;
            }
            if(data.i== true)
            {
                checkboxes[8].checked  = true;
            }
            if(data.j== true)
            {
                checkboxes[9].checked  = true;
            }
            if(data.k== true)
            {
                checkboxes[10].checked  = true;
            }
            if(data.l== true)
            {
                checkboxes[11].checked  = true;
            }
            if(data.m== true)
            {
                checkboxes[12].checked  = true;
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
    var receive3 = document.getElementById("ChangePasswordSure");
    if(receive1.style.display == "none")
    {
        receive1.style.display = "block";
        receive3.style.display="block";
    }
    else
    {
        receive1.value = "";
        receive1.placeholder ="请再次输入旧密码";
        receive1.style.display = "none";
        receive3.style.display="none";
    }
}
$(document).ready(function (){
    $("#ChangePasswordSure").click(function (){ChangePasswordSureRun();});
});
function ChangePasswordSureRun()
{
    var receive1 = document.getElementById("UserUpasswordAgain");//处理隐藏input
    var receive2 = document.getElementById("UserUpassword");//处理原有输入框
    if(receive1.placeholder=="请再次输入旧密码")
    {
        if(receive1.value==receive2.value)
        {
            receive1.value = "";
            receive1.placeholder ="请输入修改后的密码"
        }
        else
        {
            alert("密码错误请重试");
            receive1.value = "";
        }
    }
    else
    {
        let up = new FormData();
        up.append("password",receive1.value);
        up.append("uid",$("#UserUid").val());
        $.ajax(
            {
                url: 'UserManagerChangePasswordServlet',
                type: 'POST',
                contentType: false,
                processData: false,
                data:up,
                success:function (response)
                {
                    if(response.flag == true)
                    {
                        receive2.value = "receive1.value";
                        receive1.value = "";
                        receive1.style.display="none";
                        var receive3 = document.getElementById("ChangePasswordSure");
                        receive3.style.display="none";
                        alert("修改完成");
                    }
                }
            }
        )
    }
}
//修改密保问题
$(document).ready(function (){
    $("#ChangeUquestion").click(function (){ChangeUquestionRun();});
});
function ChangeUquestionRun()
{
    var receive = document.getElementById("ChangeUquestionGoal");
    var receive2 = document.getElementById("ChangeUquestionSure");
    if(receive.style.display == "none")
    {
        receive.style.display = "block";
        receive2.style.display = "block";
    }
    else
    {
        receive2.value = "";
        receive.style.display = "none";
        receive2.style.display = "none";
    }

}
$(document).ready(function (){
    $("#ChangeUquestionSure").click(function (){ChangeUquestionSureRun();});
});
function ChangeUquestionSureRun()
{
    var receive = document.getElementById("ChangeUquestionGoal");
    var receive2 = document.getElementById("ChangeUquestionSure");
    var receive3 = document.getElementById("UserUquestion");
    let up = new FormData();
    up.append("g",$("#ChangeUquestionGoal").val());
    up.append("uid",$("#UserUid").val());
    $.ajax(
        {
            url: 'UserManagerChangeQuestionServlet',
            type: 'POST',
            contentType: false,
            processData: false,
            data:up,
            success:function (response)
            {
                if(response.flag == true)
                {
                    receive3.value = receive.value;
                    receive2.value = "";
                    receive.style.display = "none";
                    receive2.style.display = "none";
                    alert("修改完成");
                }
            }
        }
    )
}
//修改密保答案
$(document).ready(function (){
    $("#ChangeUanswer").click(function (){ChangeUanswerRun();});
});
function ChangeUanswerRun()
{
    var receive = document.getElementById("ChangeUanswerGoal");
    var receive2 = document.getElementById("ChangeUanswerSure");
    if(receive.style.display == "none")
    {
        receive.style.display = "block";
        receive2.style.display = "block";
    }
    else
    {
        receive2.value = "";
        receive.style.display = "none";
        receive2.style.display = "none";
    }

}
$(document).ready(function (){
    $("#ChangeUanswerSure").click(function (){ChangeUanswerSureRun();});
});
function ChangeUquestionSureRun()
{
    var receive = document.getElementById("ChangeUanswerGoal");
    var receive2 = document.getElementById("ChangeUanswerSure");
    var receive3 = document.getElementById("UserUanswer");
    let up = new FormData();
    up.append("g",$("#ChangeUanswerGoal").val());
    up.append("uid",$("#UserUid").val());
    $.ajax(
        {
            url: 'UserManagerChangeAnswerServlet',
            type: 'POST',
            contentType: false,
            processData: false,
            data:up,
            success:function (response)
            {
                if(response.flag == true)
                {
                    receive3.value = receive.value;
                    receive2.value = "";
                    receive.style.display = "none";
                    receive2.style.display = "none";
                    alert("修改完成");
                }
            }
        }
    )
}
//修改真实姓名
$(document).ready(function (){
    $("#ChangeTrue_name").click(function (){ChangeTrue_nameRun();});
});
function ChangeTrue_nameRun()
{
    var receive = document.getElementById("ChangeTrue_nameGoal");
    var receive2 = document.getElementById("ChangeTrue_nameSure");
    if(receive.style.display == "none")
    {
        receive.style.display = "block";
        receive2.style.display = "block";
    }
    else
    {
        receive2.value = "";
        receive.style.display = "none";
        receive2.style.display = "none";
    }

}
$(document).ready(function (){
    $("#ChangeTrue_nameSure").click(function (){ChangeTrue_nameSureRun();});
});
function ChangeTrue_nameSureRun()
{
    var receive = document.getElementById("ChangeTrue_nameGoal");
    var receive2 = document.getElementById("ChangeTrue_nameSure");
    var receive3 = document.getElementById("UserTrue_name");
    let up = new FormData();
    up.append("g",$("#ChangeTrue_nameGoal").val());
    up.append("uid",$("#UserUid").val());
    $.ajax(
        {
            url: 'UserManagerChangeTrue_NameServlet',
            type: 'POST',
            contentType: false,
            processData: false,
            data:up,
            success:function (response)
            {
                if(response.flag == true)
                {
                    receive3.value = receive.value;
                    receive2.value = "";
                    receive.style.display = "none";
                    receive2.style.display = "none";
                    alert("修改完成");
                }
            }
        }
    )
}

//修改手机号
$(document).ready(function (){
    $("#ChangeTel").click(function (){ChangeTelRun();});
});
function ChangeTelRun()
{
    var receive = document.getElementById("ChangeTelGoal");
    var receive2 = document.getElementById("ChangeTelSure");
    if(receive.style.display == "none")
    {
        receive.style.display = "block";
        receive2.style.display = "block";
    }
    else
    {
        receive2.value = "";
        receive.style.display = "none";
        receive2.style.display = "none";
    }

}
$(document).ready(function (){
    $("#ChangeTelSure").click(function (){ChangeTelSureRun();});
});
function ChangeTelSureRun()
{
    var receive = document.getElementById("ChangeTelGoal");
    var receive2 = document.getElementById("ChangeTelSure");
    var receive3 = document.getElementById("UserTel");
    let up = new FormData();
    up.append("g",$("#ChangeTelGoal").val());
    up.append("uid",$("#UserUid").val());
    $.ajax(
        {
            url: 'UserManagerChangeTelServlet',
            type: 'POST',
            contentType: false,
            processData: false,
            data:up,
            success:function (response)
            {
                if(response.flag == true)
                {
                    receive3.value = receive.value;
                    receive2.value = "";
                    receive.style.display = "none";
                    receive2.style.display = "none";
                    alert("修改完成");
                }
                else
                {
                    alert("手机号已经被注册，请重新输入");
                }
            }
        }
    )
}

//修改电子邮箱
$(document).ready(function (){
    $("#ChangeE_mail").click(function (){ChangeEmailRun();});
});
function ChangeEmailRun()
{
    var receive = document.getElementById("ChangeE_mailGoal");
    var receive2 = document.getElementById("ChangeE_mailSure");
    if(receive.style.display == "none")
    {
        receive.style.display = "block";
        receive2.style.display = "block";
    }
    else
    {
        receive2.value = "";
        receive.style.display = "none";
        receive2.style.display = "none";
    }

}
$(document).ready(function (){
    $("#ChangeE_mailSure").click(function (){ChangeE_mailSureRun();});
});
function ChangeE_mailSureRun()
{
    var receive = document.getElementById("ChangeE_mailGoal");
    var receive2 = document.getElementById("ChangeE_mailSure");
    var receive3 = document.getElementById("UserE_mail");
    let up = new FormData();
    up.append("g",$("#ChangeE_mailGoal").val());
    up.append("uid",$("#UserUid").val());
    $.ajax(
        {
            url: 'UserManagerChangeE_mailServlet',
            type: 'POST',
            contentType: false,
            processData: false,
            data:up,
            success:function (response)
            {
                if(response.flag == true)
                {
                    receive3.value = receive.value;
                    receive2.value = "";
                    receive.style.display = "none";
                    receive2.style.display = "none";
                    alert("修改完成");
                }
            }
        }
    )
}

//修改职业
$(document).ready(function (){
    $("#ChangeCareer").click(function (){ChangeCareerRun();});
});
function ChangeCareerRun()
{
    var receive = document.getElementById("ChangeCareerGoal");
    var receive2 = document.getElementById("ChangeCareerSure");
    if(receive.style.display == "none")
    {
        receive.style.display = "block";
        receive2.style.display = "block";
    }
    else
    {
        receive2.value = "";
        receive.style.display = "none";
        receive2.style.display = "none";
    }

}
$(document).ready(function (){
    $("#ChangeCareerSure").click(function (){ChangeCareerSureRun();});
});
function ChangeCareerSureRun()
{
    var receive = document.getElementById("ChangeCareerGoal");
    var receive2 = document.getElementById("ChangeCareerSure");
    var receive3 = document.getElementById("UserCareer");
    let up = new FormData();
    up.append("g",$("#ChangeCareerGoal").val());
    up.append("uid",$("#UserUid").val());
    $.ajax(
        {
            url: 'UserManagerChangeCareerServlet',
            type: 'POST',
            contentType: false,
            processData: false,
            data:up,
            success:function (response)
            {
                if(response.flag == true)
                {
                    receive3.value = receive.value;
                    receive2.value = "";
                    receive.style.display = "none";
                    receive2.style.display = "none";
                    alert("修改完成");
                }
            }
        }
    )
}


//修改收获地址
$(document).ready(function (){
    $("#ChangeAddress").click(function (){ChangeAddressRun();});
});
function ChangeAddressRun()
{
    var receive = document.getElementById("ChangeAddressGoal");
    var receive2 = document.getElementById("ChangeAddressSure");
    if(receive.style.display == "none")
    {
        receive.style.display = "block";
        receive2.style.display = "block";
    }
    else
    {
        receive2.value = "";
        receive.style.display = "none";
        receive2.style.display = "none";
    }

}
$(document).ready(function (){
    $("#ChangeAddressSure").click(function (){ChangeAddressSureRun();});
});
function ChangeAddressSureRun()
{
    var receive = document.getElementById("ChangeAddressGoal");
    var receive2 = document.getElementById("ChangeAddressSure");
    var receive3 = document.getElementById("UserAddress");
    let up = new FormData();
    up.append("g",$("#ChangeAddressGoal").val());
    up.append("uid",$("#UserUid").val());
    $.ajax(
        {
            url: 'UserManagerChangeAddressServlet',
            type: 'POST',
            contentType: false,
            processData: false,
            data:up,
            success:function (response)
            {
                if(response.flag == true)
                {
                    receive3.value = receive.value;
                    receive2.value = "";
                    receive.style.display = "none";
                    receive2.style.display = "none";
                    alert("修改完成");
                }
            }
        }
    )
}
//修改感兴趣的类型
$(document).ready(function (){
    $("#ChangeInterest").click(function (){ChangeInterestRun();});
});
function ChangeInterestRun()
{
    let formData = new FormData($("#userInterestForm")[0]);//建立formdata对象
    formData.append("uid",$("#UserUid").val())
    $.ajax(
        {
            url: 'UserManagerChangerInterestServlet',
            type: 'POST',
            contentType: false,
            processData: false,
            data:formData,
            success:function (response)
            {
                if(response.flag == true)
                {
                    alert("修改完成");
                }
            }
        }
    )
}
$(document).ready(function (){
    $("#UserRechargeButton").click(function (){UserRechargeButtonRun();});
});
function UserRechargeButtonRun()
{
    var receive = document.getElementById("UserRecharge");
    var receive2 = document.getElementById("UserManagerShow");
    if(receive.style.display=="none")
    {
        receive.style.display="block";
        receive2.style.display="none";
    }
}
$(document).ready(function (){
    $("#RechargeSure").click(function (){RechargeSureRun();});
});
function RechargeSureRun()
{
    var receive = document.getElementById("RechargeGet");
    var receive2 = document.getElementById("UserMoney");
    let up = new FormData();
    up.append("g",$("#RechargeGet").val());
    up.append("uid",$("#UserUid").val());
    $.ajax(
        {
            url: 'UserManagerRechargeServlet',
            type: 'POST',
            contentType: false,
            processData: false,
            data:up,
            success:function (response)
            {
                if(response.flag == true)
                {
                    alert("充值成功");
                    location.reload();
                }
            }
        }
    )
}