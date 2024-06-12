
$(document).ready(function () {

});

function deleteEmp(empId) {

    $.ajax({
        url: 'des',
        type: 'POST',
        data: {empId: empId},
        success: function (data) {
            if (data !=0 ) {
                $("#tr"+empId).remove();
            }
        },
        error: function () {
            alert("error");
        }
    });
}
