<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h2>Purchase Orders</h2>
<a href="po?action=create">Create PO</a>

<table border="1">
<tr><th>ID</th><th>Status</th><th>Action</th></tr>
<c:forEach var="po" items="${list}">
<tr>
<td>${po.poID}</td>
<td>${po.status}</td>
<td>
<a href="po?action=detail&id=${po.poID}">Detail</a>
<a href="po?action=receive&id=${po.poID}">Receive</a>
</td>
</tr>
</c:forEach>
</table>
