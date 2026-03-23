<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Edit Ingredient</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

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

                        <h4>Edit Ingredient</h4>

                        <form action="${pageContext.request.contextPath}/ingredient" method="post">

                            <input type="hidden" name="action" value="update"/>
                            <input type="hidden" name="id" value="${ingredient.ingredientID}"/>

                            <input name="name"
                                   value="${ingredient.name}"
                                   class="form-control mb-2"
                                   required/>

                            <input name="stockQuantity"
                                   type="number"
                                   step="0.01"
                                   min="0"
                                   value="${ingredient.stockQuantity}"
                                   class="form-control mb-2"
                                   required/>

                            <input name="unitID"
                                   type="number"
                                   value="${ingredient.unitID}"
                                   class="form-control mb-2"
                                   required/>

                            <input name="supplierID"
                                   type="number"
                                   value="${ingredient.supplierID}"
                                   class="form-control mb-2"
                                   required/>

                            <button type="submit" class="btn btn-success">
                                Update
                            </button>

                            <a href="${pageContext.request.contextPath}/ingredient?action=list"
                               class="btn btn-secondary">
                                Back
                            </a>

                        </form>

                    </div>
                </div>

                <%@ include file="includes/footer.jsp" %>

            </div>
        </div>

        <script src="js/main.js"></script>
    </body>
</html>