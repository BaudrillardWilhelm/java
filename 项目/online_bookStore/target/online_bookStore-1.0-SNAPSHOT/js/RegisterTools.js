$(document).ready(function (){
    $("#RegisterButton").click(function (){RegisterUp();});
});
function RegisterUp()
{
    let formData = new FormData($("#registerFrom")[0]);//建立formdata对象
    $.ajax(
        {
            url:'rs',//目标
            type:'POST',
            contentType:false,
            processData: false,
            data:formData,//要传递的内容
            success:function (data)//接受返回值
            {
                if(data.RegisterTrue==true)
                {
                    window.location.href="Userlogin.jsp";
                }
                else
                {
                    alert("注册失败，请重试");
                }
            }
        }
    )
}
$(document).ready(function (){
    $("#userTel").on('blur',function (){CheckPhone();});

});
function CheckPhone()
{
    let ccc = new FormData();
    ccc.append("inputData",$("#userTel").val());
    $.ajax(
        {
            url: 'uc',
            type: 'POST',
            contentType: false,
            processData: false,
            data:ccc,
            success:function (response)
            {
                if(response.Have == true)
                {
                    alert("手机号已经被注册");
                    let empty = document.getElementById("userTel");
                    empty.value = "";
                }
                else
                {

                }
            }
        }
    )

}
$(document).ready(function (){
    $("#userPasswordSure").on('blur',function (){CheckPassword();});

});
function CheckPassword()
{
    let receive2 = $("#userPasswordSure").val();
    let receive = $("#userPassword").val();
    if(receive2!=receive)
    {
        alert("2次密码不一致");
        let empty = document.getElementById("userPasswordSure");
        empty.value = "";
    }
    else
    {

    }
}