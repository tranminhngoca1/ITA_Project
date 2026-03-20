# JSP vs HTML trong dự án

## Cấu trúc files:

### JSP Files (Dynamic Content)
- `index.jsp` - Trang chủ với session và dynamic data
- `table.jsp` - Hiển thị danh sách users từ database
- `includes/sidebar.jsp` - Sidebar với session username
- `includes/navbar.jsp` - Navbar với user info
- `includes/footer.jsp` - Footer component

### HTML Files (Static Content)
- `signin.html` - Trang đăng nhập tĩnh
- `signup.html` - Trang đăng ký tĩnh
- `404.html` - Trang lỗi
- `blank.html`, `button.html`, `chart.html`, etc. - Template pages

## Khi nào dùng JSP?
- Cần hiển thị dữ liệu từ database
- Cần sử dụng session (login, user info)
- Cần JSTL tags (forEach, if, choose)
- Cần include components động

## Khi nào dùng HTML?
- Trang tĩnh không cần dữ liệu động
- Landing pages
- Error pages
- Template/demo pages

## Ví dụ sử dụng:

### JSP với JSTL:
```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:forEach var="user" items="${users}">
    <tr>
        <td>${user.username}</td>
        <td>${user.email}</td>
    </tr>
</c:forEach>
```

### JSP với Session:
```jsp
<h6>${sessionScope.username != null ? sessionScope.username : 'Guest'}</h6>
```

## URL Mapping:
- `/` hoặc `/index.jsp` → Trang chủ JSP
- `/users` → Servlet load data → table.jsp
- `/api/user/*` → REST API (JSON response)
- `/signin.html` → Trang login HTML tĩnh
