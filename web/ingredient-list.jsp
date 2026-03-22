<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Ingredient</title>
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
                           class="btn btn-primary mb-3">Add</a>

                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Stock</th>
                                    <th>Unit</th>
                                    <th>Supplier</th>
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
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                    </div>
                </div>

                <%@ include file="includes/footer.jsp" %>

            </div>
        </div>
    </body>
</html>