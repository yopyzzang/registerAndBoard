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
    private static StudentDAO instance = null;
    private StudentDAO(){}
    public static StudentDAO getInstance(){
        if(instance == null) {
            synchronized (StudentDAO.class){
                instance = new StudentDAO();
            }
        }
        return instance;
    }
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

    public int loginCheck(String id , String pass){
        Connection con = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        int check = -1;

        try{
            con=getConnection();
            String strQuery = "select pass from student where id = ?";
            psmt = con.prepareStatement(strQuery);
            psmt.setString(1,id);
            rs = psmt.executeQuery();
            if(rs.next()){
                String dbPass = rs.getString("pass");
                //System.out.println(dbPass);
                if(pass.equals(dbPass)){
                    check=1;
                }else {
                    check=0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            try{
            if(rs!=null)
                rs.close();
            if(psmt!=null)
                psmt.close();
            if(con!=null){
                con.close();
            }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return check;
    }

    public StudentVO getMember(String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StudentVO vo = null;
        try {
            con = getConnection();
            String strSQL="select * from student where id = ?";
            pstmt = con.prepareStatement(strSQL);
            pstmt.setString(1,id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                vo = new StudentVO();
                vo.setId(rs.getString("id"));
                vo.setPass(rs.getString("pass"));
                vo.setName(rs.getString("name"));
                vo.setPhone1(rs.getString("phone1"));
                vo.setPhone2(rs.getString("phone2"));
                vo.setPhone3(rs.getString("phone3"));
                vo.setEmail(rs.getString("email"));
                vo.setZipcode(rs.getString("zipcode"));
                vo.setAddress1(rs.getString("address1"));
                vo.setAddress2(rs.getString("address2"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            try{
                if(rs!=null)
                    rs.close();
                if(pstmt!=null)
                    pstmt.close();
                if(con!=null){
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return vo;
    }

    public void updateMember(StudentVO vo){
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            con=getConnection();
            pstmt = con.prepareStatement("update student set pass=?,phone1=?,phone2=?,phone3=?,email=?,zipcode=?,address1=?,address2=? where id=?");
            pstmt.setString(1,vo.getPass());
            pstmt.setString(2,vo.getPhone1());
            pstmt.setString(3,vo.getPhone2());
            pstmt.setString(4,vo.getPhone3());
            pstmt.setString(5,vo.getEmail());
            pstmt.setString(6,vo.getZipcode());
            pstmt.setString(7,vo.getAddress1());
            pstmt.setString(8,vo.getAddress2());
            pstmt.setString(9,vo.getId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            try {
                if (con != null)
                    con.close();
                if (pstmt != null)
                    pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public int deleteMember(String id , String pass){
        Connection con=null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String dbPass = "";
        int result = -1;
        try {
            con = getConnection();
            psmt = con.prepareStatement("select pass from student where id = ?");
            psmt.setString(1,id);
            rs = psmt.executeQuery();
            if(rs.next()){
                dbPass=rs.getString("pass");
                if(dbPass.equals(pass)){
                    psmt = con.prepareStatement("delete from student where id = ?");
                    psmt.setString(1,id);
                    psmt.executeUpdate();
                    result = 1;
                }else {
                    result=0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            try {
                if (rs != null)
                    rs.close();
                if (psmt != null)
                    psmt.close();
                if (con != null)
                    con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
