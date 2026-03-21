<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Barista Order Management - CoffeeLux</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/order-style.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid position-relative d-flex p-0">
        <!-- Sidebar -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-light navbar-light">
                <a href="index.jsp" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"><i class="fa fa-coffee me-2"></i>CoffeeLux</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
                        <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                    <div class="ms-3">
                        <h6 class="mb-0">Barista</h6>
                        <span>Staff</span>
                    </div>
                </div>
                <div class="navbar-nav w-100">
                    <a href="index.jsp" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                    <a href="orders" class="nav-item nav-link active"><i class="fa fa-list me-2"></i>Order List</a>
                    <a href="logout" class="nav-item nav-link"><i class="fa fa-sign-out-alt me-2"></i>Logout</a>
                </div>
            </nav>
        </div>

        <!-- Content -->
        <div class="content">
            <!-- Navbar -->
            <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                <a href="#" class="sidebar-toggler flex-shrink-0">
                    <i class="fa fa-bars"></i>
                </a>
                <div class="navbar-nav align-items-center ms-auto">
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <img class="rounded-circle me-lg-2" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                            <span class="d-none d-lg-inline-flex">Barista</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <a href="#" class="dropdown-item">My Profile</a>
                            <a href="logout" class="dropdown-item">Log Out</a>
                        </div>
                    </div>
                </div>
            </nav>

            <!-- Main Content -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light rounded p-4">
                    <!-- Header -->
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h4 class="mb-0"><i class="fa fa-list me-2"></i>Order List</h4>
                        <button class="btn btn-primary" onclick="location.reload()">
                            <i class="fa fa-sync-alt me-2"></i>Refresh
                        </button>
                    </div>

                    <!-- Search and Filter Section -->
                    <div class="filter-section">
                        <form action="orders" method="get" class="row g-3">
                            <input type="hidden" name="action" value="search">
                            <div class="col-md-5">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa fa-search"></i></span>
                                    <input type="text" class="form-control" name="keyword" 
                                           placeholder="Search by product or customer name..." 
                                           value="${keyword}">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <select class="form-select" name="status">
                                    <option value="All" ${selectedStatus == 'All' ? 'selected' : ''}>All Status</option>
                                    <option value="New" ${selectedStatus == 'New' ? 'selected' : ''}>New</option>
                                    <option value="Preparing" ${selectedStatus == 'Preparing' ? 'selected' : ''}>In Progress</option>
                                    <option value="Ready" ${selectedStatus == 'Ready' ? 'selected' : ''}>Ready</option>
                                    <option value="Completed" ${selectedStatus == 'Completed' ? 'selected' : ''}>Completed</option>
                                    <option value="Cancelled" ${selectedStatus == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fa fa-filter me-2"></i>Filter
                                </button>
                            </div>
                            <div class="col-md-2">
                                <a href="orders" class="btn btn-secondary w-100">
                                    <i class="fa fa-redo me-2"></i>Reset
                                </a>
                            </div>
                        </form>
                    </div>

                    <!-- Orders Table -->
                    <div class="table-responsive order-table">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Customer</th>
                                    <th>Product Name</th>
                                    <th>Quantity</th>
                                    <th>Total Price</th>
                                    <th>Order Time</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty orders}">
                                        <tr>
                                            <td colspan="8" class="text-center py-4">
                                                <i class="fa fa-inbox fa-3x text-muted mb-3"></i>
                                                <p class="text-muted">No orders found</p>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="order" items="${orders}">
                                            <tr class="${order.priority ? 'priority-row' : ''}">
                                                <td>
                                                    <strong>#${order.orderID}</strong>
                                                    <c:if test="${order.priority}">
                                                        <span class="badge badge-priority">VIP</span>
                                                    </c:if>
                                                </td>
                                                <td>${order.customerName != null ? order.customerName : 'Guest'}</td>
                                                <td>${order.productName}</td>
                                                <td><span class="badge bg-info">${order.quantity}</span></td>
                                                <td><strong><fmt:formatNumber value="${order.total}" type="number" maxFractionDigits="0"/>₫</strong></td>
                                                <td><fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${order.status == 'New'}">
                                                            <span class="badge badge-new">New</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'Preparing'}">
                                                            <span class="badge badge-preparing">In Progress</span>
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
                                                    <c:choose>
                                                        <c:when test="${order.statusID == 29}">
                                                            <!-- New Order - Show Accept Button -->
                                                            <form action="orders" method="post" style="display: inline;">
                                                                <input type="hidden" name="action" value="accept">
                                                                <input type="hidden" name="orderID" value="${order.orderID}">
                                                                <button type="submit" class="btn btn-action btn-accept" title="Accept Order">
                                                                    <i class="fa fa-check"></i> Accept
                                                                </button>
                                                            </form>
                                                        </c:when>
                                                        <c:when test="${order.statusID == 30}">
                                                            <!-- In Progress - Show Complete Button -->
                                                            <form action="orders" method="post" style="display: inline;">
                                                                <input type="hidden" name="action" value="updateStatus">
                                                                <input type="hidden" name="orderID" value="${order.orderID}">
                                                                <input type="hidden" name="statusID" value="31">
                                                                <button type="submit" class="btn btn-action btn-complete" title="Mark as Ready">
                                                                    <i class="fa fa-check-circle"></i> Ready
                                                                </button>
                                                            </form>
                                                        </c:when>
                                                        <c:when test="${order.statusID == 31}">
                                                            <!-- Ready - Show Complete Button -->
                                                            <form action="orders" method="post" style="display: inline;">
                                                                <input type="hidden" name="action" value="updateStatus">
                                                                <input type="hidden" name="orderID" value="${order.orderID}">
                                                                <input type="hidden" name="statusID" value="32">
                                                                <button type="submit" class="btn btn-action btn-complete" title="Complete Order">
                                                                    <i class="fa fa-check-double"></i> Complete
                                                                </button>
                                                            </form>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">-</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    
                                                    <!-- Cancel Button (for New and In Progress orders) -->
                                                    <c:if test="${order.statusID == 29 || order.statusID == 30}">
                                                        <form action="orders" method="post" style="display: inline;">
                                                            <input type="hidden" name="action" value="updateStatus">
                                                            <input type="hidden" name="orderID" value="${order.orderID}">
                                                            <input type="hidden" name="statusID" value="33">
                                                            <button type="submit" class="btn btn-action btn-cancel" title="Cancel Order" 
                                                                    onclick="return confirm('Are you sure you want to cancel this order?')">
                                                                <i class="fa fa-times"></i>
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>

                    <!-- Order Statistics -->
                    <div class="row mt-4">
                        <div class="col-md-3">
                            <div class="card text-center">
                                <div class="card-body">
                                    <h5 class="text-muted">New Orders</h5>
                                    <h3 class="text-primary">
                                        <c:set var="newCount" value="0"/>
                                        <c:forEach var="order" items="${orders}">
                                            <c:if test="${order.statusID == 29}">
                                                <c:set var="newCount" value="${newCount + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        ${newCount}
                                    </h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-center">
                                <div class="card-body">
                                    <h5 class="text-muted">In Progress</h5>
                                    <h3 class="text-warning">
                                        <c:set var="progressCount" value="0"/>
                                        <c:forEach var="order" items="${orders}">
                                            <c:if test="${order.statusID == 30}">
                                                <c:set var="progressCount" value="${progressCount + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        ${progressCount}
                                    </h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-center">
                                <div class="card-body">
                                    <h5 class="text-muted">Ready</h5>
                                    <h3 class="text-info">
                                        <c:set var="readyCount" value="0"/>
                                        <c:forEach var="order" items="${orders}">
                                            <c:if test="${order.statusID == 31}">
                                                <c:set var="readyCount" value="${readyCount + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        ${readyCount}
                                    </h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-center">
                                <div class="card-body">
                                    <h5 class="text-muted">Completed</h5>
                                    <h3 class="text-success">
                                        <c:set var="completedCount" value="0"/>
                                        <c:forEach var="order" items="${orders}">
                                            <c:if test="${order.statusID == 32}">
                                                <c:set var="completedCount" value="${completedCount + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        ${completedCount}
                                    </h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light rounded-top p-4">
                    <div class="row">
                        <div class="col-12 col-sm-6 text-center text-sm-start">
                            &copy; <a href="#">CoffeeLux</a>, All Right Reserved.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
    
    <!-- Auto Refresh (Optional) -->
    <script>
        // Auto refresh every 30 seconds
        // setTimeout(function(){ location.reload(); }, 30000);
    </script>
</body>
</html>
