<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>${setting != null ? 'Edit' : 'Add'} Setting - CoffeeLux</title>
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

            <!-- Setting Form -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-12 col-xl-8">
                        <div class="bg-light rounded h-100 p-4">
                            <h6 class="mb-4">${setting != null ? 'Edit' : 'Add New'} Setting</h6>
                            <form method="post" action="${pageContext.request.contextPath}/settings">
                                <input type="hidden" name="action" value="${setting != null ? 'update' : 'create'}">
                                <c:if test="${setting != null}">
                                    <input type="hidden" name="id" value="${setting.settingID}">
                                </c:if>

                                <div class="mb-3">
                                    <label for="name" class="form-label">Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="name" name="name" 
                                           value="${setting != null ? setting.name : ''}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="type" class="form-label">Type <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="type" name="type" 
                                           value="${setting != null ? setting.type : ''}" 
                                           list="typeList" required>
                                    <datalist id="typeList">
                                        <c:forEach var="t" items="${types}">
                                            <option value="${t}">
                                        </c:forEach>
                                    </datalist>
                                    <small class="form-text text-muted">
                                        Common types: Role, Category, Unit, POStatus, IssueStatus, OrderStatus
                                    </small>
                                </div>

                                <div class="mb-3">
                                    <label for="value" class="form-label">Value <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="value" name="value" 
                                           value="${setting != null ? setting.value : ''}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="priority" class="form-label">Priority <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="priority" name="priority" 
                                           value="${setting != null ? setting.priority : 1}" min="1" required>
                                    <small class="form-text text-muted">Lower number = higher priority</small>
                                </div>

                                <div class="mb-3">
                                    <label for="description" class="form-label">Description</label>
                                    <textarea class="form-control" id="description" name="description" 
                                              rows="3">${setting != null ? setting.description : ''}</textarea>
                                </div>

                                <div class="mb-3 form-check">
                                    <input type="checkbox" class="form-check-input" id="isActive" name="isActive" 
                                           ${setting == null || setting.active ? 'checked' : ''}>
                                    <label class="form-check-label" for="isActive">Active</label>
                                </div>

                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa fa-save me-2"></i>Save
                                    </button>
                                    <a href="${pageContext.request.contextPath}/settings?action=list" 
                                       class="btn btn-secondary">
                                        <i class="fa fa-times me-2"></i>Cancel
                                    </a>
                                </div>
                            </form>
                        </div>
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
