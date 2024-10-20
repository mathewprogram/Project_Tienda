package tienda;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.http.HttpSession;

public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        request.setCharacterEncoding("UTF-8");
        try {
            connection = ConnectionPostgresqlTienda.obtainConnection();
            String nombre = request.getParameter("txtNombre");
            String apellidos = request.getParameter("txtApellidos");
            String username = request.getParameter("txtUsername");
            String password = request.getParameter("txtPassword");
            String fechaNacimientoStr = request.getParameter("txtFechaNacimiento");

            java.sql.Date fechaNacimiento = null;
            if (fechaNacimientoStr != null && !fechaNacimientoStr.isEmpty()) {
                fechaNacimiento = java.sql.Date.valueOf(fechaNacimientoStr); // Convert String to java.sql.Date
            }

            HttpSession session = request.getSession();

            // Check if the username exists before trying to register the user
            if (MetodosCrud.usernameExists(connection, username)) {
                // If the username exists, set an error message and redirect to the registration form
                session.setAttribute("errorMessage", "El nombre de usuario ya existe. Por favor, elige otro.");
                response.sendRedirect("registerForm.jsp");
            } else {
                // Try to register the user
                boolean success = MetodosCrud.registerUser(connection, nombre, apellidos, username, password, fechaNacimiento);

                if (success) {
                    session.setAttribute("registrationMessage", "Usuario registrado con éxito!");
                    response.sendRedirect("index.jsp");
                } else {
                    session.setAttribute("errorMessage", "Error en el registro del usuario.");
                    response.sendRedirect("registerForm.jsp");
                }
            }

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error en la conexión.");
            request.getRequestDispatcher("registerForm.jsp").forward(request, response);
        } finally {
            try {
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
