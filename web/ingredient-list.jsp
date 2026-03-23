<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Ingredient</title>
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
            <div class="bg-light rounded p-4">

                <h4>Ingredient List</h4>

                <a href="${pageContext.request.contextPath}/ingredient?action=add"
                   class="btn btn-primary mb-3">
                    Add
                </a>

                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Stock</th>
                        <th>Unit</th>
                        <th>Supplier</th>
                        <th>Action</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="i" items="${list}">
                        <tr>
                            <td>${i.ingredientID}</td>
                            <td>${i.name}</td>
                            <td>${i.stockQuantity}</td>
                            <td>${i.unitName}</td>
                            <td>${i.supplierName}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/ingredient?action=edit&id=${i.ingredientID}"
                                   class="btn btn-warning btn-sm">
                                    Edit
                                </a>

                                <a href="${pageContext.request.contextPath}/ingredient?action=delete&id=${i.ingredientID}"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Delete this ingredient?')">
                                    Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

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