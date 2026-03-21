<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<form method="post">
<input type="hidden" name="action" value="addItem"/>
<input type="hidden" name="poID" value="${poID}"/>

<select name="ingredientID">
<c:forEach var="i" items="${ingredients}">
<option value="${i.ingredientID}">${i.name}</option>
</c:forEach>
</select>

<input name="quantity"/>
<button>Add</button>
</form>