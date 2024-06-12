<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单确认</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <style>
        .container {
            max-width: 800px;
            margin: 50px auto;
        }
        .order-row {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .address-select {
            margin-top: 10px;
        }
        .new-address-button {
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>订单确认</h2>
    <form id="confirmOrderForm" method="post">
        <div id="orderList">
            <c:choose>
                <c:when test="${cartList.isEmpty() }">
                    <hr><h3>暂无任何订单！</h3><hr>
                </c:when>
                <c:otherwise>
                    <c:set var="defaultBuyer_address" value="${defaultAddress.getProvince()}  ${defaultAddress.getCity()}  ${defaultAddress.getArea()}  ${defaultAddress.getInfo()}" />
                    <c:forEach var="order" items="${cartList}">
                        <div class="order-row">
                            <strong>${order.bookName}</strong><br>
                            数量：${order.bookNum}<br>
                            总价：<fmt:formatNumber value="${order.sum}" type="currency" /><br>
                            收货人：<span id="receiverName-${order.bid}">${defaultAddress.getReceiver_name()}</span><br>
                            收货地址：<span id="buyerAddress-${order.bid}">${defaultBuyer_address}</span><br>
                            电话：<span id="buyerTel-${order.bid}">${defaultAddress.getTel()}</span><br>
                            邮编：<span id="postalCode-${order.bid}">${defaultAddress.getPostal_code()}</span><br>
                            <button type="button" class="btn btn-primary" onclick="showAddressModal(${order.bid})">修改地址信息</button>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
        <div>
            <button type="button" class="btn btn-success" onclick="confirmOrder()">去支付</button>
        </div>
    </form>
</div>

<!-- Address Modal -->
<div class="modal fade" id="addressModal" tabindex="-1" role="dialog" aria-labelledby="addressModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addressModalLabel">选择地址</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>


            <div class="modal-body">
                <select class="form-control address-select" id="addressSelect">
                    <c:forEach var="address" items="${addressList}">
                        <c:set var="buyer_address" value="${address.province},${address.city},${address.area},${address.info}" />
                        <option value="${address.user_address_id}"
                                data-receiver="${address.receiver_name}"
                                data-address="${address.province},${address.city},${address.area},${address.info}"
                                data-tel="${address.tel}"
                                data-postal="${address.postal_code}"
                        >
                                ${address.receiver_name}
                                ${buyer_address}
                                ${address.tel}
                                ${address.postal_code}
                        </option>

                    </c:forEach>
                </select>
                <button type="button" class="btn btn-secondary new-address-button" onclick="window.location.href='addAddress.jsp'">添加地址信息</button>
            </div>


            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="selectAddress()">确定</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<script>
    var selectedOrderBid;

    function showAddressModal(bid) {
        selectedOrderBid = bid;
        $('#addressModal').modal('show');
    }

    function selectAddress() {
        var selectedOption = $('#addressSelect option:selected');
        $('#receiverName-' + selectedOrderBid).text(selectedOption.data('receiver'));
        $('#buyerAddress-' + selectedOrderBid).text(selectedOption.data('address'));
        $('#buyerTel-' + selectedOrderBid).text(selectedOption.data('tel'));
        $('#postalCode-' + selectedOrderBid).text(selectedOption.data('postal'));
        $('#addressModal').modal('hide');
    }

    function confirmOrder() {
        var formData = $('#confirmOrderForm').serializeArray();
        $('.order-row').each(function() {
            var bid = $(this).find('button').attr('onclick').match(/\d+/)[0];
            formData.push({name: 'receiverName-' + bid, value: $('#receiverName-' + bid).text()});
            formData.push({name: 'buyerAddress-' + bid, value: $('#buyerAddress-' + bid).text()});
            formData.push({name: 'buyerTel-' + bid, value: $('#buyerTel-' + bid).text()});
            formData.push({name: 'postalCode-' + bid, value: $('#postalCode-' + bid).text()});
        });
        $.ajax({
            url: 'AddManyOrdersServlet',
            type: 'POST',
            data: formData,
            success: function(response) {
                if (response.status === "success") {
                    alert('订单提交成功！');
                    window.location.href = 'index.jsp';  // 跳转到成功页面
                } else if(response.status === "insufficient_funds") {
                    alert('账户余额不足，请先进行充值！');
                }else if(response.status === "bookNumFalse")
                {
                    alert('很抱歉，您买的某种书  库存不足！');
                }else if (response.status === "Change_money_failed")
                {
                    alert('改钱失败了！');
                } else {
                    alert('订单提交失败！');
                }
            },
            error: function() {
                alert('进入AddManyOrdersServlet失败！ 请求失败');
            }
        });
    }
</script>

<script src="js/bootstrap.min.js"></script>
</body>
</html>
