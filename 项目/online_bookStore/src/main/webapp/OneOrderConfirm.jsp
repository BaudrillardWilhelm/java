<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.locale}" />
<fmt:setBundle basename="resources" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单确认</title>
    <style>
        .address-box {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 10px;
            cursor: pointer;
        }
        .address-box.selected {
            border-color: #007bff;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            padding-top: 60px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
    <script src="css/https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            $.ajax({
                url: 'ocs',
                method: 'GET',
                data: {
                    qty: '<%= request.getParameter("qty") %>',
                    bid: '<%= request.getParameter("bid") %>',
                    b_price: '<%= request.getParameter("b_price") %>'
                },
                success: function (response) {
                    renderOrder(response.order);
                    renderAddressList(response.addressList);
                },
                error: function () {
                    alert("加载订单数据失败");
                }
            });

            function renderOrder(order) {
                $("#order-info").html(
                    `<p>图书名称: ${order.bname}</p>
                     <p>购买数量: ${order.book_num}</p>
                     <p>总价: ${order.sum_price}</p>`
                );
                $("input[name='receiverName']").val(order.receiverName);
                $("input[name='buyerAddress']").val(order.buyerAddress);
                $("input[name='buyerTel']").val(order.buyerTel);
                $("input[name='postalCode']").val(order.postalCode);
                $("input[name='bid']").val(order.bid);
                $("input[name='bname']").val(order.bname);
                $("input[name='bookNum']").val(order.book_num);
                $("input[name='sumPrice']").val(order.sum_price);
            }

            function renderAddressList(addressList) {
                let selectedAddress = addressList[0];
                $("#selectedAddress").html(
                    `<p>收货人: ${selectedAddress.receiverName}</p>
                     <p>地址: ${selectedAddress.buyerAddress}</p>
                     <p>电话: ${selectedAddress.buyerTel}</p>
                     <p>邮政编码: ${selectedAddress.postalCode}</p>`
                );
                addressList.forEach(address => {
                    $("#addressModal .modal-content").append(
                        `<div class="address-box" onclick="selectAddress(this)">
                            <p>收货人: ${address.receiverName}</p>
                            <p>地址: ${address.buyerAddress}</p>
                            <p>电话: ${address.buyerTel}</p>
                            <p>邮政编码: ${address.postalCode}</p>
                        </div>`
                    );
                });
            }

            $("#showModal").click(function () {
                $("#addressModal").show();
            });

            $(".close").click(function () {
                $("#addressModal").hide();
            });

            $(window).click(function (event) {
                if (event.target == document.getElementById('addressModal')) {
                    $("#addressModal").hide();
                }
            });

            $("#orderForm").submit(function (event) {
                event.preventDefault(); // Prevent the default form submission

                $.ajax({
                    url: 'addOneOrder',
                    method: 'POST',
                    data: $(this).serialize(),
                    success: function (response) {
                        if (response.status === "insufficient_funds") {
                            alert("账户余额不足，请先进行充值！");
                        } else if (response.status === "success") {
                            alert("订单添加成功！");
                            // Redirect to another page if needed
                        } else {
                            alert("订单添加失败！");
                        }
                    },
                    error: function () {
                        alert("请求失败！");
                    }
                });
            });
        });

        function selectAddress(address) {
            $("#selectedAddress").html($(address).html());
            $("input[name='receiverName']").val($(address).find("p:eq(0)").text().split(": ")[1]);
            $("input[name='buyerAddress']").val($(address).find("p:eq(1)").text().split(": ")[1]);
            $("input[name='buyerTel']").val($(address).find("p:eq(2)").text().split(": ")[1]);
            $("input[name='postalCode']").val($(address).find("p:eq(3)").text().split(": ")[1]);
            $("#addressModal").hide();
        }
    </script>
</head>
<body>

<h1>订单确认</h1>

<h2>订单信息</h2>
<div id="order-info"></div>

<h2>收货地址</h2>
<div class="address-box" id="selectedAddress" onclick="showModal()"></div>

<!-- 模态窗口 -->
<div id="addressModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>选择收货地址</h2>
        <!-- 动态生成的地址列表 -->
    </div>
</div>

<form id="orderForm" action="addOneOrder" method="post">
    <input type="hidden" name="receiverName">
    <input type="hidden" name="buyerAddress">
    <input type="hidden" name="buyerTel">
    <input type="hidden" name="postalCode">
    <input type="hidden" name="bid">
    <input type="hidden" name="bname">
    <input type="hidden" name="bookNum">
    <input type="hidden" name="sumPrice">
    <button type="submit">确认下单</button>
</form>

</body>
</html>
