<%@ page import="com.qdu.dao.impl.AddressDaoImpl" %>
<%@ page import="com.qdu.model.Users" %>
<%@ page import="com.qdu.model.Address" %>
<%@ page import="java.util.List" %>
<%@ page session="false" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    HttpSession session = request.getSession(false);
    Users loggedUser = (Users) session.getAttribute("LoggedUser");
    AddressDaoImpl addressDao = new AddressDaoImpl();
    int uid = loggedUser.getUid();
    List<Address> addressList = addressDao.findAddressListById(uid);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理收货地址</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <style>
        .container {
            max-width: 800px;
            margin: 50px auto;
        }
        .address-row {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .address-actions {
            float: right;
        }
    </style>
    <script>
        $(document).ready(function() {
            loadProvinces('#addProvince');
            loadProvinces('#editProvince');

            $('#addProvince').change(function() {
                loadCities('#addCity', $(this).val());
                $('#addArea').empty().append('<option value="">请选择区</option>');
            });

            $('#addCity').change(function() {
                loadAreas('#addArea', $(this).val());
            });

            $('#editProvince').change(function() {
                loadCities('#editCity', $(this).val());
                $('#editArea').empty().append('<option value="">请选择区</option>');
            });

            $('#editCity').change(function() {
                loadAreas('#editArea', $(this).val());
            });
        });

        function loadProvinces(selectId) {
            $.getJSON('json/china.json', function(data) {
                $(selectId).empty().append('<option value="">请选择省</option>');
                $.each(data, function(index, province) {
                    $(selectId).append($('<option>', { value: province.name, text: province.name }));
                });
            });
        }

        function loadCities(selectId, provinceName) {
            $.getJSON('json/china.json', function(data) {
                $(selectId).empty().append('<option value="">请选择市</option>');
                $.each(data, function(index, province) {
                    if (province.name === provinceName) {
                        $.each(province.cities, function(index, city) {
                            $(selectId).append($('<option>', { value: city.name, text: city.name }));
                        });
                    }
                });
            });
        }

        function loadAreas(selectId, cityName) {
            $.getJSON('json/china.json', function(data) {
                var selectedProvince = $('#addProvince').val();
                $(selectId).empty().append('<option value="">请选择区</option>');
                $.each(data, function(index, province) {
                    if (province.name === selectedProvince) {
                        $.each(province.cities, function(index, city) {
                            if (city.name === cityName) {
                                $.each(city.areas, function(index, area) {
                                    $(selectId).append($('<option>', { value: area, text: area }));
                                });
                            }
                        });
                    }
                });
            });
        }

        function showEditModal(addressId, receiverName, tel, postalCode, province, city, area, info) {
            $('#editAddressId').val(addressId);
            $('#editReceiverName').val(receiverName);
            $('#editBuyerTel').val(tel);
            $('#editPostalCode').val(postalCode);
            $('#editProvince').val(province).trigger('change');
            setTimeout(function() {
                $('#editCity').val(city).trigger('change');
                setTimeout(function() {
                    $('#editArea').val(area);
                }, 500);
            }, 500);
            $('#editInfo').val(info);
            $('#editAddressModal').modal('show');
        }

        function updateAddress() {
            var addressId = $('#editAddressId').val();
            var receiverName = $('#editReceiverName').val();
            var buyerTel = $('#editBuyerTel').val();
            var postalCode = $('#editPostalCode').val();
            var province = $('#editProvince').val();
            var city = $('#editCity').val();
            var area = $('#editArea').val();
            var info = $('#editInfo').val();

            $.ajax({
                url: 'updateAddressServlet',
                type: 'POST',
                data: {
                    user_address_id: addressId,
                    receiver_name: receiverName,
                    tel: buyerTel,
                    postal_code: postalCode,
                    province: province,
                    city: city,
                    area: area,
                    info: info
                },
                success: function(response) {
                    if (response == 1) {
                        alert('地址更新成功');
                        location.reload();
                    } else {
                        alert('地址更新失败');
                    }
                },
                error: function() {
                    alert('请求失败');
                }
            });
        }

        function deleteAddress(addressId,uid) {
            if (confirm('确定要删除这个地址吗？')) {
                $.ajax({
                    url: 'deleteAddressServlet',
                    type: 'POST',
                    data: { user_address_id: addressId, uid: uid },
                    success: function(response) {
                        if (response == 1) {
                            alert('地址删除成功');
                            location.reload();
                        } else {
                            alert('地址删除失败');
                        }
                    },
                    error: function() {
                        alert('请求失败');
                    }
                });
            }
        }

        function addAddress() {
            var receiverName = $('#addReceiverName').val();
            var buyerTel = $('#addBuyerTel').val();
            var postalCode = $('#addPostalCode').val();
            var province = $('#addProvince').val();
            var city = $('#addCity').val();
            var area = $('#addArea').val();
            var info = $('#addInfo').val();

            $.ajax({
                url: 'addAddressServlet',
                type: 'POST',
                data: {
                    receiver_name: receiverName,
                    tel: buyerTel,
                    postal_code: postalCode,
                    province: province,
                    city: city,
                    area: area,
                    info: info
                },
                success: function(response) {
                    if (response == 1) {
                        alert('地址添加成功');
                        location.reload();
                    } else {
                        alert('地址添加失败');
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
    <h2>管理收货地址</h2>
    <button class="btn btn-primary" data-toggle="modal" data-target="#addAddressModal">新增地址</button>
    <div class="address-list">
        <% for (Address address : addressList) { %>
        <div class="address-row">
            <div>
                收货人：<strong><%= address.getReceiver_name() %></strong><br>
                地址：<%= address.getProvince() %> <%= address.getCity() %> <%= address.getArea() %> <%= address.getInfo() %><br>
                联系方式：<%= address.getTel() %><br>
            </div>
            <div class="address-actions">
                <button class="btn btn-sm btn-warning" onclick='showEditModal("<%= address.getUser_address_id() %>", "<%= address.getReceiver_name() %>", "<%= address.getTel() %>", "<%= address.getPostal_code() %>", "<%= address.getProvince() %>", "<%= address.getCity() %>", "<%= address.getArea() %>", "<%= address.getInfo() %>")'>编辑</button>
                <button class="btn btn-sm btn-danger" onclick='deleteAddress(<%= address.getUser_address_id() %>,<%=address.getUid()%>)'>删除</button>
            </div>
            <div style="clear: both;"></div>
        </div>
        <% } %>
    </div>
</div>

<!-- Edit Address Modal -->
<div class="modal fade" id="editAddressModal" tabindex="-1" role="dialog" aria-labelledby="editAddressModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editAddressModalLabel">编辑收货地址</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="editAddressId">
                <div class="form-group">
                    <label for="editReceiverName">收货人姓名</label>
                    <input type="text" class="form-control" id="editReceiverName" required>
                </div>
                <div class="form-group">
                    <label for="editBuyerTel">电话</label>
                    <input type="text" class="form-control" id="editBuyerTel" required>
                </div>
                <div class="form-group">
                    <label for="editPostalCode">邮政编码</label>
                    <input type="text" class="form-control" id="editPostalCode" required>
                </div>
                <div class="form-group">
                    <label for="editProvince">省</label>
                    <select class="form-control" id="editProvince" required></select>
                </div>
                <div class="form-group">
                    <label for="editCity">市</label>
                    <select class="form-control" id="editCity" required></select>
                </div>
                <div class="form-group">
                    <label for="editArea">区</label>
                    <select class="form-control" id="editArea" required></select>
                </div>
                <div class="form-group">
                    <label for="editInfo">详细地址</label>
                    <textarea class="form-control" id="editInfo" required></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="updateAddress()">保存修改</button>
            </div>
        </div>
    </div>
</div>

<!-- Add Address Modal -->
<div class="modal fade" id="addAddressModal" tabindex="-1" role="dialog" aria-labelledby="addAddressModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addAddressModalLabel">新增收货地址</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="addReceiverName">收货人姓名</label>
                    <input type="text" class="form-control" id="addReceiverName" required>
                </div>
                <div class="form-group">
                    <label for="addBuyerTel">电话</label>
                    <input type="text" class="form-control" id="addBuyerTel" required>
                </div>
                <div class="form-group">
                    <label for="addPostalCode">邮政编码</label>
                    <input type="text" class="form-control" id="addPostalCode" required>
                </div>
                <div class="form-group">
                    <label for="addProvince">省</label>
                    <select class="form-control" id="addProvince" required></select>
                </div>
                <div class="form-group">
                    <label for="addCity">市</label>
                    <select class="form-control" id="addCity" required></select>
                </div>
                <div class="form-group">
                    <label for="addArea">区</label>
                    <select class="form-control" id="addArea" required></select>
                </div>
                <div class="form-group">
                    <label for="addInfo">详细地址</label>
                    <textarea class="form-control" id="addInfo" required></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="addAddress()">保存地址</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
