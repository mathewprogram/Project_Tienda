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
            padding: 5px 10px; /* Adjust padding for smaller size */
            border-radius: 5px; /* Rounded corners */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); /* Subtle shadow effect */
            font-size: 1.5em; /* Decrease font size */
            text-align: center; /* Center align text */
            margin: 0 auto 20px; /* Center title and space below */
            width: 300px; /* Fixed width matching form */
        }
        form {
            background-color: white; /* Fondo blanco para el formulario */
            padding: 20px; /* Espaciado interno del formulario */
            border-radius: 8px; /* Bordes redondeados */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Sombra */
            text-align: center; /* Centramos el texto dentro del formulario */
            width: 300px; /* Fixed width matching title */
        }
        input[type="text"] {
            width: 150px; /* Fixed width of 150px */
            padding: 10px; /* Espaciado interno */
            margin: 10px 0; /* Espaciado vertical */
            border: 1px solid #ccc; /* Borde gris claro */
            border-radius: 4px; /* Bordes redondeados */
            box-sizing: border-box; /* Asegura que el padding se incluya en el tamaño total */
            text-align: center; /* Center text */
            display: block; /* Ensures the input is treated as a block element */
            margin-left: auto; /* Center input */
            margin-right: auto; /* Center input */
        }
        .submit-button {
            background-color: #007bff; /* Color de fondo del botón */
            color: white; /* Color del texto */
            padding: 10px; /* Espaciado interno */
            border: none; /* Sin borde */
            border-radius: 4px; /* Bordes redondeados */
            cursor: pointer; /* Cambia el cursor al pasar el ratón */
            font-size: 16px; /* Tamaño de texto */
            width: 150px; /* Fixed width of 150px */
            transition: background-color 0.3s; /* Transición de color */
            margin-top: 10px; /* Space above the button */
            display: block; /* Ensures the button is treated as a block element */
            margin-left: auto; /* Center button */
            margin-right: auto; /* Center button */
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
    <h1>Buscar Producto por ID</h1>
    <form action="ReadServlet" method="POST" class="product-input"> <!-- Add class for styling -->
        <input type="text" name="txtIdProducto" placeholder="Insertar ID producto" list="availableIds" required>
        <datalist id="availableIds">
            <%
                // Fetch available product IDs from the database
                try (Connection connection = ConnectionPostgresqlTienda.obtainConnection()) {
                    List<Integer> productIds = MetodosCrud.getAvailableProductIds(connection);
                    for (Integer id : productIds) {
                        out.println("<option value='" + id + "'/>");
                    }
                } catch (SQLException e) {
                    out.println("<option value='Error fetching IDs'/>");
                }
            %>
        </datalist>
        <button type="submit" class="submit-button">Buscar</button>
    </form>
    <footer>
        <a href="http://localhost:8080/Project_Tienda/menu.jsp">Atrás</a>
    </footer>
</body>
</html>
