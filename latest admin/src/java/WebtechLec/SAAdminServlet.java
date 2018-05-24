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
import java.sql.Statement;
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
@WebServlet(name = "SAAdminServlet", urlPatterns = {"/SAAdminServlet"})
public class SAAdminServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0); // Proxies.
        response.setContentType("text/html;charset=UTF-8");
        String clients = request.getParameter("clients");
        String sp = request.getParameter("sp");
        String optionV = request.getParameter("str");
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(false);
            if(session == null){
                response.sendRedirect("index.html");  
            }else {
            ConnectDB db = new ConnectDB();
            Connection conn = db.getConn();
            String stmt;
            if (optionV.equals("All Accounts")){
                out.println("<h1>All Accounts List</h1><br>");
                out.println("<form action=\"SAcust\" method=\"POST\">");
                out.println("<input type=\"submit\" value=\"Customer\"></form>");
                out.println("<form action=\"SAadmin\" method=\"POST\">");
                out.println("<input type=\"submit\" value=\"Admin\"></form>");
                out.println("<form action=\"SAsp\" method=\"POST\">");
                out.println("<input type=\"submit\" value=\"Service Provider\"></form>");
                stmt = "select account_id, username, email, account_type, activate from accounts where status='a';";
                PreparedStatement ps = conn.prepareStatement(stmt);
                ResultSet rs = ps.executeQuery();
                String table = "    <table>"
                        + "     <tr>"
                        + "         <th align=\"right\">Username</th>"
                        + "         <th>Email</th>"
                        + "         <th>Account Type</th>"
                        + "         <th>Status</th>"
                        + "         <th>Activate/Deactivate Account</th>"
                        + "     </tr>";
                out.println(table);
                while(rs.next()){
                        out.println("           <tr>");
                        out.println("               <td align=\"right\">"+rs.getString("username")+"</td>");
                        out.println("               <td align=\"right\">"+rs.getString("email")+"</td>");
                        out.println("               <td align=\"right\">"+rs.getString("account_type")+"</td>");
                        out.println("               <td align=\"right\">"+rs.getString("activate")+"</td>");
                        out.println("               <td align=\"right\">"+"<form method=\"post\" action=\"SAActivateAccountServlet\"><input type='text' value=" + rs.getString("account_id") + " style='display:none;' name='hiddenid'><input type='submit' value='activate' id='A' name='activate'><input type='submit' value='deactivate' id='DA' name='deactivate'></form></td>");
                        out.println("           </tr>");
                }
                out.println("   </table>");
            }else if(optionV.equals("UAll Accounts")) {
                out.println("<h1>All Accounts List</h1><br>");
                out.println("<form action=\"SAcust\" method=\"POST\">");
                out.println("<input type=\"submit\" value=\"Customer\"></form>");
                out.println("<form action=\"SAadmin\" method=\"POST\">");
                out.println("<input type=\"submit\" value=\"Admin\"></form>");
                out.println("<form action=\"SAsp\" method=\"POST\">");
                out.println("<input type=\"submit\" value=\"Service Provider\"></form>");
                stmt = "select first_name, last_name,address, birthdate, contact_number from customer;";
                out.println("<h1>Customer User Information List</h1><br>");
                PreparedStatement ps = conn.prepareStatement(stmt);
                ResultSet rs = ps.executeQuery();
                String table = "    <table>"
                        + "     <tr>"
                        + "         <th>First Name</th>"
                        + "         <th>Last Name</th>"
                        + "         <th>Address</th>"
                        + "         <th>Birthdate</th>"
                        + "         <th>Contact Number</th>"
                        + "     </tr>";
                out.println(table);
                while(rs.next()){
                    out.println("           <tr>");
                    out.println("               <td>"+rs.getString("first_name")+"</td>");
                    out.println("               <td>"+rs.getString("last_name")+"</td>");
                    out.println("               <td>"+rs.getString("address")+"</td>");
                    out.println("               <td>"+rs.getString("birthdate")+"</td>");
                    out.println("               <td>"+rs.getString("contact_number")+"</td>");
                    out.println("           </tr>");
                }
                out.println("   </table>");
                
                stmt = "select admin_name, admin_contact from admin;";
                out.println("<h1>Admin User Information List</h1><br>");
                PreparedStatement ps2 = conn.prepareStatement(stmt);
                ResultSet rs2 = ps2.executeQuery();
                String table2 = "    <table>"
                        + "     <tr>"
                        + "         <th>Admin Name</th>"
                        + "         <th>Admin Contact</th>"
                        + "     </tr>";
                out.println(table2);
                while(rs2.next()){
                    out.println("           <tr>");
                    out.println("               <td>"+rs2.getString("admin_name")+"</td>");
                    out.println("               <td>"+rs2.getString("admin_contact")+"</td>");
                    out.println("           </tr>");
                }
                out.println("   </table>");
                stmt = "select provider_name, provider_contact, provider_address from service_provider;";
                out.println("<h1>Service Provider User Information List</h1><br>");
                PreparedStatement ps3 = conn.prepareStatement(stmt);
                ResultSet rs3 = ps3.executeQuery();
                String table3 = "    <table>"
                        + "     <tr>"
                        + "         <th>Service Provider Name</th>"
                        + "         <th>Service Provider Contact</th>"
                        + "         <th>Service Provider Address</th>"
                        + "     </tr>";
                out.println(table3);
                while(rs3.next()){
                    out.println("           <tr>");
                    out.println("               <td>"+rs3.getString("provider_name")+"</td>");
                    out.println("               <td>"+rs3.getString("provider_contact")+"</td>");
                    out.println("               <td>"+rs3.getString("provider_address")+"</td>");
                    out.println("           </tr>");
                }
            }else if(optionV.equals("Customers2")){
                stmt = "select account_id, first_name, last_name, address, birthdate, contact_number, email from accounts natural join customer where status='p';";
                out.println("<h1>Pending Customer Accounts</h1><br>");
                PreparedStatement ps = conn.prepareStatement(stmt);
                ResultSet rs = ps.executeQuery();
                String table = "    <table>"
                        + "     <tr>"
                        + "         <th>First Name</th>"
                        + "         <th>Last Name</th>"
                        + "         <th>Address</th>"
                        + "         <th>Birthdate</th>"
                        + "         <th>Contact Number</th>"
                        + "         <th>Accept/Reject Status </th>"
                        + "     </tr>";
                out.println(table);
                while(rs.next()){
                        out.println("           <tr>");
                        out.println("               <td>"+rs.getString("first_name")+"</td>");
                        out.println("               <td>"+rs.getString("last_name")+"</td>");
                        out.println("               <td>"+rs.getString("address")+"</td>");
                        out.println("               <td>"+rs.getString("birthdate")+"</td>");
                        out.println("               <td>"+rs.getString("contact_number")+"</td>");
                        out.println("               <td>"+"<form method=\"post\" action=\"SAAcceptAccountServlet\"><input type='text' value='" + rs.getString("email") + "' name='email'><input type='text' value=" + rs.getString("account_id") + " style='display:none;' name='hiddenid'><input type='submit' value='accept' name='accept'><input type='submit' value='reject' name='reject'></form></td>");
                        out.println("           </tr>");
                }
                out.println("   </table>");
            }else if(optionV.equals("Service Provider2")){
                stmt = "select account_id, provider_name, provider_address, provider_contact from accounts natural join service_provider where status='p';";
                out.println("<h1>Pending Service Provider Accounts</h1><br>");
                PreparedStatement ps = conn.prepareStatement(stmt);
                ResultSet rs = ps.executeQuery();
                String table = "    <table>"
                        + "     <tr>"
                        + "         <th>Name</th>"
                        + "         <th>Address</th>"
                        + "         <th>Contact Number</th>"
                        + "         <th>Accept/Reject Status </th>"
                        + "     </tr>";
                out.println(table);
                    
                while(rs.next()){
                        out.println("           <tr>");
                        out.println("               <td>"+rs.getString("provider_name")+"</td>");
                        out.println("               <td>"+rs.getString("provider_address")+"</td>");
                        out.println("               <td>"+rs.getString("provider_contact")+"</td>");
                        out.println("               <td>"+"<form method=\"post\" action=\"SAAcceptProviderServlet\"><input type='text' value=" + rs.getString("account_id") + " style='display:none;' name='hiddenid'><input type='submit' value='accept' name='accept'><input type='submit' value='reject' name='reject'></form></td>");
                        out.println("           </tr>");
                }
                
                out.println("   </table>");
            }else if(optionV.equals("Transaction")){
                stmt = "select first_name, last_name, item_name, amount, quantity, date_rented, date_due, provider_name from customer join transaction on customer.customer_id = transaction.customer_id join items on items.item_id = transaction.item_id join service_provider on items.provider_id = service_provider.provider_id;";
                out.println("<h1>Transactions</h1><br>");
                PreparedStatement ps = conn.prepareStatement(stmt);
                ResultSet rs = ps.executeQuery();
                String table = "    <table>"
                        + "     <tr>"
                        + "         <th>Customer Name</th>"
                        + "         <th>Item Name</th>"
                        + "         <th>Amounnt</th>"
                        + "         <th>Quantity</th>"
                        + "         <th>Service Provider</th>"
                        + "         <th>Date Rented</th>"
                        + "         <th>Date Due</th>"
                        + "     </tr>";
                out.println(table);
                while(rs.next()){
                        out.println("           <tr>");
                        out.println("               <td>"+rs.getString("last_name")+","+rs.getString("first_name")+"</td>");
                        out.println("               <td>"+rs.getString("item_name")+"</td>");
                        out.println("               <td>"+rs.getString("amount")+"</td>");
                        out.println("               <td>"+rs.getString("quantity")+"</td>");
                        out.println("               <td>"+rs.getString("provider_name")+"</td>");
                        out.println("               <td>"+rs.getString("date_rented")+"</td>");
                        out.println("               <td>"+rs.getString("date_due")+"</td>");
                        out.println("           </tr>");
                }
                out.println("   </table>");
            }
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/pagefragments/SAfooter.html");
            rd.include(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SAAdminServlet.class.getName()).log(Level.SEVERE, null, ex);
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
