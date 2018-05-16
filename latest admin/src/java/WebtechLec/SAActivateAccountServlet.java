/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebtechLec;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SAActivateAccountServlet", urlPatterns = {"/SAActivateAccountServlet"})
public class SAActivateAccountServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            ConnectDB db = new ConnectDB();
            Connection conn = db.getConn();
            String cID = request.getParameter("hiddenid");
            String value = request.getParameter("activate");
            String value1 = request.getParameter("deactivate");
            if("activate".equals(value)){
                String sql1 = "UPDATE tenterent.accounts SET activate='active' WHERE account_id='"+ cID + "';"; 
                PreparedStatement ps = conn.prepareStatement(sql1);  
                ps.executeUpdate();
                RequestDispatcher rd = request.getRequestDispatcher("SAhome.html");
                rd.include(request, response);
                out.println("<script type=\"text/javascript\">");
                out.println("alert('The user has been successfully accepted.');");
                out.println("</script>");
            }else if("deactivate".equals(value1)){
                String sql1 = "UPDATE tenterent.accounts SET activate='inactive' WHERE account_id='"+ cID + "';"; 
                PreparedStatement ps = conn.prepareStatement(sql1);  
                ps.executeUpdate();
                RequestDispatcher rd = request.getRequestDispatcher("SAhome.html");
                rd.include(request, response);
                out.println("<script type=\"text/javascript\">");
                out.println("alert('The user has been rejected.');");
                out.println("</script>");
            }
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
    }// </editor-fold>

}
