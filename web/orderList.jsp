<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Order List - Coffee System</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
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
            border: 2px solid #000 !important;
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
                <div class="bg-white text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">Order List</h6>
                        <button class="btn btn-primary btn-sm" onclick="location.reload()">
                            <i class="fa fa-sync-alt me-2"></i>Refresh
                        </button>
                    </div>
                    
                    <!-- Search and Filter Section -->
                    <div class="mb-4" style="background-color: white; padding: 1rem; border: 1px solid #dee2e6; border-radius: 0.5rem;">
                        <form action="orders" method="get" class="row g-3">
                            <input type="hidden" name="action" value="search">
                            <div class="col-md-5">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa fa-search"></i></span>
                                    <input type="text" class="form-control" name="keyword" 
                                           placeholder="Search by product name..." 
                                           value="${keyword}">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <select class="form-select" name="status">
                                    <option value="All" ${selectedStatus == 'All' || selectedStatus == null ? 'selected' : ''}>All Status</option>
                                    <option value="New" ${selectedStatus == 'New' ? 'selected' : ''}>New</option>
                                    <option value="Preparing" ${selectedStatus == 'Preparing' ? 'selected' : ''}>Preparing</option>
                                    <option value="Ready" ${selectedStatus == 'Ready' ? 'selected' : ''}>Ready</option>
                                    <option value="Completed" ${selectedStatus == 'Completed' ? 'selected' : ''}>Completed</option>
                                    <option value="Cancelled" ${selectedStatus == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fa fa-filter me-2"></i>Search
                                </button>
                            </div>
                            <div class="col-md-2">
                                <a href="orders" class="btn btn-secondary w-100">
                                    <i class="fa fa-redo me-2"></i>Reset
                                </a>
                            </div>
                        </form>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered mb-0">
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Product</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Total</th>
                                    <th scope="col">Time</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty orders}">
                                        <tr>
                                            <td colspan="7" class="text-center py-4">
                                                <i class="fa fa-inbox fa-3x text-muted mb-3"></i>
                                                <p class="text-muted">No orders found</p>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="order" items="${orders}">
                                            <tr>
                                                <td>${order.orderID}</td>
                                                <td>${order.productName}</td>
                                                <td>${order.quantity}</td>
                                                <td><fmt:formatNumber value="${order.total}" type="currency" currencySymbol="₫"/></td>
                                                <td><fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${order.status == 'New'}">
                                                            <span class="badge badge-new">New</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'Preparing'}">
                                                            <span class="badge badge-preparing">Preparing</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'Ready'}">
                                                            <span class="badge badge-ready">Ready</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'Completed'}">
                                                            <span class="badge badge-completed">Completed</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'Cancelled'}">
                                                            <span class="badge badge-cancelled">Cancelled</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">${order.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <a class="btn btn-sm btn-outline-primary" href="order?action=edit&id=${order.orderID}" title="Chỉnh sửa"><i class="fa fa-edit"></i></a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <jsp:include page="includes/footer.jsp"/>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
