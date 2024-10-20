package tienda;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;

        try {
            connection = ConnectionPostgresqlTienda.obtainConnection();
            String username = request.getParameter("txtUserName");
            String password = request.getParameter("txtPassword");

            if (MetodosCrud.verificarUsuario(connection, username, password)) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.removeAttribute("errorMessage"); // Clear error message
                response.sendRedirect("menu.jsp");
            } else {
                request.setAttribute("errorMessage", "Usuario o contraseña incorrectos.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error en la conexión.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
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
