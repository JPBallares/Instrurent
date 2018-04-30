
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author AWMIKO
 */
public class Controller {
    Connection con;
    public Connection getCon(){
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            DriverManager.getConnection("jdbc:derby://localhost:1527/sample","root","");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
            
        
        return con;
    }
    
}
