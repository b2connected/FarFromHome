package tgl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import bbs.Bbs;

public class TGLDAO {
	//	dao : DB 접근 객체의 약자
	
	private Connection conn;
	
	private ResultSet rs;
	
	public TGLDAO() {
		
		//mysql 정보에 접근하는 부분
		try {
			
			String dbURL = "jdbc:mysql://localhost:3306/UserChat?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		}	catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//tglID to go list 번호 가져오는 함수
	
	public int getNext() {
		String SQL = "SELECT tglID FROM tgl ORDER BY tglID DESC";
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
	
	// to go list 작성하는 함수
	public int write(String tglTitle, String userID) {
		
		String SQL = "INSERT INTO NOTICE VALUES(?, ?, ?, ?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, tglTitle);
			pstmt.setString(3, userID);
			pstmt.setInt(4, 1);
			
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
public ArrayList<TGL> getList(){
		
		String SQL = "SELECT * FROM tgl WHERE tglID <? AND tglAvailable = 1 ORDER BY tglID DESC";
		
		ArrayList<TGL> list = new ArrayList<TGL>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				TGL tgl = new TGL();
				tgl.setTglID(rs.getInt(1));
				tgl.setTglTitle(rs.getString(2));
				tgl.setUserID(rs.getString(3));
				tgl.setTglAvailable(rs.getInt(4));
				list.add(tgl);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
		
	}
	
	  //글 내용 불러오는 함수 추가 
	public TGL getTGL(int tglID) { String SQL =
	  "SELECT * FROM tgl WHERE tglID = ?"; 
	
	try { 
		PreparedStatement pstmt = conn.prepareStatement(SQL); 
		pstmt.setInt(1, tglID); 
		rs = pstmt.executeQuery(); 
		if (rs.next()) { 
			TGL tgl = new TGL();
			tgl.setTglID(rs.getInt(1)); 
			tgl.setTglTitle(rs.getString(2));
			tgl.setUserID(rs.getString(3));
			tgl.setTglAvailable(rs.getInt(4));
			
			return tgl; 
			} 
		} catch (Exception e) { 
			e.printStackTrace(); 
			} 
	return null;
	  }
	 
		
		//삭제 함수
		public int delete(int tglID) {
			String SQL = "UPDATE tgl SET tglAvailable = 0 WHERE tglID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);   
				pstmt.setInt(1, tglID);
				return pstmt.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; // 데이터베이스 오류
		}

}
