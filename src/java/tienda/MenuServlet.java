package tienda;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MenuServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("username") == null) {
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
            }

            String option = request.getParameter("txtOpcion");

            switch (option) {
                case "1":
                    request.getRequestDispatcher("Options/createProduct.jsp").forward(request, response);
                    break;
                case "2":
                    request.getRequestDispatcher("Options/readProduct.jsp").forward(request, response);
                    break;
                case "3":
                    request.getRequestDispatcher("Options/updateProduct.jsp").forward(request, response);
                    break;
                case "4":
                    request.getRequestDispatcher("Options/deleteProduct.jsp").forward(request, response);
                    break;
                case "5":
                    request.getRequestDispatcher("Options/baseDatos.jsp").forward(request, response);
                    break;
            }

            out.println("<footer style='position: fixed; bottom: 10px; width: 100%; text-align: center;'>");
            out.println("<a href='http://localhost:8080/Project_Tienda/menu.jsp'>Atras</a>");
            out.println("</footer>");
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
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
