<%@ page import="com.qdu.dao.impl.UserDaoImpl" %>
<%@ page import="com.qdu.model.Users" %>
<%@ page session="false" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    HttpSession session = request.getSession(false);
    Users loggedUser = (Users) session.getAttribute("LoggedUser");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>新增收货地址</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <style>
        .container {
            max-width: 600px;
            margin: 50px auto;
        }
    </style>
    <script>
        $(document).ready(function() {
            // Load the province, city, and area options
            $.getJSON('json/china.json', function(data) {
                $.each(data, function(index, province) {
                    $('#province').append($('<option>', {
                        value: province.name,
                        text: province.name
                    }));
                });

                // When province is selected, load the cities
                $('#province').change(function() {
                    var selectedProvince = $(this).val();
                    $('#city').empty().append($('<option>', {
                        value: '',
                        text: '请选择市'
                    }));
                    $('#area').empty().append($('<option>', {
                        value: '',
                        text: '请选择区'
                    }));
                    $.each(data, function(index, province) {
                        if (province.name === selectedProvince) {
                            $.each(province.cities, function(index, city) {
                                $('#city').append($('<option>', {
                                    value: city.name,
                                    text: city.name
                                }));
                            });
                        }
                    });
                });

                // When city is selected, load the areas
                $('#city').change(function() {
                    var selectedProvince = $('#province').val();
                    var selectedCity = $(this).val();
                    $('#area').empty().append($('<option>', {
                        value: '',
                        text: '请选择区'
                    }));
                    $.each(data, function(index, province) {
                        if (province.name === selectedProvince) {
                            $.each(province.cities, function(index, city) {
                                if (city.name === selectedCity) {
                                    $.each(city.areas, function(index, area) {
                                        $('#area').append($('<option>', {
                                            value: area,
                                            text: area
                                        }));
                                    });
                                }
                            });
                        }
                    });
                });
            });
        });

        function addAddress() {
            var province = $('#province').val();
            var city = $('#city').val();
            var area = $('#area').val();
            var info = $('#info').val();
            var receiverName = $('#receiverName').val();
            var buyerTel = $('#buyerTel').val();
            var postalCode = $('#postalCode').val();

            $.ajax({
                url: 'addAddressServlet',
                type: 'POST',
                data: {
                    province: province,
                    city: city,
                    area: area,
                    info: info,
                    receiverName: receiverName,
                    tel: buyerTel,
                    postalCode: postalCode
                },
                success: function(response) {
                    if (response == 1) {
                        alert('地址添加成功');
                        location.reload();
                    } else if (response == 0) {
                        alert('地址添加失败');
                    } else if (response == -1) {
                        alert('数据库错误');
                    }
                },
                error: function() {
                    alert('请求失败');
                }
            });
        }
    </script>
</head>
<body>
<div class="container">
    <h2>新增收货地址</h2>
    <form onsubmit="addAddress(); return false;">
        <div class="form-group">
            <label for="receiverName">收货人姓名</label>
            <input type="text" class="form-control" id="receiverName" required>
        </div>
        <div class="form-group">
            <label for="buyerTel">电话</label>
            <input type="text" class="form-control" id="buyerTel" required>
        </div>
        <div class="form-group">
            <label for="postalCode">邮政编码</label>
            <input type="text" class="form-control" id="postalCode" required>
        </div>
        <div class="form-group">
            <label for="province">省</label>
            <select class="form-control" id="province" required>
                <option value="">请选择省</option>
            </select>
        </div>
        <div class="form-group">
            <label for="city">市</label>
            <select class="form-control" id="city" required>
                <option value="">请选择市</option>
            </select>
        </div>
        <div class="form-group">
            <label for="area">区</label>
            <select class="form-control" id="area" required>
                <option value="">请选择区</option>
            </select>
        </div>
        <div class="form-group">
            <label for="info">详细地址</label>
            <input type="text" class="form-control" id="info" required>
        </div>
        <button type="submit" class="btn btn-primary">提交</button>
    </form>
</div>
</body>
</html>
