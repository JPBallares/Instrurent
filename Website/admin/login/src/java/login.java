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
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
/**
 *
 * @author AWMIKO
 */
public class login extends HttpServlet {

   private Connection conn;
    private Statement statement;
    private PreparedStatement ps;
    private ResultSet resultSet;
    private String sql;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String _username=request.getParameter("uname");
            String _password=request.getParameter("pass");
          try{
              if(_username !=null ){
                  
                  Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
                  conn=DriverManager.getConnection("jdbc:derby://localhost:1527/sample","root","");
                  String Query="select username,password from accounts where type= admin and username=? and password=?";
                  ps = conn.prepareStatement(sql);
                  ps.setString(1, _username);
                  ps.setString(2, _password);
                  ResultSet rs = ps.executeQuery();
                  if(rs.next()){
                      
                      response.sendRedirect("index.html");
                  }else{
                      
                      out.println("username or password incorrect");
                  }
              }
              
          }catch(Exception ex){
              out.println("Exception :"+ex.getMessage());
          }
        
        }
        
    }
    
}
