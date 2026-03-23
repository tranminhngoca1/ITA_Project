<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>User Details - Coffee System</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    
    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <style>
        .profile-header {
            background: linear-gradient(135deg, #009CFF 0%, #006eb3 100%);
            height: 150px;
            border-radius: 10px 10px 0 0;
        }
        .profile-img-container {
            margin-top: -60px;
            text-align: center;
        }
        .profile-img {
            width: 120px;
            height: 120px;
            border: 5px solid #fff;
            object-fit: cover;
            border-radius: 50%;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .info-label {
            font-weight: 600;
            color: #757575;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .info-value {
            font-size: 1.1rem;
            color: #333;
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
            padding-bottom: 5px;
        }
    </style>
</head>
<body>
    <div class="container-fluid position-relative bg-white d-flex p-0">
        <!-- Sidebar Start -->
        <%@ include file="includes/sidebar.jsp" %>
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <%@ include file="includes/navbar.jsp" %>
            <!-- Navbar End -->

            <div class="container-fluid pt-4 px-4">
                <div class="row g-4 justify-content-center">
                    <div class="col-sm-12 col-xl-8">
                        <div class="bg-light rounded h-100 pb-4">
                            <div class="profile-header"></div>
                            <div class="profile-img-container mb-4">
                                <img class="profile-img" src="${not empty user.avatarUrl ? user.avatarUrl : 'img/user.jpg'}" alt="User Profile">
                                <h4 class="mt-2 mb-0">${user.fullName}</h4>
                                <span class="badge bg-primary">${user.roleName}</span>
                            </div>

                            <div class="px-5">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="info-label">Email Address</div>
                                        <div class="info-value">${user.email}</div>
                                        
                                        <div class="info-label">Gender</div>
                                        <div class="info-value">${user.gender}</div>
                                        
                                        <div class="info-label">Created At</div>
                                        <div class="info-value">
                                            <fmt:formatDate value="${user.createdAt}" pattern="dd MMM yyyy, HH:mm"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="info-label">Phone Number</div>
                                        <div class="info-value">${not empty user.phone ? user.phone : 'N/A'}</div>
                                        
                                        <div class="info-label">Address</div>
                                        <div class="info-value">${not empty user.address ? user.address : 'N/A'}</div>
                                        
                                        <div class="info-label">Status</div>
                                        <div class="info-value">
                                            <span class="badge ${user.active ? 'bg-success' : 'bg-danger'}">
                                                ${user.active ? 'Active' : 'Inactive'}
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-center mt-4">
                                    <a href="users" class="btn btn-secondary me-2">Back to List</a>
                                    <a href="user?action=edit&id=${user.userID}" class="btn btn-primary">Edit Profile</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer Start -->
            <%@ include file="includes/footer.jsp" %>
            <!-- Footer End -->
        </div>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
