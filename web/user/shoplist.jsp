<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    model.User loggedInUser = (model.User) session.getAttribute("loggedInUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Shop List</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Heebo', sans-serif; background: #F3F6F9; margin: 0; }

        .user-sidebar {
            position: fixed; top: 0; left: 0; bottom: 0; width: 240px;
            background: #fff; border-right: 1px solid #e8ecf0; z-index: 999; padding: 0;
        }
        .sidebar-brand {
            padding: 22px 24px 18px;
            border-bottom: 1px solid #e8ecf0;
        }
        .sidebar-brand h4 { color: #009CFF; font-weight: 700; margin: 0; font-size: 17px; }
        .sidebar-nav { padding: 12px 0; }
        .sidebar-nav a {
            display: flex; align-items: center; gap: 10px;
            padding: 11px 24px; color: #555; font-size: 14px; font-weight: 500;
            text-decoration: none; border-left: 3px solid transparent;
            transition: all 0.2s;
        }
        .sidebar-nav a:hover { color: #009CFF; background: #f0f8ff; border-left-color: #009CFF; }
        .sidebar-nav a.active { color: #009CFF; background: #f0f8ff; border-left-color: #009CFF; font-weight: 600; }
        .sidebar-nav a i { width: 18px; text-align: center; }

        .main-content { margin-left: 240px; min-height: 100vh; }

        .topbar {
            background: #fff; padding: 13px 28px;
            display: flex; align-items: center; justify-content: flex-end;
            border-bottom: 1px solid #e8ecf0; position: sticky; top: 0; z-index: 100;
        }
        .topbar .user-info { display: flex; align-items: center; gap: 10px; font-size: 14px; font-weight: 500; color: #333; }
        .topbar .avatar {
            width: 34px; height: 34px; background: #009CFF; border-radius: 50%;
            display: flex; align-items: center; justify-content: center; color: #fff; font-size: 14px;
        }

        .content-area { padding: 24px 28px; }

        .page-title { font-size: 20px; font-weight: 700; color: #191C24; margin-bottom: 20px; }

        .toolbar {
            display: flex; align-items: center; gap: 10px;
            margin-bottom: 18px; flex-wrap: wrap;
        }
        .search-box {
            display: flex; align-items: center; background: #fff;
            border: 1px solid #dee2e6; border-radius: 8px; padding: 0 12px;
            height: 40px; flex: 1; min-width: 200px; max-width: 320px;
        }
        .search-box input { border: none; outline: none; font-size: 13px; width: 100%; font-family: 'Heebo', sans-serif; }
        .search-box i { color: #aaa; font-size: 13px; margin-right: 6px; }

        .filter-select {
            height: 40px; border: 1px solid #dee2e6; border-radius: 8px;
            padding: 0 12px; font-size: 13px; font-family: 'Heebo', sans-serif;
            background: #fff; outline: none; cursor: pointer; color: #444;
        }
        .btn-search {
            height: 40px; padding: 0 16px; background: #6c757d; color: #fff;
            border: none; border-radius: 8px; font-size: 13px; font-weight: 600;
            font-family: 'Heebo', sans-serif; cursor: pointer; transition: background 0.2s;
        }
        .btn-search:hover { background: #5a6268; }
        .btn-add {
            margin-left: auto; height: 40px; padding: 0 18px; background: #009CFF;
            color: #fff; border: none; border-radius: 8px; font-size: 13px; font-weight: 600;
            font-family: 'Heebo', sans-serif; cursor: pointer; display: flex; align-items: center;
            gap: 6px; text-decoration: none; transition: background 0.2s;
        }
        .btn-add:hover { background: #007ecc; color: #fff; }

        .alert-success {
            background: #f0fff4; color: #276749; border: 1px solid #c6f6d5;
            padding: 10px 16px; border-radius: 8px; margin-bottom: 16px; font-size: 13px;
        }
        .alert-error {
            background: #fff0f0; color: #721c24; border: 1px solid #f5c6cb;
            padding: 10px 16px; border-radius: 8px; margin-bottom: 16px; font-size: 13px;
        }

        .table-card { background: #fff; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.06); overflow: hidden; }
        .table-card-header {
            padding: 16px 22px; border-bottom: 1px solid #f0f0f0;
            font-size: 15px; font-weight: 700; color: #191C24;
            display: flex; align-items: center; justify-content: space-between;
        }
        .table-card-header span { font-size: 13px; color: #888; font-weight: 400; }

        table { width: 100%; border-collapse: collapse; }
        thead th {
            background: #F3F6F9; font-size: 11px; font-weight: 700;
            text-transform: uppercase; letter-spacing: 0.6px; color: #666;
            padding: 12px 18px; border: none; white-space: nowrap;
        }
        tbody td { padding: 14px 18px; font-size: 13px; color: #333; border-bottom: 1px solid #f5f5f5; vertical-align: middle; }
        tbody tr:last-child td { border-bottom: none; }
        tbody tr:hover { background: #fafbfc; }

        .badge-active { background: #e6f9f0; color: #1a7a4a; padding: 4px 10px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .badge-inactive { background: #fef2f2; color: #b91c1c; padding: 4px 10px; border-radius: 20px; font-size: 12px; font-weight: 600; }

        .action-btn {
            width: 32px; height: 32px; border: none; border-radius: 6px; cursor: pointer;
            display: inline-flex; align-items: center; justify-content: center;
            font-size: 13px; transition: opacity 0.2s; margin-right: 3px; text-decoration: none;
        }
        .action-btn:hover { opacity: 0.75; }
        .btn-view  { background: #e8f4fd; color: #009CFF; }
        .btn-edit  { background: #fff8e1; color: #f59e0b; }

        .empty-state { text-align: center; padding: 48px 20px; color: #aaa; }
        .empty-state i { font-size: 40px; margin-bottom: 12px; display: block; }

        .pagination-wrap { display: flex; justify-content: flex-end; padding: 14px 18px; border-top: 1px solid #f0f0f0; gap: 5px; }
        .page-btn {
            width: 32px; height: 32px; border: 1px solid #dee2e6; border-radius: 6px;
            background: #fff; font-size: 13px; cursor: pointer;
            display: inline-flex; align-items: center; justify-content: center; color: #444; transition: all 0.2s;
        }
        .page-btn:hover, .page-btn.active { background: #009CFF; color: #fff; border-color: #009CFF; }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="user-sidebar">
    <div class="sidebar-brand">
        <h4><i class="fa fa-user-circle me-2"></i>User Panel</h4>
    </div>
    <div class="sidebar-nav">
        <a href="<%=request.getContextPath()%>/user/shoplist" class="active">
            <i class="fa fa-store"></i> View Shop List
        </a>
        <a href="<%=request.getContextPath()%>/user/profile">
            <i class="fa fa-user-edit"></i> Edit Profile
        </a>
        <a href="<%=request.getContextPath()%>/logout">
            <i class="fa fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>

<!-- Main -->
<div class="main-content">
    <div class="topbar">
        <div class="user-info">
            <div class="avatar"><i class="fa fa-user"></i></div>
            <span><%=loggedInUser.getFullName() != null ? loggedInUser.getFullName() : "Name"%></span>
        </div>
    </div>

    <div class="content-area">
        <div class="page-title">My Coffee Shops</div>

        <c:if test="${param.success == 'added'}">
            <div class="alert-success"><i class="fa fa-check-circle me-2"></i>Shop added successfully!</div>
        </c:if>
        <c:if test="${param.success == 'updated'}">
            <div class="alert-success"><i class="fa fa-check-circle me-2"></i>Shop updated successfully!</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert-error"><i class="fa fa-exclamation-circle me-2"></i>${error}</div>
        </c:if>

        <!-- Toolbar -->
        <form method="get" action="<%=request.getContextPath()%>/user/shoplist">
            <div class="toolbar">
                <div class="search-box">
                    <i class="fa fa-search"></i>
                    <input type="text" name="keyword" placeholder="Search by name, address..."
                           value="${keyword != null ? keyword : ''}">
                </div>
                <select name="status" class="filter-select">
                    <option value="">All Status</option>
                    <option value="active"   ${status == 'active'   ? 'selected' : ''}>Active</option>
                    <option value="inactive" ${status == 'inactive' ? 'selected' : ''}>Inactive</option>
                </select>
                <button type="submit" class="btn-search"><i class="fa fa-search me-1"></i>Search</button>
                <a href="<%=request.getContextPath()%>/user/shoplist?action=add" class="btn-add">
                    <i class="fa fa-plus"></i> Add New Shop
                </a>
            </div>
        </form>

        <!-- Table -->
        <div class="table-card">
            <div class="table-card-header">
                My Coffee Shops
                <span>${shops != null ? shops.size() : 0} shops found</span>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Shop Name</th>
                        <th>Address</th>
                        <th>Phone</th>
                        <th>Owner</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty shops}">
                            <c:forEach var="shop" items="${shops}" varStatus="st">
                            <tr>
                                <td>${st.index + 1}</td>
                                <td><strong>${shop.shopName}</strong></td>
                                <td>${shop.address}</td>
                                <td>${shop.phone != null ? shop.phone : '-'}</td>
                                <td>${shop.ownerName != null ? shop.ownerName : '-'}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${shop.active}">
                                            <span class="badge-active">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-inactive">Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="<%=request.getContextPath()%>/user/shoplist?action=detail&id=${shop.shopID}"
                                       class="action-btn btn-view" title="View Details">
                                        <i class="fa fa-eye"></i>
                                    </a>
                                    <a href="<%=request.getContextPath()%>/user/shoplist?action=edit&id=${shop.shopID}"
                                       class="action-btn btn-edit" title="Edit">
                                        <i class="fa fa-pen"></i>
                                    </a>
                                </td>
                            </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7">
                                    <div class="empty-state">
                                        <i class="fa fa-store-slash"></i>
                                        No shops found.
                                    </div>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            <div class="pagination-wrap">
                <button class="page-btn"><i class="fa fa-chevron-left"></i></button>
                <button class="page-btn active">1</button>
                <button class="page-btn">2</button>
                <button class="page-btn"><i class="fa fa-chevron-right"></i></button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
