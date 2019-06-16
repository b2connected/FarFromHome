package notice;

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


public class NoticeDAO {
	//	dao : DB 접근 객체의 약자
	
	private Connection conn; // connection:db에 접근하게 해주는 객체
	//private PreparedStatement pstmt;
	private ResultSet rs;
	
	// mysql 처리 부분
	public NoticeDAO(){
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
		String SQL = "SELECT noticeID FROM Notice ORDER BY NoticeID DESC";
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
	
	public int write(String noticeTitle, String userID, String noticeContent) {
		
		String SQL = "INSERT INTO notice VALUES(?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, noticeTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, noticeContent);
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
	
	public ArrayList<Notice> getList(int pageNumber){
		
		String SQL = "SELECT * FROM Notice WHERE noticeID <? AND noticeAvailable = 1 ORDER BY noticeID DESC LIMIT 10";
		
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1) * 10);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Notice notice = new Notice();
				notice.setNoticeID(rs.getInt(1));
				notice.setNoticeTitle(rs.getString(2));
				notice.setUserID(rs.getString(3));
				notice.setNoticeDate(rs.getString(4));
				notice.setNoticeContent(rs.getString(5));
				notice.setNoticeAvailable(rs.getInt(6));
			//	bbs.setBbsFileName(rs.getString(7));
			//	bbs.setBbsFileSize(rs.getInt(8));
				list.add(notice);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
		
	}
	
