<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registro</title>
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
        .register-container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }
        .register-container label {
            display: block;
            margin: 10px 0 5px;
            text-align: left;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .register-button {
            background-color: #007bff; /* Blue background for the register button */
            color: black; /* Black text for the register button */
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
            font-size: 16px; /* Adjust text size as needed */
            width: 100%;
        }
        .register-button:hover {
            background-color: #0056b3; /* Darker shade on hover */
        }
        .back-button {
            background-color: #28a745; /* Green background for back button */
            color: white; /* White text for back button */
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            margin-top: 10px;
            font-size: 16px; /* Adjust text size as needed */
        }
        .back-button:hover {
            background-color: #218838; /* Darker shade on hover */
        }
        .error-message {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h1>Registro</h1>

        <!-- Display error message if it exists -->
        <%
            String errorMessage = (String) session.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <p class="error-message"><%= errorMessage %></p>
        <%
                session.removeAttribute("errorMessage"); // Clear the error message after displaying it
            }
        %>

        <form action="RegisterServlet" method="post">
            <label for="txtNombre">Nombre:</label>
            <input type="text" name="txtNombre" placeholder="Nombre" required>
            <label for="txtApellidos">Apellidos:</label>
            <input type="text" name="txtApellidos" placeholder="Apellidos" required>
            <label for="txtUsername">Usuario:</label>
            <input type="text" name="txtUsername" placeholder="Usuario" required>
            <label for="txtPassword">Contraseña:</label>
            <input type="password" name="txtPassword" placeholder="Contraseña" required>
            <label for="txtFechaNacimiento">Fecha de Nacimiento:</label>
            <input type="date" name="txtFechaNacimiento">
            <input type="submit" class="register-button" value="Registrar">
        </form>
        <button class="back-button" onclick="window.location.href='index.jsp'">Volver al Login</button>
    </div>
</body>
</html>
