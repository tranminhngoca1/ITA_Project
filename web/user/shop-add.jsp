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
    <title>Add New Shop</title>
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

        .form-card { background: #fff; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.06); overflow: hidden; max-width: 640px; }
        .form-card-header { padding: 18px 24px; border-bottom: 1px solid #f0f0f0; }
        .form-card-header h5 { margin: 0; font-size: 16px; font-weight: 700; color: #191C24; }
        .form-body { padding: 28px 24px; }

        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 13px; font-weight: 600; color: #444; margin-bottom: 6px; }
        .form-group input, .form-group textarea {
            width: 100%; height: 42px; padding: 0 12px;
            border: 1px solid #dee2e6; border-radius: 8px;
            font-size: 13px; font-family: 'Heebo', sans-serif;
            outline: none; transition: border-color 0.2s; color: #333;
        }
        .form-group textarea { height: 80px; padding: 10px 12px; resize: vertical; }
        .form-group input:focus, .form-group textarea:focus { border-color: #009CFF; }

        .form-actions { display: flex; gap: 10px; padding-top: 8px; }
        .btn-save {
            padding: 10px 24px; background: #009CFF; color: #fff;
            border: none; border-radius: 8px; font-size: 14px; font-weight: 600;
            font-family: 'Heebo', sans-serif; cursor: pointer; transition: background 0.2s;
        }
        .btn-save:hover { background: #007ecc; }
        .btn-cancel {
            padding: 10px 20px; background: #f3f6f9; color: #444;
            border: 1px solid #dee2e6; border-radius: 8px; font-size: 14px; font-weight: 600;
            font-family: 'Heebo', sans-serif; cursor: pointer; text-decoration: none;
            display: inline-flex; align-items: center; transition: background 0.2s;
        }
        .btn-cancel:hover { background: #e2e8f0; color: #333; }
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
            <span>Add New Shop</span>
        </div>

        <div class="form-card">
            <div class="form-card-header">
                <h5><i class="fa fa-plus-circle me-2" style="color:#009CFF"></i>Add New Shop</h5>
            </div>
            <div class="form-body">
                <form method="post" action="<%=request.getContextPath()%>/user/shoplist">
                    <input type="hidden" name="action" value="add">

                    <div class="form-group">
                        <label>Shop Name <span style="color:red">*</span></label>
                        <input type="text" name="shopName" placeholder="Enter shop name" required>
                    </div>
                    <div class="form-group">
                        <label>Address</label>
                        <textarea name="address" placeholder="Enter address"></textarea>
                    </div>
                    <div class="form-group">
                        <label>Phone</label>
                        <input type="text" name="phone" placeholder="Enter phone number">
                    </div>
                    <div class="form-group">
                        <label>Shop Image URL</label>
                        <input type="text" name="shopImage" placeholder="https://...">
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn-save"><i class="fa fa-plus me-1"></i>Add Shop</button>
                        <a href="<%=request.getContextPath()%>/user/shoplist" class="btn-cancel">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