	//10 단위 페이징 처리를 위한 함수
	public boolean nextPage (int pageNumber) {
		String SQL = "SELECT * FROM Notice WHERE noticeID < ? AND noticeAvailable = 1 ORDER BY noticeID DESC LIMIT 10";
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
	public Notice getNotice(int noticeID) {
		String SQL = "SELECT * FROM Notice WHERE noticeID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, noticeID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Notice notice = new Notice();
				notice.setNoticeID(rs.getInt(1));
				notice.setNoticeTitle(rs.getString(2));
				notice.setUserID(rs.getString(3));
				notice.setNoticeDate(rs.getString(4));
				notice.setNoticeContent(rs.getString(5));
				notice.setNoticeAvailable(rs.getInt(6));
			//	bbs.setBbsFileName(rs.getString(7));
			//	bbs.setBbsFileSize(rs.getInt(8));

				return notice;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;

	}
	
	//수정한 내용 업데이트 하는 함수
	public int update(int noticeID, String noticeTitle, String noticeContent) {
			String SQL = "UPDATE Notice SET noticeTitle = ?, noticeContent = ? WHERE noticeID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, noticeTitle);
				pstmt.setString(2, noticeContent);
				pstmt.setInt(3, noticeID);
		//		pstmt.setString(4,  filename);
			//	pstmt.setInt(5, filesize);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; // 데이터베이스 오류
		}
	
	//삭제 함수
	public int delete(int noticeID) {
		String SQL = "UPDATE Noitce SET noticeAvailable = 0 WHERE noticeID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);   
			pstmt.setInt(1, noticeID);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	//게시글 검색하는 함수
	public ArrayList<Notice> getList2(int pageNumber, String search){
		String SQL = "SELECT * FROM Notice WHERE noticeID <? AND noticeAvailable = 1 AND userID = ? ORDER BY noticeID DESC LIMIT 10";
		
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1) * 10);
			pstmt.setString(2, search);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Notice notice = new Notice();
				notice.setNoticeID(rs.getInt(1));
				notice.setNoticeTitle(rs.getString(2));
				notice.setUserID(rs.getString(3));
				notice.setNoticeDate(rs.getString(4));
				notice.setNoticeContent(rs.getString(5));
				notice.setNoticeAvailable(rs.getInt(6));
			//	bbs.setBbsFileName(rs.getString(7));
			//	bbs.setBbsFileSize(rs.getInt(8));
				list.add(notice);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
		
	}


}
/*
 * package notice;
 * 
 * import java.sql.Connection; import java.sql.DriverManager; import
 * java.sql.PreparedStatement; import java.sql.ResultSet; import java.util.*;
 * 
 * 
 * public class NoticeDAO { //bbs와 마찬가지로 작동한다.
 * 
 * private Connection conn;
 * 
 * private ResultSet rs;
 * 
 * public NoticeDAO() {
 * 
 * //mysql 정보에 접근하는 부분 try {
 * 
 * String dbURL = "jdbc:mysql://localhost:3306/UserChat?serverTimezone=UTC";
 * String dbID = "root"; String dbPassword = "1234";
 * Class.forName("com.mysql.cj.jdbc.Driver"); conn =
 * DriverManager.getConnection(dbURL, dbID, dbPassword);
 * 
 * } catch(Exception e) { e.printStackTrace(); } }
 * 
 * // 시간을 가져오는 함수
 * 
 * public String getDate() { String SQL = "SELECT NOW()"; try {
 * PreparedStatement pstmt = conn.prepareStatement(SQL); rs =
 * pstmt.executeQuery(); if(rs.next()) { return rs.getString(1); }
 * }catch(Exception e) { e.printStackTrace(); } return "";// }
 * 
 * //noticeID 게시글 번호 가져오는 함수
 * 
 * public int getNext() { String SQL =
 * "SELECT noticeID FROM NOTICE ORDER BY noticeID DESC"; try { PreparedStatement
 * pstmt = conn.prepareStatement(SQL); rs = pstmt.executeQuery(); if(rs.next())
 * { return rs.getInt(1)+1; } return 1;//첫 번째 게시물인 경우 }catch(Exception e) {
 * e.printStackTrace(); }
 * 
 * return -1; //DB 오류
 * 
 * }
 * 
 * //실제로 글을 작성하는 함수 public int write(String noticeTitle, String userID, String
 * noticeContent) {
 * 
 * String SQL = "INSERT INTO NOTICE VALUES(?, ?, ?, ?, ?, ?)";
 * 
 * try { PreparedStatement pstmt = conn.prepareStatement(SQL); pstmt.setInt(1,
 * getNext()); pstmt.setString(2, noticeTitle); pstmt.setString(3, userID);
 * pstmt.setString(4, getDate()); pstmt.setString(5, noticeContent);
 * pstmt.setInt(6, 1);
 * 
 * return pstmt.executeUpdate();
 * 
 * } catch(Exception e) { e.printStackTrace(); }
 * 
 * return -1; }
 * 
 * //공지 목록을 가져오는 부분 //noticeDAO.java에 리스트를 담아 반환해주는 ArrayList<notice>함수 생성
 * 
 * public ArrayList<Notice> getList(int pageNumber){
 * 
 * String SQL =
 * "SELECT * FROM NOTICE WHERE noticeID <? AND noticeAvailable = 1 ORDER BY noticeID DESC LIMIT 10"
 * ; ArrayList<Notice> list = new ArrayList<Notice>();
 * 
 * try { PreparedStatement pstmt = conn.prepareStatement(SQL); pstmt.setInt(1,
 * getNext()-(pageNumber-1)*10); rs = pstmt.executeQuery();
 * 
 * while(rs.next()) { Notice notice = new Notice();
 * notice.setNoticeID(rs.getInt(1)); notice.setNoticeTitle(rs.getString(2));
 * notice.setUserID(rs.getString(3)); notice.setNoticeDate(rs.getString(4));
 * notice.setNoticeContent(rs.getString(5));
 * notice.setNoticeAvailable(rs.getInt(6)); list.add(notice); }
 * 
 * } catch (Exception e) { e.printStackTrace(); }
 * 
 * return list;
 * 
 * }
 * 
 * //10 단위 페이징 처리를 위한 함수 public boolean nextPage (int pageNumber) { String SQL =
 * "SELECT * FROM NOTICE WHERE noticeID < ? AND noticeAvailable = 1 ORDER BY noticeID DESC LIMIT 10"
 * ; // ArrayList<Notice> list = new ArrayList<Notice>(); try {
 * PreparedStatement pstmt = conn.prepareStatement(SQL); pstmt.setInt(1,
 * getNext() - (pageNumber -1) * 10); rs = pstmt.executeQuery(); if (rs.next())
 * { return true; } } catch (Exception e) { e.printStackTrace(); } return false;
 * }
 * 
 * //글 내용 불러오는 함수 추가 public Notice getNotice(int noticeID) { String SQL =
 * "SELECT * FROM NOTICE WHERE noticeID = ?"; try { PreparedStatement pstmt =
 * conn.prepareStatement(SQL); pstmt.setInt(1, noticeID); rs =
 * pstmt.executeQuery(); if (rs.next()) { Notice notice = new Notice();
 * notice.setNoticeID(rs.getInt(1)); notice.setNoticeTitle(rs.getString(2));
 * notice.setUserID(rs.getString(3)); notice.setNoticeDate(rs.getString(4));
 * notice.setNoticeContent(rs.getString(5));
 * notice.setNoticeAvailable(rs.getInt(6));
 * 
 * return notice; } } catch (Exception e) { e.printStackTrace(); } return null;
 * 
 * }
 * 
 * //수정한 내용 업데이트 하는 함수 public int update(int noticeID, String noticeTitle,
 * String noticeContent) { String SQL =
 * "UPDATE NOTICE SET noticeTitle = ?, noticeContent = ? WHERE noticeID = ?";
 * try { PreparedStatement pstmt = conn.prepareStatement(SQL);
 * pstmt.setString(1, noticeTitle); pstmt.setString(2, noticeContent);
 * pstmt.setInt(3, noticeID); return pstmt.executeUpdate(); } catch (Exception
 * e) { e.printStackTrace(); } return -1; // 데이터베이스 오류 }
 * 
 * //삭제 함수 public int delete(int noticeID) { String SQL =
 * "UPDATE NOTICE SET noticeAvailable = 0 WHERE noticeID = ?"; try {
 * PreparedStatement pstmt = conn.prepareStatement(SQL); pstmt.setInt(1,
 * noticeID); return pstmt.executeUpdate();
 * 
 * } catch (Exception e) { e.printStackTrace(); } return -1; // 데이터베이스 오류 }
 * 
 * //게시글을 작성자를 검색했을때 필터링 public ArrayList<Notice> getList2(int pageNumber,
 * String search){
 * 
 * String SQL =
 * "SELECT * FROM NOTICE WHERE noticeID <? AND noticeAvailable = 1 AND userID = ? ORDER BY noticeID DESC LIMIT 10"
 * ; ArrayList<Notice> list = new ArrayList<Notice>();
 * 
 * try { PreparedStatement pstmt = conn.prepareStatement(SQL); pstmt.setInt(1,
 * getNext()-(pageNumber-1)*10); pstmt.setString(2, search); rs =
 * pstmt.executeQuery();
 * 
 * while(rs.next()) { Notice notice = new Notice();
 * notice.setNoticeID(rs.getInt(1)); notice.setNoticeTitle(rs.getString(2));
 * notice.setUserID(rs.getString(3)); notice.setNoticeDate(rs.getString(4));
 * notice.setNoticeContent(rs.getString(5));
 * notice.setNoticeAvailable(rs.getInt(6)); list.add(notice); }
 * 
 * } catch (Exception e) { e.printStackTrace(); }
 * 
 * return list;
 * 
 * }
 * 
 * 
 * }
 */