<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Issue (Xuất kho)</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid position-relative bg-white d-flex p-0">
        <%@ include file="includes/sidebar.jsp" %>
        <div class="content">
            <%@ include file="includes/navbar.jsp" %>
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">Issue (Xuất kho)</h6>
                    </div>
                    <form action="issue" method="post" class="mb-4">
                        <div class="row align-items-center text-start">
                            <div class="col-md-5">
                                <label class="form-label">Chọn nguyên liệu</label>
                                <select name="ingredientID" class="form-select">
                                    <c:forEach var="i" items="${ingredients}">
                                    <option value="${i.ingredientID}">${i.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-5">
                                <label class="form-label">Số lượng</label>
                                <input type="number" step="0.1" name="quantity" class="form-control" required/>
                            </div>
                            <div class="col-md-2 mt-4">
                                <button class="btn btn-primary w-100">Issue</button>
                            </div>
                        </div>
                    </form>
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col">Name</th>
                                    <th scope="col">Qty</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="i" items="${list}">
                                <tr>
                                    <td>${i.ingredientName}</td>
                                    <td>${i.quantity}</td>
                                </tr>
                                </c:forEach>
                                <c:if test="${empty list}">
                                    <tr>
                                        <td colspan="2" class="text-center">Chưa có dữ liệu</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <%@ include file="includes/footer.jsp" %>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>