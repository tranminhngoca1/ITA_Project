<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Create Purchase Order</title>
</head>
<body>

<h2>Create Purchase Order</h2>

<form action="${pageContext.request.contextPath}/po" method="post">

    <input type="hidden" name="action" value="create"/>

    <!-- Tạm hardcode vì controller bạn đang dùng (1,1,1) -->
    <p>Shop: Shop 1</p>
    <p>Supplier: Supplier 1</p>

    <button type="submit">Create</button>

</form>

<br>
<a href="${pageContext.request.contextPath}/po">Back to List</a>

</body>
</html>