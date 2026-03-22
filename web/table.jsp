<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Users - DashMin</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid position-relative bg-white d-flex p-0">
        <%@ include file="includes/sidebar.jsp" %>

        <div class="content">
            <%@ include file="includes/navbar.jsp" %>

            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">User List</h6>
                        <a href="#" class="btn btn-sm btn-primary">Add New</a>
                    </div>

                    <!-- Search Filter Form -->
                    <form action="users" method="GET" class="mb-4">
                        <div class="row g-2 align-items-center">
                            <div class="col-auto">
                                <input type="text" name="name" class="form-control form-control-sm" placeholder="Search by Name" value="${searchName}">
                            </div>
                            <div class="col-auto">
                                <select name="status" class="form-select form-select-sm">
                                    <option value="" ${empty searchStatus ? 'selected' : ''}>All Status</option>
                                    <option value="Active" ${searchStatus == 'Active' ? 'selected' : ''}>Active</option>
                                    <option value="Inactive" ${searchStatus == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-sm btn-primary"><i class="bi bi-search"></i> Lọc</button>
                                <a href="users" class="btn btn-sm btn-secondary">Xóa Lọc</a>
                            </div>
                        </div>
                    </form>

                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col">ID</th>
                                    <th scope="col">Tên</th>
                                    <th scope="col">Giới tính</th>
                                    <th scope="col">Email</th>
                                    <th scope="col">Role</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${users}">
                                    <tr>
                                        <td>${user.userID}</td>
                                        <td>${user.fullName}</td>
                                        <td>${user.gender}</td>
                                        <td>${user.email}</td>
                                        <td>${not empty user.roleName ? user.roleName : user.roleID}</td>
                                        <td>
                                            <span class="badge ${user.active ? 'bg-success' : 'bg-danger'}">${user.active ? 'Active' : 'Inactive'}</span>
                                        </td>
                                        <td>
                                            <a class="btn btn-sm btn-outline-primary" href="user?action=edit&id=${user.userID}" title="Chỉnh sửa"><i class="bi bi-pencil"></i></a>
                                            <a class="btn btn-sm btn-outline-info" href="user?action=view&id=${user.userID}" title="Xem"><i class="bi bi-eye"></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty users}">
                                    <tr>
                                        <td colspan="7" class="text-center">Không tìm thấy người dùng</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Page navigation" class="mt-4">
                            <ul class="pagination justify-content-center mb-0">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="users?page=${currentPage - 1}&name=${searchName}&status=${searchStatus}" tabindex="-1">Previous</a>
                                </li>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="users?page=${i}&name=${searchName}&status=${searchStatus}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="users?page=${currentPage + 1}&name=${searchName}&status=${searchStatus}">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>

                </div>
            </div>

            <%@ include file="includes/footer.jsp" %>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
