<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("loggedInUser") != null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

    <style>
        body {
            background: #f0f2f5;
            font-family: 'Heebo', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 40px 36px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }

        .login-card h2 {
            text-align: center;
            font-weight: 700;
            margin-bottom: 28px;
            color: #191C24;
        }

        .form-control {
            border-radius: 8px;
            height: 46px;
            font-size: 14px;
        }

        .form-control:focus {
            border-color: #009CFF;
            box-shadow: 0 0 0 0.2rem rgba(0, 156, 255, 0.2);
        }

        .recaptcha-box {
            display: flex;
            align-items: center;
            gap: 10px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 12px 16px;
            background: #f8f9fa;
            margin-bottom: 20px;
        }

        .recaptcha-box input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: #009CFF;
        }

        .recaptcha-box label {
            margin: 0;
            font-size: 14px;
            color: #444;
            cursor: pointer;
        }

        .btn-login {
            background-color: #009CFF;
            color: #fff;
            border: none;
            border-radius: 8px;
            height: 46px;
            font-size: 15px;
            font-weight: 600;
            width: 100%;
            transition: background 0.3s;
        }

        .btn-login:hover {
            background-color: #007ecc;
            color: #fff;
        }

        .btn-google {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            width: 100%;
            height: 46px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            background: #fff;
            font-size: 14px;
            font-weight: 500;
            color: #444;
            cursor: pointer;
            transition: background 0.2s, border-color 0.2s;
            text-decoration: none;
        }

        .btn-google:hover {
            background: #f8f9fa;
            border-color: #bbb;
            color: #222;
        }

        .btn-google img {
            width: 20px;
            height: 20px;
        }

        .divider {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 18px 0;
            color: #aaa;
            font-size: 13px;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #dee2e6;
        }

        .password-reset-link {
            display: block;
            text-align: center;
            margin-top: 16px;
            font-size: 13px;
            color: #009CFF;
            text-decoration: none;
        }

        .password-reset-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="login-card">
        <h2>Login</h2>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
        <div style="background:#fff0f0;border:1px solid #f5c6cb;color:#721c24;padding:10px 14px;border-radius:8px;margin-bottom:16px;font-size:13px;"><%=error%></div>
        <% } %>
        <form action="<%=request.getContextPath()%>/login" method="post">
            <div class="mb-3">
                <input type="email" class="form-control" name="email" placeholder="Enter email" required>
            </div>

            <div class="mb-3">
                <input type="password" class="form-control" name="password" placeholder="Enter password" required>
            </div>

            <div class="recaptcha-box mb-3">
                <input type="checkbox" id="recaptcha" name="recaptcha" required>
                <label for="recaptcha">I'm not a robot</label>
            </div>

            <button type="submit" class="btn-login">Login</button>
        </form>

        <div class="divider">or</div>

        <a href="#" class="btn-google">
            <img src="https://www.svgrepo.com/show/475656/google-color.svg" alt="Google">
            Sign in with Google
        </a>

        <a href="password-reset.jsp" class="password-reset-link">Password Reset</a>
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
