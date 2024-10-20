<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Producto</title>
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
            input[type="text"] {
                width: 90%; /* Decrease input width */
                padding: 5px; /* Smaller internal padding */
                margin: 10px 0; /* Espaciado vertical */
                border: 1px solid #ccc; /* Borde gris claro */
                border-radius: 4px; /* Bordes redondeados */
                box-sizing: border-box; /* Asegura que el padding se incluya en el tamaño total */
                text-align: center; /* Center text */
            }
            .submit-button {
                background-color: #dc3545; /* Red background for delete button */
                color: white; /* Color of the text */
                padding: 5px; /* Smaller internal padding */
                border: none; /* No border */
                border-radius: 4px; /* Rounded corners */
                cursor: pointer; /* Changes cursor on hover */
                font-size: 14px; /* Decrease button font size */
                width: 90%; /* Decrease button width */
                transition: background-color 0.3s; /* Color transition */
                margin: 10px 0; /* Add vertical margin */
            }
            .submit-button:hover {
                background-color: #c82333; /* Darker red on hover */
            }
            .message {
                color: red;
                display: none; /* Hide by default */
                text-align: center; /* Center text */
                margin-top: 10px; /* Top margin */
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

            /* Modal styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.4);
            }
            .modal-content {
                background-color: #fefefe;
                position: absolute;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%);
                padding: 20px;
                border: 1px solid #888;
                width: 300px;
                text-align: center;
                border-radius: 8px;
            }
            .modal-button {
                background-color: red;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin: 5px;
                transition: background-color 0.3s;
            }
            .modal-button:hover {
                background-color: darkred;
            }
            .modal-buttonCancelar {
                background-color: #007bff;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin: 5px;
                transition: background-color 0.3s;
            }
            .modal-buttonCancelar:hover {
                background-color: darkblue;
            }
        </style>
        <script>
            function openModal() {
                document.getElementById("confirmationModal").style.display = "block";
                return false; // Prevent form submission
            }
            function closeModal() {
                document.getElementById("confirmationModal").style.display = "none";
            }
            function confirmDelete() {
                closeModal();
                document.getElementById("deleteForm").submit(); // Submit the form
            }

            // Function to display the message
            function showMessage() {
                const messageElement = document.querySelector('.message');
                messageElement.style.display = 'block'; // Show the message
                setTimeout(() => {
                    messageElement.style.display = 'none'; // Hide after 3 seconds
                }, 3000); // Adjust the timeout duration as needed
            }
        </script>
    </head>
    <body>
        <h1>Eliminar Producto por ID</h1>
        <form id="deleteForm" action="DeleteServlet" method="post" onsubmit="return openModal();">
            <input type="text" name="txtId" placeholder="Id Producto" required><br>
            <button type="submit" class="submit-button">Eliminar</button>

            <div class="message">
                <%
                    request.setCharacterEncoding("UTF-8");
                    response.setCharacterEncoding("UTF-8");
                    String message = (String) request.getAttribute("message");
                    if (message != null) {
                        out.println(message); // Print the error message
                        // Call the showMessage function to display it
                        out.println("<script>showMessage();</script>");
                    }
                %>
            </div>
        </form>

        <footer>
            <a href='http://localhost:8080/Project_Tienda/menu.jsp'>Atrás</a>
        </footer>

        <!-- The Modal -->
        <div id="confirmationModal" class="modal">
            <div class="modal-content">
                <p>¿Seguro que quieres borrar?</p>
                <button class="modal-button" onclick="confirmDelete()">Sí, eliminar</button>
                <button class="modal-buttonCancelar" onclick="closeModal()">Cancelar</button>
            </div>
        </div>
    </body>
</html>
