<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            background: #f0f2f5;
            font-family: 'Heebo', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card {
            background: #ffffff;
            border-radius: 12px;
            padding: 44px 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        h2 {
            text-align: center;
            font-size: 24px;
            font-weight: 700;
            color: #191C24;
            margin-bottom: 28px;
        }

        input[type="email"] {
            width: 100%;
            height: 46px;
            padding: 0 14px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            font-size: 14px;
            font-family: 'Heebo', sans-serif;
            outline: none;
            transition: border-color 0.2s;
            margin-bottom: 16px;
        }

        input[type="email"]:focus {
            border-color: #555;
        }

        button {
            width: 100%;
            height: 46px;
            background: #2d2d2d;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            font-family: 'Heebo', sans-serif;
            cursor: pointer;
            transition: background 0.2s;
        }

        button:hover {
            background: #111;
        }

        .msg {
            text-align: center;
            font-size: 13px;
            margin-top: 14px;
            padding: 10px 14px;
            border-radius: 8px;
        }

        .msg.success { background: #f0fff4; color: #276749; border: 1px solid #c6f6d5; }
        .msg.error   { background: #fff0f0; color: #721c24; border: 1px solid #f5c6cb; }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 16px;
            font-size: 13px;
            color: #009CFF;
            text-decoration: none;
        }

        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="card">
        <h2>Reset Password</h2>

        <%
            String error   = (String) request.getAttribute("error");
            String success = (String) request.getAttribute("success");
        %>
        <% if (error != null) { %>
            <div class="msg error"><%=error%></div>
        <% } %>
        <% if (success != null) { %>
            <div class="msg success"><%=success%></div>
        <% } %>

        <form action="<%=request.getContextPath()%>/reset-pass" method="post">
            <input type="email" name="email" placeholder="Enter email" required>
            <button type="submit">Confirm</button>
        </form>

        <a href="<%=request.getContextPath()%>/login" class="back-link">← Back to Login</a>
    </div>
</body>
</html>
