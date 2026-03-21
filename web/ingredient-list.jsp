<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h2>Ingredient List</h2>
<a href="ingredient?action=add">Add</a>
<table border="1">
<tr><th>Name</th><th>Stock</th></tr>
<c:forEach var="i" items="${list}">
<tr>
<td>${i.name}</td>
<td>${i.stockQuantity}</td>
</tr>
</c:forEach>
</table>