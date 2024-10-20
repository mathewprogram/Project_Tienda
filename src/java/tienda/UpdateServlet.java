package tienda;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.http.HttpSession;

public class UpdateServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String idParam = request.getParameter("txtId");
            String nombre = request.getParameter("txtNombre");
            String precioProducto = request.getParameter("txtPrecio");
            String departament = request.getParameter("txtDepartamento");
            String cantidadProducto = request.getParameter("txtCantidad");

            int idProducto = Integer.parseInt(idParam);
            double precio = Double.parseDouble(precioProducto);
            int cantidad = Integer.parseInt(cantidadProducto);

            Connection connection = ConnectionPostgresqlTienda.obtainConnection();
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("username") == null) {
                response.sendRedirect("index.jsp"); // Redirect to login if session is invalid
                return;
            }

            if (connection != null) {
                //out.println("Connection ok");    
                MetodosCrud.updateProduct(connection, idProducto, nombre, precio, departament, cantidad);
                // Redirect to menu.jsp with a success message as a parameter
                response.sendRedirect("menu.jsp?message=Product updated successfully!");
            } else {
                response.sendRedirect("menu.jsp?message=Connection error");
                out.println("Connection error");
            }
        } catch (NumberFormatException e) {
            // Handle invalid number formats (if any)
            response.getWriter().println("Error: Invalid input format.");
            e.printStackTrace();
        } catch (Exception e) {
            // Handle other exceptions
            response.getWriter().println("Error: " + e.getMessage());
            e.printStackTrace();
        }

    }

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
