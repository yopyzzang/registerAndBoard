package member;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class StudentDAO {
    private Connection getConnection(){
        Connection con = null;
        try {
            Context init = new InitialContext();
            DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/myOracle");
            con = ds.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Connection1 생성 실패");
        } catch (NamingException e) {
            e.printStackTrace();
            System.out.println("Connection2 생성 실패");
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

    public Vector<ZipCodeVO> zipCodeRead(String dong){
        Connection con = null;
        PreparedStatement psmt = null;
        ResultSet rs =null;
        Vector<ZipCodeVO> vecList = new Vector<ZipCodeVO>();
        try{
            con = getConnection();
            String strQuery = "select * from zipcode where dong like '"+dong +"%'";
            psmt = con.prepareStatement(strQuery);
            rs = psmt.executeQuery();
            while (rs.next()){
                ZipCodeVO tempZipcode = new ZipCodeVO();
                tempZipcode.setZipcode(rs.getString("zipcode"));
                tempZipcode.setSido(rs.getString("sido"));
                tempZipcode.setGugun(rs.getString("gugun"));
                tempZipcode.setDong(rs.getString("dong"));
                tempZipcode.setRi(rs.getString("ri"));
                tempZipcode.setBunji(rs.getString("bunji"));
                vecList.addElement(tempZipcode);
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
        return vecList;
    }

    public boolean memberInsert(StudentVO vo){
        Connection con =null;
        PreparedStatement psmt = null;
        boolean flag = false;
        try {
            con=getConnection();
            String strQuery = "insert into student values(?,?,?,?,?,?,?,?,?,?)";
            psmt=con.prepareStatement(strQuery);
            psmt.setString(1,vo.getId());
            psmt.setString(2,vo.getPass());
            psmt.setString(3,vo.getName());
            psmt.setString(4,vo.getPhone1());
            psmt.setString(5,vo.getPhone2());
            psmt.setString(6,vo.getPhone3());
            psmt.setString(7,vo.getEmail());
            psmt.setString(8,vo.getZipcode());
            psmt.setString(9,vo.getAddress1());
            psmt.setString(10,vo.getAddress2());
            int count = psmt.executeUpdate();
            if(count>0) flag = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            try {
                if(psmt!=null){
                    psmt.close();
                }
                if(con!=null){
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return flag;
    }
}
