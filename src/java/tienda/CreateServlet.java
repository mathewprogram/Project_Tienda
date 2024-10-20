package tienda;

import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.http.HttpSession;

public class CreateServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    Connection connection = null;
    String message = "";
    
    try {
        connection = ConnectionPostgresqlTienda.obtainConnection();
        String nombreProducto = request.getParameter("txtNombre");
        BigDecimal precioProducto = new BigDecimal(request.getParameter("txtPrecio"));
        String departamento = request.getParameter("txtDepartamento");
        int cantidad = Integer.parseInt(request.getParameter("txtCantidad"));

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("index.jsp"); // Redirect to login if session is invalid
            return;
        }
        
        // Insert product into the database
        MetodosCrud.createProduct(connection, nombreProducto, precioProducto, departamento, cantidad);
        message = "Producto insertado exitosamente."; // Success message

        // Store the success message in the session
        session.setAttribute("successMessage", message);

    } catch (NumberFormatException e) {
        message = "Error en los datos ingresados. Asegúrese de que el precio y la cantidad sean números válidos.";
        e.printStackTrace();
    } finally {
        if (connection != null) {
            try {
                connection.close(); // Close the connection
            } catch (SQLException e) {
                e.printStackTrace(); // Handle error when closing the connection
            }
        }
    }

        // Set the success or error message in the request
        request.setAttribute("message", message);
        // Forward to the menu page
        request.getRequestDispatcher("menu.jsp").forward(request, response);
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
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
