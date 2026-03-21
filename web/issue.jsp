<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h2>Issue (Xuất kho)</h2>

<form method="post">
<select name="ingredientID">
<c:forEach var="i" items="${ingredients}">
<option value="${i.ingredientID}">${i.name}</option>
</c:forEach>
</select>

<input name="quantity"/>
<button>Issue</button>
</form>

<table border="1">
<tr><th>Name</th><th>Qty</th></tr>
<c:forEach var="i" items="${list}">
<tr>
<td>${i.ingredientName}</td>
<td>${i.quantity}</td>
</tr>
</c:forEach>
</table>