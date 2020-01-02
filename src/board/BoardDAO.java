package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    private static BoardDAO instance = null;
    private BoardDAO(){
    }
    public static BoardDAO getInstance(){
        if(instance==null){
            synchronized (BoardDAO.class){
                instance=new BoardDAO();
            }
        }
        return instance;
    }

    public void insertArticle(BoardVO article){
        ConnectionUtil connectionUtil = new ConnectionUtil();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        int num = article.getNum();
        int ref = article.getRef();
        int step = article.getStep();
        int depth = article.getDepth();
        int number=0;
        String sql="";
        try {
            connection = ConnectionUtil.getConnection();
            preparedStatement = connection.prepareStatement("select max(num) from board");
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                number = resultSet.getInt(1)+1;
            }else {
                number=1;
            }
            if(num!=0){
                sql="update board set step=step+1 where ref=? and step>?";
                preparedStatement=connection.prepareStatement(sql);
                preparedStatement.setInt(1,ref);
                preparedStatement.setInt(2,step);
                preparedStatement.executeUpdate();
                step=step+1;
                depth=depth+1;
            }else {
                ref=number;
                step=0;
                depth=0;
            }
            sql="insert into board(num,writer,email,subject,pass,regdate,ref,step,depth,content,ip) values(board_seq.nextval,?,?,?,?,?,?,?,?,?,?)";
            preparedStatement=connection.prepareStatement(sql);
            preparedStatement.setString(1,article.getWriter());
            preparedStatement.setString(2,article.getEmail());
            preparedStatement.setString(3,article.getSubject());
            preparedStatement.setString(4,article.getPass());
            preparedStatement.setTimestamp(5,article.getRegdate());
            preparedStatement.setInt(6,ref);
            preparedStatement.setInt(7,step);
            preparedStatement.setInt(8,depth);
            preparedStatement.setString(9,article.getContent());
            preparedStatement.setString(10,article.getIp());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            connectionUtil.disconnection(connection,preparedStatement,resultSet);
        }
    }

    public int getArticleCount(){
        ConnectionUtil connectionUtil = new ConnectionUtil();
        Connection connection=null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        int x = 0;
        try {
            connection=ConnectionUtil.getConnection();
            preparedStatement=connection.prepareStatement("select count(*) from board");
            resultSet=preparedStatement.executeQuery();
            if(resultSet.next()){
                x=resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            connectionUtil.disconnection(connection,preparedStatement,resultSet);
        }
        return x;
    }

    public List<BoardVO> getArticles(){
        ConnectionUtil connectionUtil = new ConnectionUtil();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        List<BoardVO> articleList = null;
        try {
            connection = ConnectionUtil.getConnection();
            /**/
            preparedStatement = connection.prepareStatement("select * from board order by num desc");
            resultSet=preparedStatement.executeQuery();

            if(resultSet.next()){
                articleList = new ArrayList<BoardVO>();
                do{
                    BoardVO article = new BoardVO();
                    article.setNum(resultSet.getInt("num"));
                    article.setWriter(resultSet.getString("writer"));
                    article.setEmail(resultSet.getString("email"));
                    article.setSubject(resultSet.getString("subject"));
                    article.setPass(resultSet.getString("pass"));
                    article.setRegdate(resultSet.getTimestamp("regdate"));
                    article.setReadcount(resultSet.getInt("readcount"));
                    article.setRef(resultSet.getInt("ref"));
                    article.setStep(resultSet.getInt("step"));
                    article.setDepth(resultSet.getInt("depth"));
                    article.setContent(resultSet.getString("content"));
                    article.setIp(resultSet.getString("ip"));
                    articleList.add(article);
                }while (resultSet.next());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            connectionUtil.disconnection(connection,preparedStatement,resultSet);
        }
        return articleList;
    }

    public BoardVO getArticle(int num){
        ConnectionUtil connectionUtil = new ConnectionUtil();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        BoardVO article = null;
        try{
            connection=ConnectionUtil.getConnection();
            preparedStatement=connection.prepareStatement("update board set readcount=readcount+1 where num =?");
            preparedStatement.setInt(1,num);
            preparedStatement.executeUpdate();
            preparedStatement=connection.prepareStatement("select * from board where num=?");
            preparedStatement.setInt(1,num);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                article = new BoardVO();
                article.setNum(resultSet.getInt("num"));
                article.setWriter(resultSet.getString("writer"));
                article.setEmail(resultSet.getString("email"));
                article.setSubject(resultSet.getString("subject"));
                article.setPass(resultSet.getString("pass"));
                article.setRegdate(resultSet.getTimestamp("regdate"));
                article.setReadcount(resultSet.getInt("readcount"));
                article.setRef(resultSet.getInt("ref"));
                article.setStep(resultSet.getInt("step"));
                article.setDepth(resultSet.getInt("depth"));
                article.setContent(resultSet.getString("content"));
                article.setIp(resultSet.getString("ip"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            connectionUtil.disconnection(connection,preparedStatement,resultSet);
        }
        return article;
    }

}
