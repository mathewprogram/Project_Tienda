<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page import="tienda.MetodosCrud"%>
<%@page import="tienda.ConnectionPostgresqlTienda"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Create Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            padding: 0 20px; /* Padding para que no esté pegado a los bordes */
        }
        h1 {
            color: #fff; /* White text for contrast */
            background: linear-gradient(135deg, #333, #666); /* Gradient from dark grey to lighter grey */
            padding: 10px; /* Adjust padding for consistency */
            border-radius: 5px; /* Rounded corners */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); /* Subtle shadow effect */
            font-size: 1.5em; /* Decrease font size */
            text-align: center; /* Center align text */
            margin-bottom: 20px; /* Space below the header */
            width: 100%; /* Match form width */
            max-width: 300px; /* Set max width to match the form */
            transition: background 0.3s; /* Smooth transition for hover effect */
        }
        h1:hover {
            background: linear-gradient(135deg, #444, #777); /* Darker gradient on hover */
        }
        form {
            background-color: white; /* Fondo blanco para el formulario */
            padding: 20px; /* Espaciado interno del formulario */
            border-radius: 8px; /* Bordes redondeados */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Sombra */
            width: 100%; /* Ancho completo del formulario */
            max-width: 300px; /* Consistent max width */
            text-align: center; /* Centramos el texto dentro del formulario */
        }
        input[type="text"],
        input[type="number"] {
            width: 90%; /* Decrease input width */
            padding: 5px; /* Smaller internal padding */
            margin: 10px 0; /* Espaciado vertical */
            border: 1px solid #ccc; /* Borde gris claro */
            border-radius: 4px; /* Bordes redondeados */
            box-sizing: border-box; /* Asegura que el padding se incluya en el tamaño total */
            text-align: center; /* Center text */
        }
        .submit-button {
            background-color: #007bff; /* Color de fondo del botón */
            color: white; /* Color del texto */
            padding: 5px; /* Smaller internal padding */
            border: none; /* Sin borde */
            border-radius: 4px; /* Bordes redondeados */
            cursor: pointer; /* Cambia el cursor al pasar el ratón */
            font-size: 14px; /* Decrease button font size */
            width: 90%; /* Decrease button width */
            transition: background-color 0.3s; /* Transición de color */
        }
        .submit-button:hover {
            background-color: #0056b3; /* Color más oscuro al pasar el ratón */
        }
        footer {
            position: fixed;
            bottom: 10px;
            width: 100%;
            text-align: center;
            margin-bottom: 20px;
        }
        footer a {
            background-color: #007bff; /* Color del fondo del enlace */
            color: white;
            padding: 5px 10px;
            text-decoration: none; /* Quitar subrayado */
            border-radius: 4px; /* Bordes redondeados */
            transition: background-color 0.3s; /* Transición de color */
            font-size: 12px;
        }
        footer a:hover {
            background-color: #0056b3; /* Color más oscuro al pasar el ratón */
        }
    </style>
</head>
<body>
    <h1>Insertar Producto</h1>
    <form action="CreateServlet" method="post">
        <input type="text" name="txtNombre" placeholder="Nombre Producto" required><br>
        <input type="number" name="txtPrecio" placeholder="Precio Producto" required step="0.01"><br>
        <input type="text" name="txtDepartamento" placeholder="Departamento" list="departments" required><br>
        <datalist id="departments">
            <%
                // Fetch available product departamentos from the database
                try (Connection connection = ConnectionPostgresqlTienda.obtainConnection()) {
                    List<String> departamentos = MetodosCrud.getAvailableDepartments(connection);
                    for (String departamento : departamentos) {
                        out.println("<option value='" + departamento + "'/>");
                    }
                } catch (SQLException e) {
                    out.println("<option value='Error fetching departamento'/>");
                }
            %>
        </datalist>
        <input type="number" name="txtCantidad" placeholder="Cantidad" required><br>
        <button type="submit" class="submit-button">Insertar</button>
    </form>
    <footer>
        <a href='http://localhost:8080/Project_Tienda/menu.jsp'>Atrás</a>
    </footer>
</body>
</html>
