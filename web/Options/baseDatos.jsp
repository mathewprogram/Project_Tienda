<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page import="tienda.MetodosCrud"%>
<%@page import="tienda.ConnectionPostgresqlTienda"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Product Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0; 
            padding: 20px; 
            background-color: #f4f4f4;
            color: #333;
        }
        h1 {
                color: #fff; /* White text for contrast */
                background: linear-gradient(135deg, #333, #666); /* Gradient from dark grey to lighter grey */
                padding: 5px 10px; /* Adjust padding for smaller size */
                border-radius: 5px; /* Rounded corners */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); /* Subtle shadow effect */
                font-size: 1.5em; /* Decrease font size */
                text-align: center; /* Center align text */
                margin-bottom: 20px; /* Increased space below the header */
                transition: background 0.3s; /* Smooth transition for hover effect */
            }

            h1:hover {
                background: linear-gradient(135deg, #444, #777); /* Darker gradient on hover */
            }
        .product-details {
            display: flex;
            flex-direction: column;
            align-items: center;
            max-width: 800px; 
            margin: 0 auto; 
        }
        .product-detail {
            display: flex;
            justify-content: space-around;
            background-color: #ffffff;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 10px;
            width: 100%; 
        }
        .detail-column {
            flex: 1; 
            padding: 10px;
            text-align: center;
        }
        .header-column {
            background-color: #2980b9;
            color: white;
            font-weight: bold;
        }
        .data-column:nth-child(even) {
            background-color: #e8f8f5; 
        }
        .data-column:nth-child(odd) {
            background-color: #ffffff; 
        }
        .error {
            color: red;
            font-weight: bold;
            text-align: center;
        }
        .back-button {
            display: inline-block;
            padding: 5px 10px; 
            margin-top: 20px;
            background-color: #007bff; 
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
            font-size: 12px; 
        }
        .back-button:hover {
            background-color: #0056b3; 
        }
        footer {
            text-align: center;
            margin-top: 20px; 
        }
    </style>
</head>
<body>
    <h1>Base de Datos</h1>
    <div class="product-details">
        <div class="product-detail">
            <div class="detail-column header-column">ID</div>
            <div class="detail-column header-column">Nombre</div>
            <div class="detail-column header-column">Precio</div>
            <div class="detail-column header-column">Departamento</div>
            <div class="detail-column header-column">Cantidad</div>
        </div>

        <%
            try {
                // Establish a database connection
                Connection connection = ConnectionPostgresqlTienda.obtainConnection();
                List<String[]> productDetailsList = MetodosCrud.baseDatos(connection);
                connection.close();

                // Check if the list is empty
                if (!productDetailsList.isEmpty()) {
                    for (String[] productDetails : productDetailsList) {
                        out.println("<div class='product-detail'>");
                        for (String detail : productDetails) {
                            out.println("<div class='detail-column data-column'>" + detail + "</div>"); // Display each detail
                        }
                        out.println("</div>"); // Close product detail row
                    }
                } else {
                    out.println("<div class='error'>No products found in the database.</div><br>");
                }
            } catch (SQLException e) {
                out.println("<div class='error'>Database connection error: " + e.getMessage() + "</div><br>");
                e.printStackTrace();
            }
        %>
    </div>
    <footer>
        <a href="http://localhost:8080/Project_Tienda/menu.jsp" class="back-button">Atrás</a>
    </footer>
</body>
</html>
