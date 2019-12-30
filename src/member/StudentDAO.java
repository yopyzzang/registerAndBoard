package member;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StudentDAO {
    private Connection getConnection(){
        Connection con = null;
        try {
            Context init = new InitialContext();
            DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/myOracle");
            con = ds.getConnection();
        } catch (SQLException e) {
            System.out.println("Connection 생성 실패");
        } catch (NamingException e) {
            System.out.println("Connection 생성 실패");
        }
        return con;
    }

    public boolean idCheck(String id){
        boolean result = true;
        Connection con = null;
        PreparedStatement psmt=null;
        ResultSet rs = null;
        try {
            con = getConnection();
            psmt = con.prepareStatement("select * from student where id = ?");
            psmt.setString(1,id);
            rs = psmt.executeQuery();
            if(!rs.next()){
                result=false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            try {
            if(rs !=null) {
                rs.close();
            }if(psmt!=null){
                psmt.close();
                }
            if(con!=null){
                con.close();
            }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
