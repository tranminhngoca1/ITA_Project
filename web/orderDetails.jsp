<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Order Details - CoffeeLux</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <style>
        .disabled-field {
            background-color: #d8cde6 !important; 
            opacity: 1;
            border-radius: 0.5rem;
            border: none;
            padding: 0.375rem 0.75rem;
            color: #333;
        }
        .form-control, .form-select {
            border-radius: 0.5rem;
            border: 1px solid #ced4da;
        }
        .btn-save {
            background-color: #38c172;
            color: white;
            border-radius: 1rem;
            padding: 0.375rem 1.5rem;
            border: none;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .btn-save:hover {
            background-color: #2d995b;
            color: white;
        }
        .btn-cancel {
            background-color: #e2e3e5;
            color: #333;
            border-radius: 1rem;
            padding: 0.375rem 1.5rem;
            border: none;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .btn-cancel:hover {
            background-color: #d3d4d5;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container-fluid position-relative d-flex p-0">
        <jsp:include page="includes/sidebar.jsp"/>
        
        <div class="content">
            <jsp:include page="includes/navbar.jsp"/>
            
            <div class="container-fluid pt-4 px-4">
                <div class="bg-white rounded p-4" style="min-height: 80vh;">
                    
                    <div class="d-flex justify-content-between align-items-start mb-4">
                        <div class="mt-2">
                            <h3 class="fw-bold mb-3" style="color: black;">Order Details</h3>
                            <h5 class="mb-0" style="color: black;">Order ID: <fmt:formatNumber value="${order.orderID}" pattern="00"/></h5>
                        </div>
                        <div class="me-4 mt-2">
                            <!-- Coffee cup illustration -->
                            <i class="fa fa-coffee fa-4x" style="color: black; transform: rotate(-5deg); text-shadow: 2px 2px 0px white, -2px -2px 0px white, 2px -2px 0px white, -2px 2px 0px white, 0px 4px 6px rgba(0,0,0,0.1);"></i>
                        </div>
                    </div>
                    
                    <form action="order" method="post" class="mt-5">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="orderID" value="${order.orderID}">
                        
                        <div class="row g-4 mb-4">
                            <!-- Left Column -->
                            <div class="col-md-5">
                                <div class="mb-4">
                                    <label class="form-label fw-bold" style="color: black;">Product Name</label>
                                    <input type="text" class="form-control disabled-field" value="${order.productName}" disabled>
                                </div>
                                <div>
                                    <label class="form-label fw-bold" style="color: black;">Total</label>
                                    <input type="text" class="form-control disabled-field" value="<fmt:formatNumber value="${order.total}" type="currency" currencySymbol="VND"/>" disabled>
                                </div>
                            </div>
                            
                            <!-- Spacer Column -->
                            <div class="col-md-1"></div>
                            
                            <!-- Right Column -->
                            <div class="col-md-5">
                                <div class="mb-4">
                                    <label class="form-label fw-bold" style="color: black;">Status</label>
                                    <select class="form-select" name="statusID">
                                        <c:forEach var="entry" items="${statuses}">
                                            <option value="${entry.key}" ${entry.key == order.statusID ? 'selected' : ''}>${entry.value}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div>
                                    <label class="form-label fw-bold" style="color: black;">Total Quantity</label>
                                    <input type="text" class="form-control disabled-field" value="${order.quantity}" disabled>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Note Field -->
                        <div class="row mb-5">
                            <div class="col-md-11">
                                <label class="form-label fw-bold" style="color: black;">Note</label>
                                <!-- Placeholder note as backend doesn't store this field currently -->
                                <textarea class="form-control" rows="5" placeholder="Less milk, 1 hot, 1 cold"></textarea>
                            </div>
                        </div>
                        
                        <!-- Buttons -->
                        <div class="row mt-4">
                            <div class="col-md-11 text-end">
                                <a href="orders" class="btn btn-cancel me-3 fw-bold">
                                    <i class="fa fa-times me-1"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-save fw-bold">
                                    <i class="fa fa-save me-1"></i> Save
                                </button>
                            </div>
                        </div>
                    </form>
                    
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
