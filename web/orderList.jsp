<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Order List - CoffeeLux</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/order-style.css" rel="stylesheet">
    <style>
        .table thead th {
            background-color: white !important;
            color: #000000 !important;
            font-weight: 900 !important;
            border: 1px solid #000 !important;
        }
        .table td {
            border: 1px solid #000 !important;
            background-color: white !important;
        }
        .table {
            background-color: white !important;
        }
        .bg-secondary {
            background-color: white !important;
        }
    </style>
</head>
<body>
    <div class="container-fluid position-relative d-flex p-0">
        <jsp:include page="includes/sidebar.jsp"/>
        <div class="content">
            <jsp:include page="includes/navbar.jsp"/>
            <div class="container-fluid pt-4 px-4">
                <div class="bg-secondary text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">Order List</h6>
                    </div>
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-white">
                                    <th scope="col">ID</th>
                                    <th scope="col">Product</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Total</th>
                                    <th scope="col">Time</th>
                                    <th scope="col">Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>${order.orderID}</td>
                                        <td>${order.productName}</td>
                                        <td>${order.quantity}</td>
                                        <td><fmt:formatNumber value="${order.total}" type="currency" currencySymbol="₫"/></td>
                                        <td><fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td>${order.status}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <jsp:include page="includes/footer.jsp"/>
        </div>
    </div>
</body>
</html>
