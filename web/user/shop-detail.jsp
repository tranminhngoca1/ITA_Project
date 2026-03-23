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
    <title>Shop Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Heebo', sans-serif; background: #F3F6F9; margin: 0; }

        .user-sidebar {
            position: fixed; top: 0; left: 0; bottom: 0; width: 240px;
            background: #fff; border-right: 1px solid #e8ecf0; z-index: 999;
        }
        .sidebar-brand { padding: 22px 24px 18px; border-bottom: 1px solid #e8ecf0; }
        .sidebar-brand h4 { color: #009CFF; font-weight: 700; margin: 0; font-size: 17px; }
        .sidebar-nav { padding: 12px 0; }
        .sidebar-nav a {
            display: flex; align-items: center; gap: 10px;
            padding: 11px 24px; color: #555; font-size: 14px; font-weight: 500;
            text-decoration: none; border-left: 3px solid transparent; transition: all 0.2s;
        }
        .sidebar-nav a:hover, .sidebar-nav a.active { color: #009CFF; background: #f0f8ff; border-left-color: #009CFF; }
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

        .breadcrumb-bar { display: flex; align-items: center; gap: 8px; margin-bottom: 20px; font-size: 13px; color: #888; }
        .breadcrumb-bar a { color: #009CFF; text-decoration: none; }
        .breadcrumb-bar a:hover { text-decoration: underline; }

        .detail-card { background: #fff; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.06); overflow: hidden; }
        .detail-card-header {
            padding: 18px 24px; border-bottom: 1px solid #f0f0f0;
            display: flex; align-items: center; justify-content: space-between;
        }
        .detail-card-header h5 { margin: 0; font-size: 16px; font-weight: 700; color: #191C24; }

        .detail-body { padding: 28px 24px; }

        .shop-image-wrap {
            width: 100%; height: 200px; background: #f3f6f9; border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            margin-bottom: 24px; overflow: hidden;
        }
        .shop-image-wrap img { width: 100%; height: 100%; object-fit: cover; border-radius: 10px; }
        .shop-image-wrap i { font-size: 48px; color: #ccc; }

        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .info-item label { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; color: #888; display: block; margin-bottom: 4px; }
        .info-item p { font-size: 14px; color: #333; margin: 0; font-weight: 500; }

        .badge-active { background: #e6f9f0; color: #1a7a4a; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .badge-inactive { background: #fef2f2; color: #b91c1c; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; }

        .btn-back {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 9px 18px; background: #f3f6f9; color: #444;
            border: 1px solid #dee2e6; border-radius: 8px; font-size: 13px;
            font-weight: 600; text-decoration: none; transition: background 0.2s;
        }
        .btn-back:hover { background: #e2e8f0; color: #333; }

        .btn-edit-link {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 9px 18px; background: #009CFF; color: #fff;
            border: none; border-radius: 8px; font-size: 13px;
            font-weight: 600; text-decoration: none; transition: background 0.2s;
        }
        .btn-edit-link:hover { background: #007ecc; color: #fff; }
    </style>
</head>
<body>

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

<div class="main-content">
    <div class="topbar">
        <div class="user-info">
            <div class="avatar"><i class="fa fa-user"></i></div>
            <span><%=loggedInUser.getFullName() != null ? loggedInUser.getFullName() : "Name"%></span>
        </div>
    </div>

    <div class="content-area">
        <div class="breadcrumb-bar">
            <a href="<%=request.getContextPath()%>/user/shoplist"><i class="fa fa-store me-1"></i>Shop List</a>
            <i class="fa fa-chevron-right" style="font-size:10px"></i>
            <span>Shop Details</span>
        </div>

        <c:choose>
            <c:when test="${shop != null}">
                <div class="detail-card">
                    <div class="detail-card-header">
                        <h5><i class="fa fa-store me-2" style="color:#009CFF"></i>${shop.shopName}</h5>
                        <div style="display:flex;gap:8px;">
                            <a href="<%=request.getContextPath()%>/user/shoplist" class="btn-back">
                                <i class="fa fa-arrow-left"></i> Back
                            </a>
                            <a href="<%=request.getContextPath()%>/user/shoplist?action=edit&id=${shop.shopID}" class="btn-edit-link">
                                <i class="fa fa-pen"></i> Edit
                            </a>
                        </div>
                    </div>
                    <div class="detail-body">
                        <div class="shop-image-wrap">
                            <c:choose>
                                <c:when test="${not empty shop.shopImage}">
                                    <img src="${shop.shopImage}" alt="${shop.shopName}">
                                </c:when>
                                <c:otherwise>
                                    <i class="fa fa-store"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="info-grid">
                            <div class="info-item">
                                <label>Shop Name</label>
                                <p>${shop.shopName}</p>
                            </div>
                            <div class="info-item">
                                <label>Status</label>
                                <p>
                                    <c:choose>
                                        <c:when test="${shop.active}"><span class="badge-active">Active</span></c:when>
                                        <c:otherwise><span class="badge-inactive">Inactive</span></c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                            <div class="info-item">
                                <label>Address</label>
                                <p>${not empty shop.address ? shop.address : '-'}</p>
                            </div>
                            <div class="info-item">
                                <label>Phone</label>
                                <p>${not empty shop.phone ? shop.phone : '-'}</p>
                            </div>
                            <div class="info-item">
                                <label>Owner</label>
                                <p>${not empty shop.ownerName ? shop.ownerName : '-'}</p>
                            </div>
                            <div class="info-item">
                                <label>Created At</label>
                                <p>${shop.createdAt != null ? shop.createdAt : '-'}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div style="text-align:center;padding:60px;color:#aaa;">
                    <i class="fa fa-exclamation-circle" style="font-size:40px;display:block;margin-bottom:12px;"></i>
                    Shop not found.
                    <br><br>
                    <a href="<%=request.getContextPath()%>/user/shoplist" class="btn-back">← Back to Shop List</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
