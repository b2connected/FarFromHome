package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
//import com.oreilly.servlet.MultipartRequest;
//import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.jsp.JspWriter;
//import javax.servlet.jsp.PageContext;


public class BbsDAO {
	//	dao : DB 접근 객체의 약자
	
	private Connection conn; // connection:db에 접근하게 해주는 객체
	//private PreparedStatement pstmt;
	private ResultSet rs;
	
	// mysql 처리 부분
	public BbsDAO(){
		try {
			
			String dbURL = "jdbc:mysql://localhost:3306/UserChat?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		}catch(Exception e) {	
			e.printStackTrace();
		}
	}
	
	//현재의 시간을 가져오는 함수
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";//
	}
	
	//bbsID 게시글 번호 가져오는 함수
	
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;//첫 번째 게시물인 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; //DB 오류
		
	}
	
	//실제로 글을 작성하는 함수
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		
		String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			//pstmt.setString(7, filename);
			//pstmt.setInt(8, filesize);
			
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	//글 목록 가져오는 소스코드!
	//BbsDao.java에 리스트를 담아 반환해주는 ArrayList<Bbs> 함수 생성
	
	public ArrayList<Bbs> getList(int pageNumber){
		
		String SQL = "SELECT * FROM BBS WHERE bbsID <? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1) * 10);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
			//	bbs.setBbsFileName(rs.getString(7));
			//	bbs.setBbsFileSize(rs.getInt(8));
				list.add(bbs);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
		
	}
	
	//10 단위 페이징 처리를 위한 함수
	public boolean nextPage (int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
	//	ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; 		
	}
	//글 내용 불러오는 함수 추가
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
			//	bbs.setBbsFileName(rs.getString(7));
			//	bbs.setBbsFileSize(rs.getInt(8));

				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;

	}
	
	//수정한 내용 업데이트 하는 함수
	public int update(int bbsID, String bbsTitle, String bbsContent) {
			String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, bbsTitle);
				pstmt.setString(2, bbsContent);
				pstmt.setInt(3, bbsID);
		//		pstmt.setString(4,  filename);
			//	pstmt.setInt(5, filesize);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; // 데이터베이스 오류
		}
	
	//삭제 함수
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);   
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	//게시글 검색하는 함수
	public ArrayList<Bbs> getList2(int pageNumber, String search){
		String SQL = "SELECT * FROM BBS WHERE bbsID <? AND bbsAvailable = 1 AND userID = ? ORDER BY bbsID DESC LIMIT 10";
		
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1) * 10);
			pstmt.setString(2, search);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
			//	bbs.setBbsFileName(rs.getString(7));
			//	bbs.setBbsFileSize(rs.getInt(8));
				list.add(bbs);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
		
	}


}
