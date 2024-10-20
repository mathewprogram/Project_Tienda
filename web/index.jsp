<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0; /* Space between inputs */
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box; /* Include padding and border in width */
        }
        .submit-button {
            background-color: #28a745; /* Green for Iniciar Sesión */
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            margin-top: 10px;
        }
        .register-button {
            background-color: #007bff; /* Blue for Registrarse */
            color: black; /* Black text for Registrarse */
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            margin-top: 10px;
        }
        .register-button:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
        .message-container {
            height: 40px; /* Fixed height to prevent shifting */
            overflow: hidden; /* Hide overflowing content */
            transition: opacity 0.5s ease; /* Smooth transition for opacity */
        }
        .error-message {
            color: red;
            margin-top: 10px;
        }
        .success-message {
            color: green;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Iniciar Sesión</h1>
        <form action="LoginServlet" method="post">
            <input type="text" name="txtUserName" placeholder="Usuario" required>
            <input type="password" name="txtPassword" placeholder="Contraseña" required>
            <button type="submit" class="submit-button">Iniciar Sesión</button>
        </form>
        <button class="register-button" onclick="window.location.href='registerForm.jsp'">Registrarse</button>

        <div id="message-container" class="message-container">
            <% if (request.getAttribute("errorMessage") != null) { %>
                <p class="error-message"><%= request.getAttribute("errorMessage") %></p>
            <% } %>
            <% 
                String registrationMessage = (String) session.getAttribute("registrationMessage");
                if (registrationMessage != null) { 
            %>
                <p class="success-message"><%= registrationMessage %></p>
            <% session.removeAttribute("registrationMessage"); } %>
        </div>
    </div>

    <script>
        // Function to hide messages after 3 seconds
        setTimeout(function() {
            var messageContainer = document.getElementById("message-container");
            if (messageContainer) {
                messageContainer.style.opacity = "0"; // Fade out the messages
            }
        }, 3000); // 3000 milliseconds = 3 seconds
    </script>
</body>
</html>
