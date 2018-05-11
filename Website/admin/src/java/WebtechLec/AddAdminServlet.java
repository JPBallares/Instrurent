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
 * @author s422
 */
@WebServlet(name = "AddAdminServlet", urlPatterns = {"/AddAdminServlet"})
public class AddAdminServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0); // Proxies.
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false);
        if(session == null){
            response.sendRedirect("index.html");
        }else{
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String acc_type = request.getParameter("accounttype");
        String name = request.getParameter("name");
        String contact = request.getParameter("contact");
        response.setContentType("text/html");
        String stmt1;
        String stmt2;
        String stmt3;
        try (PrintWriter out = response.getWriter()) {
            ConnectDB db = new ConnectDB();
            Connection conn = db.getConn();
            stmt1 = "INSERT INTO accounts(email, username, password, account_type) VALUES ('"+email+"','"+username+"','"+password+"','"+acc_type+"');";
            PreparedStatement p1 = conn.prepareStatement(stmt1);
            p1.executeUpdate(stmt1);
            stmt2 = "SELECT account_id from accounts order by account_id desc limit 1";
            PreparedStatement p2 = conn.prepareStatement(stmt2);
            ResultSet rs = p2.executeQuery();
            
            String aId = null;
            while(rs.next()){
                aId = rs.getString("account_id");
            }
            stmt3 = "INSERT INTO admin(admin_name, admin_contact, account_id) values ('"+name+"', '"+contact+"', '"+aId+"')";
            PreparedStatement p3 = conn.prepareStatement(stmt3);
            p3.executeUpdate(stmt3);
            response.sendRedirect("successfulAddAdmin.html");
        } catch (SQLException ex) {
            Logger.getLogger(SAAdminServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AddAdminServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AddAdminServlet.class.getName()).log(Level.SEVERE, null, ex);
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
