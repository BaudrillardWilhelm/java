$(document).ready(function (){
    $("#loginSubmitButton").click(function (){upLoadAll();});
    toastr.options.positionClass = 'toast-top-center';
});
function upLoadAll(){
    let formData = new FormData($("#loginForm")[0]);
    $.ajax({
        url: 'loginSubmitServlet',
        type: 'POST',
        contentType: false,
        processData: false,
        data: formData,
        success: function (data){
            if(data.isRight===true){
                toastr.success("登录成功！");
            }
            else{
                toastr.error("账号不存在或密码错误！");
            }
        },
        error:function (){
            alert("出现错误");
        }
    });
}