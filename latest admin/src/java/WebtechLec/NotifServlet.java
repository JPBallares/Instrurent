package WebtechLec;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/NotifServlet"})
public class NotifServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ConnectDB db = new ConnectDB();
            Connection conn = db.getConn();
            String stmt = "select count(account_id) from accounts where status = 'p';";
            PreparedStatement ps = conn.prepareStatement(stmt);
            ResultSet rs = ps.executeQuery();
            
            rs.next();
            int pending = rs.getInt(1);
            
            PrintWriter out = response.getWriter();
            out.println(pending);
        } catch (SQLException ex) {
            Logger.getLogger(NotifServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
