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
                margin: 0; /* Remove default margin */
                padding: 20px; /* Add padding */
                background-color: #f4f4f4;
                color: #333;
                display: flex; /* Use flexbox */
                justify-content: center; /* Center horizontally */
                align-items: center; /* Center vertically */
                height: 100vh; /* Full viewport height */
                flex-direction: column; /* Stack elements vertically */
            }
            h1 {
                text-align: center;
                color: #2c3e50;
            }
            .product-details {
                display: flex;
                flex-direction: column;
                align-items: center;
                width: 100%; /* Full width */
                max-width: 800px; /* Limit maximum width */
                margin: 0 auto; /* Center the product-details container */
            }
            .product-detail {
                display: flex;
                justify-content: space-around;
                background-color: #ffffff;
                padding: 10px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                margin-bottom: 10px;
                width: 100%; /* Full width */
            }
            .detail-column {
                flex: 1; /* Take equal space */
                padding: 10px;
                text-align: center;
                border-radius: 5px;
                margin: 0 5px; /* Add some space between columns */
            }
            .header-column {
                background-color: #2980b9;
                color: white;
                font-weight: bold;
            }
            .data-column:nth-child(even) {
                background-color: #e8f8f5; /* Light teal shade */
            }
            .data-column:nth-child(odd) {
                background-color: #ffffff; /* White shade */
            }
            .error {
                color: red;
                font-weight: bold;
                text-align: center;
            }
            .back-button {
                display: inline-block;
                padding: 5px 10px; /* Smaller padding to match the other button style */
                margin-top: 20px;
                background-color: #007bff; /* Blue color similar to the other button */
                color: white;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s;
                font-size: 12px; /* Smaller font size */
            }
            .back-button:hover {
                background-color: #0056b3; /* Darker shade on hover */
            }
            footer {
                text-align: center;
                margin-top: 20px; /* Ensure some space above the footer */
            }
        </style>
    </head>
    <body>
        <%
            try {
                String productIdParam = request.getParameter("txtIdProducto");
                
                if (productIdParam != null && !productIdParam.isEmpty()) {
                    int idProducto = Integer.parseInt(productIdParam); // Convert to int

                    // Establish a database connection
                    Connection connection = ConnectionPostgresqlTienda.obtainConnection();
                    List<String[]> productDetailsList = MetodosCrud.readProduct(connection, idProducto);
                    connection.close();

                    // Check if the list is empty
                    if (!productDetailsList.isEmpty()) {
                        out.println("<div class='product-details'>");
                        out.println("<div class='product-detail'>");
                        out.println("<div class='detail-column header-column'>ID</div>");
                        out.println("<div class='detail-column header-column'>Name</div>");
                        out.println("<div class='detail-column header-column'>Price</div>");
                        out.println("<div class='detail-column header-column'>Department</div>");
                        out.println("<div class='detail-column header-column'>Quantity</div>");
                        out.println("</div>"); // Close header row
                        
                        for (String[] productDetails : productDetailsList) {
                            out.println("<div class='product-detail'>");
                            for (String detail : productDetails) {
                                out.println("<div class='detail-column data-column'>" + detail + "</div>"); // Display each detail
                            }
                            out.println("</div>"); // Close product detail row
                        }
                        out.println("</div>"); // Close product-details container
                    } else {
                        out.println("<div class='error'>No product found with the specified ID.</div><br>");
                    }
                } else {
                    out.println("<div class='error'>Please enter a valid product ID.</div><br>");
                }
            } catch (NumberFormatException e) {
                out.println("<div class='error'>Invalid product ID format. Please enter a valid number.</div><br>");
            } catch (SQLException e) {
                out.println("<div class='error'>Database connection error: " + e.getMessage() + "</div><br>");
                e.printStackTrace();
            }
        %>
        <footer>
            <a href="http://localhost:8080/Project_Tienda/menu.jsp" class="back-button">Atrás</a> <!-- Update link to menu.jsp -->
        </footer>
    </body>
</html>
