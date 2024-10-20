package tienda;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;

public class ReadServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Connection connection = null;
        List<String[]> productDetailsList = new ArrayList<>(); // Adjusted type
        String message = null;

        // Obtain the database connection
        connection = ConnectionPostgresqlTienda.obtainConnection();
        String idProductoStr = request.getParameter("txtIdProducto");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("index.jsp"); // Redirect to login if session is invalid
            return;
        }
        if (connection != null) {
            response.getWriter().println("Connection ok.");
            if (idProductoStr != null && !idProductoStr.isEmpty()) {
                try {
                    int idProducto = Integer.parseInt(idProductoStr);
                    // Use the MetodosCrud.readProduct method
                    productDetailsList = MetodosCrud.readProduct(connection, idProducto);
                } catch (NumberFormatException e) {
                    message = "Invalid product ID format.";
                }
            } else {
                message = "Product ID is required.";
            }

            // Close the connection to the database
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            // Set attributes for the JSP
            request.setAttribute("productList", productDetailsList);
            request.setAttribute("message", message);

            // Forward to the JSP page
            request.getRequestDispatcher("Options/showProduct.jsp").forward(request, response);
        } else {
            response.getWriter().println("Connection not established.");
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
    } // </editor-fold>
}
