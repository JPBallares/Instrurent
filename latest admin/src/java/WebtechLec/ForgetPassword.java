package WebtechLec;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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

@WebServlet(name = "ForgetPassword", urlPatterns = {"/ForgetPassword"})
public class ForgetPassword extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NoSuchAlgorithmException {
        response.setContentType("text/html;charset=UTF-8");
        ConnectDB db = new ConnectDB();
        Connection conn = db.getConn();
        try (PrintWriter out = response.getWriter()) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmpass = request.getParameter("cpass");
            String query;
            query = "select * from accounts;";
            PreparedStatement p2 = conn.prepareStatement(query);
            ResultSet rs = p2.executeQuery();
             
            while (rs.next()) {
                if (rs.getString("email").equals(email)) {
                    if(confirmpass.equals(password) ){
                    password = sha1(password);
                    String query2 = "UPDATE `tenterent`.`accounts` SET `email`='" + email + "', `password`='" + password + "' WHERE `account_id`='" + rs.getString("account_id") + "';";
                    p2.executeUpdate(query2);
                    RequestDispatcher rd = request.getRequestDispatcher("index.html");
                    rd.include(request, response);
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('PASSWORD SUCCESSFULLY CHANGED.');");
                    out.println("</script>"); 
                    }else{
                        RequestDispatcher rd = request.getRequestDispatcher("forgetpassword.html");
                        rd.include(request, response);
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('PASSWORD DO NOT MATCH.');");
                        out.println("</script>");
                        break;
                    }

                }
            }
                        RequestDispatcher rd = request.getRequestDispatcher("forgetpassword.html");
                        rd.include(request, response);
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('EMAIL INCORRECT.');");
                        out.println("</script>");
            
            

        }
    }
    
    
    public String sha1(String input) throws NoSuchAlgorithmException {
        MessageDigest mDigest;
        mDigest = MessageDigest.getInstance("SHA1");
        byte[] result = mDigest.digest(input.getBytes());
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < result.length; i++) {
            sb.append(Integer.toString((result[i] & 0xff) + 0x100, 16).substring(1));
        }

        return sb.toString();
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
            try {
                processRequest(request, response);
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(ForgetPassword.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ForgetPassword.class.getName()).log(Level.SEVERE, null, ex);
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
            try {
                processRequest(request, response);
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(ForgetPassword.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ForgetPassword.class.getName()).log(Level.SEVERE, null, ex);
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
