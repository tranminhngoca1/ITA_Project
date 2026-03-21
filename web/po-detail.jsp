<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h2>PO Detail</h2>

<a href="po?action=addItem&poID=${poID}">Add Item</a>

<table border="1">
<tr><th>Name</th><th>Qty</th></tr>
<c:forEach var="d" items="${details}">
<tr>
<td>${d.ingredientName}</td>
<td>${d.quantity}</td>
</tr>
</c:forEach>
</table>
