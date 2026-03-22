<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Purchase Orders</title>
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
                        <h6 class="mb-0">Purchase Orders</h6>
                        <a href="po?action=create" class="btn btn-sm btn-primary">Create PO</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col">ID</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="po" items="${list}">
                                <tr>
                                    <td>${po.poID}</td>
                                    <td>
                                        <span class="badge bg-info">${po.status}</span>
                                    </td>
                                    <td>
                                        <a class="btn btn-sm btn-outline-info" href="po?action=detail&id=${po.poID}"><i class="bi bi-eye"></i> Detail</a>
                                        <a class="btn btn-sm btn-outline-success" href="po?action=receive&id=${po.poID}"><i class="bi bi-check-circle"></i> Receive</a>
                                    </td>
                                </tr>
                                </c:forEach>
                                <c:if test="${empty list}">
                                    <tr>
                                        <td colspan="3" class="text-center">Chưa có dữ liệu</td>
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
