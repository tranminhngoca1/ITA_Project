<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Setting List - CoffeeLux</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="img/favicon.ico" rel="icon">
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
    <div class="container-xxl position-relative bg-white d-flex p-0">
        <!-- Sidebar -->
        <jsp:include page="includes/sidebar.jsp" />

        <!-- Content -->
        <div class="content">
            <!-- Navbar -->
            <jsp:include page="includes/navbar.jsp" />

            <!-- Setting List -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">Setting List</h6>
                        <a href="${pageContext.request.contextPath}/settings?action=add" class="btn btn-sm btn-primary">
                            <i class="fa fa-plus me-2"></i>Add New Setting
                        </a>
                    </div>

                    <!-- Filter Form -->
                    <form method="get" action="${pageContext.request.contextPath}/settings" class="mb-4">
                        <input type="hidden" name="action" value="list">
                        <div class="row g-3">
                            <div class="col-md-3">
                                <input type="text" name="name" class="form-control" 
                                       placeholder="Search by name..." 
                                       value="${selectedName != null ? selectedName : ''}">
                            </div>
                            <div class="col-md-3">
                                <select name="type" class="form-select">
                                    <option value="all">All Types</option>
                                    <c:forEach var="t" items="${types}">
                                        <option value="${t}" ${selectedType == t ? 'selected' : ''}>${t}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <select name="status" class="form-select">
                                    <option value="all">All Status</option>
                                    <option value="1" ${selectedStatus == '1' ? 'selected' : ''}>Active</option>
                                    <option value="0" ${selectedStatus == '0' ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fa fa-filter me-2"></i>Filter
                                </button>
                            </div>
                        </div>
                    </form>

                    <!-- Settings Table -->
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col">ID</th>
                                    <th scope="col">Name</th>
                                    <th scope="col">Type</th>
                                    <th scope="col">Value</th>
                                    <th scope="col">Priority</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="setting" items="${settings}">
                                    <tr>
                                        <td>${setting.settingID}</td>
                                        <td>${setting.name}</td>
                                        <td><span class="badge bg-info">${setting.type}</span></td>
                                        <td>${setting.value}</td>
                                        <td>${setting.priority}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${setting.active}">
                                                    <span class="badge bg-success">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/settings?action=edit&id=${setting.settingID}" 
                                               class="btn btn-sm btn-primary">
                                                <i class="fa fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/settings?action=delete&id=${setting.settingID}" 
                                               class="btn btn-sm btn-danger"
                                               onclick="return confirm('Are you sure you want to delete this setting?')">
                                                <i class="fa fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty settings}">
                                    <tr>
                                        <td colspan="7" class="text-center">No settings found</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <jsp:include page="includes/footer.jsp" />
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
