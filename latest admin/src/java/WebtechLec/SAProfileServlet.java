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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author james
 */
@WebServlet(name = "SAProfileServlet", urlPatterns = {"/SAProfileServlet"})
public class SAProfileServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0); // Proxies.
        HttpSession session = request.getSession(false);
        if(session == null){
            response.sendRedirect("index.html");  
        }else{
            try (PrintWriter out = response.getWriter()) {
                response.setContentType("text/html;charset=UTF-8");
                String username = session.getAttribute("username").toString();
                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/pagefragments/SAprofileheader.html");
                rd.include(request, response);
                ConnectDB db = new ConnectDB();
                Connection conn = db.getConn();
                String stmt1 = "select username, email from accounts where username='"+username+"';";
                String stmt2 = "select admin_name, admin_contact from admin inner join accounts on admin.account_id = accounts.account_id where accounts.username='"+username+"';";
                PreparedStatement ps1 = conn.prepareStatement(stmt1);
                PreparedStatement ps2 = conn.prepareStatement(stmt2);
                ResultSet rs1 = ps1.executeQuery();
                ResultSet rs2 = ps2.executeQuery();
                while(rs1.next()){
                    out.println("<h3>Username:&nbsp;&nbsp;&nbsp;"+rs1.getString("username")+"</h3>");
                    out.println("<h3>Email:&nbsp;&nbsp;&nbsp;"+rs1.getString("email")+"</h3>");
                }
                while(rs2.next()){
                    out.println("<h3>Admin Name:&nbsp;&nbsp;&nbsp;"+rs2.getString("admin_name")+"</h3>");
                    out.println("<h3>Contact:&nbsp;&nbsp;&nbsp;"+rs2.getString("admin_contact")+"</h3>");                  
                }

                rd = request.getRequestDispatcher("/WEB-INF/pagefragments/SAprofilefooter.html");
                rd.include(request, response);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SAProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SAProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
