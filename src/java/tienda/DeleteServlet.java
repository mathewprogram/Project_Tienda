package tienda;

import java.io.IOException;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.http.HttpSession;

public class DeleteServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html;charset=UTF-8");
    String message = null;

    try {
        Connection connection = ConnectionPostgresqlTienda.obtainConnection();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("index.jsp"); // Redirect to login if session is invalid
            return;
        }
        if (connection != null) {
            String idParam = request.getParameter("txtId");
            try {
                int idProducto = Integer.parseInt(idParam);
                boolean deleted = MetodosCrud.deleteProduct(connection, idProducto);

                if (deleted) {
                    // Encode the message to prevent character encoding issues
                    String encodedMessage = URLEncoder.encode("¡Producto eliminado con éxito!", "UTF-8");
                    // Redirect to menu.jsp with success message
                    response.sendRedirect("menu.jsp?message=" + encodedMessage);
                } else {
                    // Product not found
                    message = "<h2 style='color: red;'>¡Error al eliminar el producto! Producto no encontrado.</h2>";
                }
            } catch (NumberFormatException e) {
                // Invalid number format
                message = "<h2 style='color: red;'>El ID del producto debe ser un número válido.</h2>";
            } finally {
                connection.close(); // Ensure connection is closed after operation
            }
        } else {
            // Connection error
            message = "<h2 style='color: red;'>No se pudo establecer conexión con la base de datos.</h2>";
        }
    } catch (SQLException e) {
        // Log SQL exceptions for debugging
        message = "<h2 style='color: red;'>Error de SQL: " + e.getMessage() + "</h2>";
        e.printStackTrace();
    }

    // If there's an error message, forward to deleteProduct.jsp
    if (message != null) {
        request.setAttribute("message", message);
        request.getRequestDispatcher("Options/deleteProduct.jsp").forward(request, response);
    }
}

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
