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
@WebServlet(name = "Asp", urlPatterns = {"/Asp"})
public class Asp extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/pagefragments/Aheader.html");
            rd.include(request, response);
            HttpSession session = request.getSession(false);
            if(session == null){
                response.sendRedirect("index.html");  
            }else {
            ConnectDB db = new ConnectDB();
            Connection conn = db.getConn();
            String stmt;
                out.println("<h1>All Accounts List</h1><br>");
                out.println("<form action=\"Acust\" method=\"POST\">");
                out.println("<input type=\"submit\" value=\"Customer\"></form>");
                out.println("<form action=\"Aadmin\" method=\"POST\">");
                out.println("<input type=\"submit\" value=\"Admin\"></form>");
                out.println("<form action=\"Asp\" method=\"POST\">");
                out.println("<input type=\"submit\" value=\"Service Provider\"></form>");
                stmt = "select account_id, username, email, account_type, activate from accounts where status='a' and account_type='sp';";
                PreparedStatement ps = conn.prepareStatement(stmt);
                ResultSet rs = ps.executeQuery();
                String table = "    <table>"
                        + "     <tr>"
                        + "         <th>Username</th>"
                        + "         <th>Email</th>"
                        + "         <th>Account Type</th>"
                        + "         <th>Status</th>"
                        + "         <th>Activate/Deactivate</th>"
                        + "     </tr>";
                out.println(table);
                while(rs.next()){
                        out.println("           <tr>");
                        out.println("               <td>"+rs.getString("username")+"</td>");
                        out.println("               <td>"+rs.getString("email")+"</td>");
                        out.println("               <td>"+rs.getString("account_type")+"</td>");
                        out.println("               <td>"+rs.getString("activate")+"</td>");
                        out.println("               <td>"+"<form method=\"post\" action=\"SAActivateAccountServlet\"><input type='text' value=" + rs.getString("email") + " style='display:none;' name='email'><input type='text' value=" + rs.getString("account_id") + " style='display:none;' name='hiddenid'><input type='submit' value='activate' id='A' name='activate'><input type='submit' value='deactivate' id='DA' name='deactivate'></form></td>");
                        out.println("           </tr>");
                }
                out.println("   </table>");
            
            rd = request.getRequestDispatcher("/WEB-INF/pagefragments/Afooter.html");
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
            Logger.getLogger(Asp.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Asp.class.getName()).log(Level.SEVERE, null, ex);
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
