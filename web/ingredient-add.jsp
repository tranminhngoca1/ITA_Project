<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Ingredient</title>

    <!-- 🔥 FIX: dùng contextPath cho CSS -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<div class="container mt-4">

    <h4>Add Ingredient</h4>

    <!-- 🔥 ACTION CHUẨN -->
    <form action="${pageContext.request.contextPath}/ingredient" method="post">

        <input type="hidden" name="action" value="add"/>

        <!-- NAME -->
        <input name="name"
               class="form-control mb-2"
               placeholder="Name"
               required/>

        <!-- STOCK -->
        <input name="stockQuantity"
               type="number"
               step="0.01"
               min="0"
               class="form-control mb-2"
               placeholder="Stock"
               required/>

        <!-- UNIT -->
        <input name="unitID"
               type="number"
               class="form-control mb-2"
               placeholder="UnitID (13=kg)"
               required/>

        <!-- SUPPLIER -->
        <input name="supplierID"
               type="number"
               class="form-control mb-2"
               placeholder="SupplierID (1-5)"
               required/>

        <!-- ACTIVE -->
        <label class="mb-2">
            <input type="checkbox" name="isActive" checked/> Active
        </label>

        <br>

        <button type="submit" class="btn btn-success">Add</button>

        <!-- 🔥 BACK -->
        <a href="${pageContext.request.contextPath}/ingredient?action=list"
           class="btn btn-secondary">Back</a>

    </form>

</div>
</body>
</html>