<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                height: 100vh;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }

            h1 {
                color: #fff; /* White text for contrast */
                background: linear-gradient(135deg, #333, #666); /* Gradient from dark grey to lighter grey */
                padding: 5px; /* Adjusted padding for consistency */
                border-radius: 5px; /* Rounded corners */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); /* Subtle shadow effect */
                font-size: 1.2em; /* Adjusted font size to make it smaller */
                text-align: center; /* Center align text */
                margin-bottom: 10px; /* Space below the header */
                width: 230px; /* Adjusted width to be smaller than button containers */
                height: 30px; /* Adjusted height to match the new font size */
                display: flex; /* Use flexbox to center text vertically */
                align-items: center; /* Center text vertically */
                justify-content: center; /* Center text horizontally */
                transition: background 0.3s; /* Smooth transition for hover effect */
            }


            h1:hover {
                background: linear-gradient(135deg, #444, #777); /* Darker gradient on hover */
            }

            .user-session {
                position: absolute;
                top: 10px;
                right: 20px;
                background-color: #ffffff;
                padding: 1px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                font-size: 10px;
                width: auto;
            }

            .user-session a {
                color: #007bff; /* Adjust the color to fit your theme */
                text-decoration: none; /* Remove underline */
                margin-left: 10px; /* Space between username and logout link */
            }

            .user-session a:hover {
                text-decoration: underline; /* Underline on hover for better UX */
            }

            .message-container {
                height: 60px; /* Fixed height for the message container */
                overflow: hidden; /* Prevents overflow */
                transition: opacity 0.5s; /* Smooth transition for fading out */
            }

            .options-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-top: 0; /* Cambiado de 5px a 0 */
            }

            .button-container {
                width: 250px;
                margin: 2px 0; /* Ajustado a 2px para un espacio más pequeño entre botones */
            }

            button {
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                width: 100%; /* Make the button take the full width of the container */
                height: 40px; /* Fixed height for all buttons */
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); /* Add some shadow for depth */
            }

            button:hover {
                background-color: #0056b3;
            }

            .message, .success-message {
                color: green; /* Color for messages */
                font-weight: bold; /* Make message bold */
                margin-bottom: 0; /* No space below message */
                text-align: center; /* Center the message */
            }

            footer {
                position: absolute;
                bottom: 10px;
                width: 100%;
                text-align: center;
                margin-bottom: 20px;
            }

            footer a {
                background-color: #007bff;
                color: white;
                padding: 5px 10px;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s;
                font-size: 12px;
            }

            footer a:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>


        <%
            // Retrieve message parameter if present
            String message = request.getParameter("message");
        %>

        <div class="user-session">
            <% String username = (String) session.getAttribute("username"); %>
            <% if (username != null) {%>
            <p>Session: <strong><%= username%></strong> <a href="http://localhost:8080/Project_Tienda/LogoutServlet" style="color: red; text-decoration: none; margin-left: 10px;">Cerrar sesión</a></p>
            <% } else { %>
            No has iniciado sesión.
            <% } %>
        </div>

        <h1>Elige una opción:</h1>
        <div class="options-container">

            <div class="button-container">
                <form action="http://localhost:8080/Project_Tienda/MenuServlet" method="post">
                    <input type="hidden" name="txtOpcion" value="1">
                    <button type="submit">Insertar Producto</button>
                </form>
            </div>
            <div class="button-container">
                <form action="http://localhost:8080/Project_Tienda/MenuServlet" method="post">
                    <input type="hidden" name="txtOpcion" value="2">
                    <button type="submit">Ver Producto</button>
                </form>
            </div>
            <div class="button-container">
                <form action="http://localhost:8080/Project_Tienda/MenuServlet" method="post">
                    <input type="hidden" name="txtOpcion" value="3">
                    <button type="submit">Actualizar Producto</button>
                </form>
            </div>
            <div class="button-container">
                <form action="http://localhost:8080/Project_Tienda/MenuServlet" method="post">
                    <input type="hidden" name="txtOpcion" value="4">
                    <button type="submit">Eliminar Producto</button>
                </form>
            </div>
            <div class="button-container">
                <form action="http://localhost:8080/Project_Tienda/MenuServlet" method="post">
                    <input type="hidden" name="txtOpcion" value="5">
                    <button type="submit">Ver Base de Datos</button>
                </form>
            </div>
        </div>
        <br><br>
        <!-- Message container to reserve space -->
        <div class="message-container">
            <!-- Display the message if it exists -->
            <%
                if (message != null && !message.isEmpty()) {
            %>
            <div class="message" id="generalMessage">
                <%= message%>
            </div>
            <%
                }
            %>

            <%
                // Check if there is a success message in the session
                String successMessage = (String) session.getAttribute("successMessage");
                if (successMessage != null) {
            %>
            <div class="success-message" id="successMessage">
                <%= successMessage%>
            </div>
            <%
                    // Remove the message from the session so it doesn't display again
                    session.removeAttribute("successMessage");
                }
            %>
        </div>

        <script>
            // Set a timeout for both messages to fade out after 10 seconds
            setTimeout(function () {
                var generalMessage = document.getElementById('generalMessage');
                var successMessage = document.getElementById('successMessage');

                if (generalMessage) {
                    generalMessage.style.opacity = '0'; // Fade out the general message
                    setTimeout(function () {
                        generalMessage.style.display = 'none'; // Hide the general message after fading out
                    }, 500); // Wait for the fade-out transition to complete
                }

                if (successMessage) {
                    successMessage.style.opacity = '0'; // Fade out the success message
                    setTimeout(function () {
                        successMessage.style.display = 'none'; // Hide the success message after fading out
                    }, 500); // Wait for the fade-out transition to complete
                }
            }, 3000); // 3000 milliseconds = 3 seconds
        </script>
    </body>
</html>
