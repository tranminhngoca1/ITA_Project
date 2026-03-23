<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    model.User u = (model.User) session.getAttribute("loggedInUser");
    String avatarUrl = u.getAvatarUrl() != null && !u.getAvatarUrl().isEmpty() ? u.getAvatarUrl() : "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
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
        .topbar-avatar {
            width: 34px; height: 34px; border-radius: 50%; object-fit: cover;
            background: #009CFF; display: flex; align-items: center; justify-content: center;
            color: #fff; font-size: 14px; flex-shrink: 0;
        }

        .content-area { padding: 24px 28px; }
        .page-title { font-size: 20px; font-weight: 700; color: #191C24; margin-bottom: 22px; }

        .alert-success {
            background: #f0fff4; color: #276749; border: 1px solid #c6f6d5;
            padding: 11px 16px; border-radius: 8px; margin-bottom: 18px; font-size: 13px;
            display: flex; align-items: center; gap: 8px;
        }
        .alert-error {
            background: #fff0f0; color: #721c24; border: 1px solid #f5c6cb;
            padding: 11px 16px; border-radius: 8px; margin-bottom: 18px; font-size: 13px;
            display: flex; align-items: center; gap: 8px;
        }

        .profile-card { background: #fff; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.06); overflow: hidden; }
        .profile-card-header {
            padding: 18px 24px; border-bottom: 1px solid #f0f0f0;
            font-size: 15px; font-weight: 700; color: #191C24;
            display: flex; align-items: center; gap: 8px;
        }
        .profile-body { padding: 28px 24px; display: grid; grid-template-columns: 1fr 280px; gap: 48px; }

        /* Form fields */
        .form-group { margin-bottom: 18px; }
        .form-group label {
            display: block; font-size: 12px; font-weight: 700;
            text-transform: uppercase; letter-spacing: 0.5px; color: #666; margin-bottom: 6px;
        }
        .form-group input[type="text"],
        .form-group input[type="tel"],
        .form-group input[type="email"],
        .form-group textarea {
            width: 100%; height: 42px; padding: 0 12px;
            border: 1px solid #dee2e6; border-radius: 8px;
            font-size: 13px; font-family: 'Heebo', sans-serif;
            outline: none; transition: border-color 0.2s; color: #333; box-sizing: border-box;
        }
        .form-group textarea { height: 90px; padding: 10px 12px; resize: vertical; }
        .form-group input:focus, .form-group textarea:focus { border-color: #009CFF; box-shadow: 0 0 0 3px rgba(0,156,255,0.08); }
        .form-group input[disabled] { background: #f8f9fa; color: #999; cursor: not-allowed; }
        .field-error { font-size: 11px; color: #dc2626; margin-top: 4px; display: none; }

        .radio-group { display: flex; gap: 24px; margin-top: 4px; }
        .radio-group label {
            display: flex; align-items: center; gap: 7px;
            font-size: 13px; font-weight: 500; color: #444;
            text-transform: none; letter-spacing: 0; cursor: pointer;
        }
        .radio-group input[type="radio"] { width: 16px; height: 16px; accent-color: #009CFF; cursor: pointer; }

        /* Avatar panel */
        .avatar-panel { display: flex; flex-direction: column; align-items: center; gap: 14px; padding-top: 4px; }

        .avatar-wrap { position: relative; width: 140px; height: 140px; }
        .avatar-circle {
            width: 140px; height: 140px; border-radius: 50%;
            border: 3px solid #e8ecf0; object-fit: cover; background: #f3f6f9;
            display: flex; align-items: center; justify-content: center; overflow: hidden;
        }
        .avatar-circle img { width: 100%; height: 100%; object-fit: cover; border-radius: 50%; }
        .avatar-circle i { font-size: 52px; color: #ccc; }

        .avatar-overlay {
            position: absolute; bottom: 4px; right: 4px;
            width: 32px; height: 32px; background: #009CFF; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            cursor: pointer; box-shadow: 0 2px 6px rgba(0,0,0,0.2);
            transition: background 0.2s;
        }
        .avatar-overlay:hover { background: #007ecc; }
        .avatar-overlay i { color: #fff; font-size: 13px; }

        .avatar-name { font-size: 15px; font-weight: 700; color: #191C24; text-align: center; }
        .avatar-role { font-size: 12px; color: #888; text-align: center; margin-top: -8px; }

        .upload-hint { font-size: 11px; color: #aaa; text-align: center; line-height: 1.5; }

        .file-name-display {
            font-size: 12px; color: #555; text-align: center;
            background: #f3f6f9; border-radius: 6px; padding: 6px 10px;
            width: 100%; box-sizing: border-box; word-break: break-all;
            display: none;
        }

        /* Actions */
        .form-actions { display: flex; gap: 10px; padding-top: 10px; }
        .btn-save {
            display: inline-flex; align-items: center; gap: 7px;
            padding: 10px 24px; background: #009CFF; color: #fff;
            border: none; border-radius: 8px; font-size: 14px; font-weight: 600;
            font-family: 'Heebo', sans-serif; cursor: pointer; transition: background 0.2s;
        }
        .btn-save:hover { background: #007ecc; }
        .btn-save:disabled { background: #a0d4f5; cursor: not-allowed; }
        .btn-cancel {
            display: inline-flex; align-items: center; gap: 7px;
            padding: 10px 18px; background: #f3f6f9; color: #555;
            border: 1px solid #dee2e6; border-radius: 8px; font-size: 14px; font-weight: 600;
            font-family: 'Heebo', sans-serif; text-decoration: none; transition: background 0.2s;
        }
        .btn-cancel:hover { background: #e2e8f0; color: #333; }

        @media (max-width: 860px) {
            .profile-body { grid-template-columns: 1fr; }
            .avatar-panel { flex-direction: row; flex-wrap: wrap; justify-content: center; }
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="user-sidebar">
    <div class="sidebar-brand">
        <h4><i class="fa fa-user-circle me-2"></i>User Panel</h4>
    </div>
    <div class="sidebar-nav">
        <a href="<%=request.getContextPath()%>/user/shoplist">
            <i class="fa fa-store"></i> View Shop List
        </a>
        <a href="<%=request.getContextPath()%>/user/profile" class="active">
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
            <% if (!avatarUrl.isEmpty()) { %>
                <img src="<%=avatarUrl%>" class="topbar-avatar" alt="avatar"
                     onerror="this.outerHTML='<div class=\'topbar-avatar\'><i class=\'fa fa-user\'></i></div>'">
            <% } else { %>
                <div class="topbar-avatar"><i class="fa fa-user"></i></div>
            <% } %>
            <span><%=u.getFullName() != null ? u.getFullName() : "Name"%></span>
        </div>
    </div>

    <div class="content-area">
        <div class="page-title">Edit Profile</div>

        <% if ("1".equals(request.getParameter("success"))) { %>
        <div class="alert-success"><i class="fa fa-check-circle"></i> Profile updated successfully!</div>
        <% } %>
        <c:if test="${not empty error}">
            <div class="alert-error"><i class="fa fa-exclamation-circle"></i> ${error}</div>
        </c:if>

        <div class="profile-card">
            <div class="profile-card-header">
                <i class="fa fa-user-edit" style="color:#009CFF"></i> Edit Profile
            </div>
            <div class="profile-body">

                <!-- Left: Form -->
                <form method="post" action="<%=request.getContextPath()%>/user/profile"
                      enctype="multipart/form-data" id="profileForm" novalidate>

                    <div class="form-group">
                        <label>Full Name <span style="color:red">*</span></label>
                        <input type="text" name="fullName" id="fullName"
                               value="<%=u.getFullName() != null ? u.getFullName() : ""%>"
                               placeholder="Enter full name">
                        <div class="field-error" id="fullNameErr">Full name is required.</div>
                    </div>

                    <div class="form-group">
                        <label>Gender</label>
                        <div class="radio-group">
                            <label>
                                <input type="radio" name="gender" value="Nam"
                                    <%="Nam".equals(u.getGender()) ? "checked" : ""%>> Male
                            </label>
                            <label>
                                <input type="radio" name="gender" value="Nữ"
                                    <%="Nữ".equals(u.getGender()) ? "checked" : ""%>> Female
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="tel" name="phone" id="phone"
                               value="<%=u.getPhone() != null ? u.getPhone() : ""%>"
                               placeholder="Enter phone number">
                        <div class="field-error" id="phoneErr">Phone must be 10–11 digits.</div>
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" value="<%=u.getEmail() != null ? u.getEmail() : ""%>" disabled>
                    </div>

                    <div class="form-group">
                        <label>Role</label>
                        <input type="text" value="<%=u.getRoleName() != null ? u.getRoleName() : ""%>" disabled>
                    </div>

                    <div class="form-group">
                        <label>Address</label>
                        <textarea name="address" placeholder="Enter address"><%=u.getAddress() != null ? u.getAddress() : ""%></textarea>
                    </div>

                    <!-- Hidden file input synced from avatar panel click -->
                    <input type="file" name="avatarFile" id="avatarFileInput"
                           accept="image/jpeg,image/png,image/gif,image/webp" style="display:none">

                    <div class="form-actions">
                        <a href="<%=request.getContextPath()%>/user/shoplist" class="btn-cancel">
                            <i class="fa fa-times"></i> Cancel
                        </a>
                        <button type="submit" class="btn-save" id="saveBtn">
                            <i class="fa fa-save"></i> Save Changes
                        </button>
                    </div>
                </form>

                <!-- Right: Avatar -->
                <div class="avatar-panel">
                    <div class="avatar-wrap">
                        <div class="avatar-circle" id="avatarCircle">
                            <% if (!avatarUrl.isEmpty()) { %>
                                <img src="<%=avatarUrl%>" id="avatarImg" alt="Avatar"
                                     onerror="this.parentElement.innerHTML='<i class=\'fa fa-user\'></i>'">
                            <% } else { %>
                                <i class="fa fa-user" id="avatarIcon"></i>
                            <% } %>
                        </div>
                        <div class="avatar-overlay" onclick="document.getElementById('avatarFileInput').click()" title="Change avatar">
                            <i class="fa fa-camera"></i>
                        </div>
                    </div>

                    <div class="avatar-name" id="displayName"><%=u.getFullName() != null ? u.getFullName() : ""%></div>
                    <div class="avatar-role"><%=u.getRoleName() != null ? u.getRoleName() : ""%></div>

                    <div class="upload-hint">
                        Click the camera icon to upload<br>
                        JPG, PNG, GIF, WEBP &bull; Max 5MB
                    </div>

                    <div class="file-name-display" id="fileNameDisplay"></div>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const fileInput      = document.getElementById('avatarFileInput');
    const avatarCircle   = document.getElementById('avatarCircle');
    const fileNameDisplay = document.getElementById('fileNameDisplay');
    const fullNameInput  = document.getElementById('fullName');
    const displayName    = document.getElementById('displayName');

    // Live preview when file selected
    fileInput.addEventListener('change', function () {
        const file = this.files[0];
        if (!file) return;

        if (file.size > 5 * 1024 * 1024) {
            alert('File size exceeds 5MB. Please choose a smaller image.');
            this.value = '';
            return;
        }

        const reader = new FileReader();
        reader.onload = function (e) {
            avatarCircle.innerHTML = '<img src="' + e.target.result + '" alt="Avatar" style="width:100%;height:100%;object-fit:cover;border-radius:50%">';
        };
        reader.readAsDataURL(file);

        fileNameDisplay.textContent = file.name;
        fileNameDisplay.style.display = 'block';
    });

    // Sync full name to avatar display name
    fullNameInput.addEventListener('input', function () {
        displayName.textContent = this.value;
    });

    // Client-side validation
    document.getElementById('profileForm').addEventListener('submit', function (e) {
        let valid = true;

        const name = fullNameInput.value.trim();
        const nameErr = document.getElementById('fullNameErr');
        if (!name) {
            nameErr.style.display = 'block';
            fullNameInput.style.borderColor = '#dc2626';
            valid = false;
        } else {
            nameErr.style.display = 'none';
            fullNameInput.style.borderColor = '';
        }

        const phone = document.getElementById('phone').value.trim();
        const phoneErr = document.getElementById('phoneErr');
        if (phone && !/^\d{10,11}$/.test(phone)) {
            phoneErr.style.display = 'block';
            document.getElementById('phone').style.borderColor = '#dc2626';
            valid = false;
        } else {
            phoneErr.style.display = 'none';
            document.getElementById('phone').style.borderColor = '';
        }

        if (!valid) e.preventDefault();
    });
</script>
</body>
</html>
