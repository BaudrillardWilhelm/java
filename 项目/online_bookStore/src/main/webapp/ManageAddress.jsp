<%@ page import="com.qdu.dao.impl.AddressDaoImpl" %>
<%@ page import="com.qdu.model.Users" %>
<%@ page import="com.qdu.model.Address" %>
<%@ page import="java.util.List" %>
<%@ page session="false" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    Users loggedUser = (Users) session.getAttribute("LoggedUser");
    AddressDaoImpl addressDao = new AddressDaoImpl();
    List<Address> addressList = addressDao.findAddressListById(String.valueOf(loggedUser.getUid()));
%>

<script src="js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理收货地址</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
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

        function showEditModal(address) {
            $('#editAddressId').val(address.user_address_id);
            $('#editReceiverName').val(address.receiver_name);
            $('#editBuyerTel').val(address.tel);
            $('#editPostalCode').val(address.postal_code);
            $('#editProvince').val(address.province);
            $('#editCity').val(address.city);
            $('#editArea').val(address.area);
            $('#editInfo').val(address.info);
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
            var accurateAddress = province + city + area + info;

            $.ajax({
                url: 'updateAddressServlet',
                type: 'POST',
                data: {
                    user_address_id: addressId,
                    province: province,
                    city: city,
                    area: area,
                    info: info,
                    receiver_name: receiverName,
                    tel: buyerTel,
                    postal_code: postalCode
                },
                success: function(response) {
                    if (response == 1) {
                        alert('地址更新成功');
                        location.reload();
                    } else if (response == 0) {
                        alert('地址更新失败');
                    } else if (response == -1) {
                        alert('数据库错误');
                    }
                },
                error: function() {
                    alert('请求失败');
                }
            });
        }

        function deleteAddress(addressId) {
            if (confirm('确定要删除这个地址吗？')) {
                $.ajax({
                    url: 'deleteAddressServlet',
                    type: 'POST',
                    data: { user_address_id: addressId },
                    success: function(response) {
                        if (response == 1) {
                            alert('地址删除成功');
                            location.reload();
                        } else if (response == 0) {
                            alert('地址删除失败');
                        } else if (response == -1) {
                            alert('数据库错误');
                        }
                    },
                    error: function() {
                        alert('请求失败');
                    }
                });
            }
        }
    </script>
</head>
<body>
<div class="container">
<%--    /**--%>
<%--    * 是一个基本上可以独立运行的页面，从session中拿loggedUser--%>
<%--    * 用于管理用户地址--%>
<%--    * @param address--%>
<%--    */--%>
    <h2>管理收货地址</h2>
    <button class="btn btn-primary" data-toggle="modal" data-target="#addAddressModal">新增地址</button>
    <div class="address-list">
        <c:forEach var="address" items="${addressList}">
            <div class="address-row">
                <div>
                    <strong>${address.receiver_name}</strong><br>
                        ${address.province} ${address.city} ${address.area} ${address.info}<br>
                        ${address.tel} <br>
                        ${address.postal_code}
                </div>
                <div class="address-actions">
                    <button class="btn btn-sm btn-warning" onclick='showEditModal(${address})'>编辑</button>
                    <button class="btn btn-sm btn-danger" onclick='deleteAddress(${address.user_address_id})'>删除</button>
                </div>
                <div style="clear: both;"></div>
            </div>
        </c:forEach>
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
                    <select class="form-control" id="editProvince" required>
                        <!-- Add options for provinces -->
                    </select>
                </div>
                <div class="form-group">
                    <label for="editCity">市</label>
                    <select class="form-control" id="editCity" required>
                        <!-- Add options for cities -->
                    </select>
                </div>
                <div class="form-group">
                    <label for="editArea">区</label>
                    <select class="form-control" id="editArea" required>
                        <!-- Add options for areas -->
                    </select>
                </div>
                <div class="form-group">
                    <label for="editInfo">详细地址</label>
                    <input type="text" class="form-control" id="editInfo" required>
                </div>
                <button type="button" class="btn btn-primary" onclick="updateAddress()">确认修改</button>
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
                    <select class="form-control" id="addProvince" required>
                        <!-- Add options for provinces -->
                    </select>
                </div>
                <div class="form-group">
                    <label for="addCity">市</label>
                    <select class="form-control" id="addCity" required>
                        <!-- Add options for cities -->
                    </select>
                </div>
                <div class="form-group">
                    <label for="addArea">区</label>
                    <select class="form-control" id="addArea" required>
                        <!-- Add options for areas -->
                    </select>
                </div>
                <div class="form-group">
                    <label for="addInfo">详细地址</label>
                    <input type="text" class="form-control" id="addInfo" required>
                </div>
                <button type="button" class="btn btn-primary" onclick="addAddress()">提交</button>
            </div>
        </div>
    </div>
</div>


<script>
    // Populate provinces, cities, and areas dynamically
    // Add your logic here to load the options dynamically
</script>
</body>
</html>
