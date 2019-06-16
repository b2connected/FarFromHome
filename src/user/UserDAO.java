package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDAO {

	DataSource dataSource;
	private Connection conn;
	private ResultSet rs;

	public UserDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/UserChat");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int login(String userID, String userPassword) {
		Connection conn = null;
		PreparedStatement pstmt = null;// preparedstatement는 sql인젝션 공격을 방어해주고 안정적으로 실행할수있도록 해준다.
		ResultSet rs = null;
		String SQL = "SELECT * FROM USER WHERE userID=?";

		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString("userPassword").equals(userPassword)) {
					return 1;// 로그인 성공
				}
				return 2;// 비밀번호가 틀림
			} else {
				return 0;// 해당 사용자가 존재하지 않음
			}
		} catch (Exception e) {// 오류가 발생하면 오류를 출력하고
			e.printStackTrace();
		} finally {// sql실행이 끝나면 모든 리소를 종료
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 데이터베이스 오류
	}

	public int registerCheck(String userID) {// 중복체크
		Connection conn = null;
		PreparedStatement pstmt = null;// preparedstatement는 sql인젝션 공격을 방어해주고 안정적으로 실행할수있도록 해준다.
		ResultSet rs = null;
		String SQL = "SELECT * FROM USER WHERE userID=?";

		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next() || userID.equals("")) {
				return 0;// 이미 존재하는 회원
			} else {
				return 1;// 가입가능한 회원 아이디
			}
		} catch (Exception e) {// 오류가 발생하면 오류를 출력하고
			e.printStackTrace();
		} finally {// sql실행이 끝나면 모든 리소를 종료
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 데이터베이스 오류
	}

	public int register(String userID, String userPassword, String userName, String userAge, String userGender,
			String userEmail, String userProfile  ,String userEmailHash ,String userEmailChecked ) {
		Connection conn = null;
		PreparedStatement pstmt = null;// preparedstatement는 sql인젝션 공격을 방어해주고 안정적으로 실행할수있도록 해준다.
		String SQL = "INSERT INTO USER VALUES(?,?,?,?,?,?,?,?,false)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			pstmt.setString(3, userName);
			pstmt.setInt(4, Integer.parseInt(userAge));
			pstmt.setString(5, userGender);
			pstmt.setString(6, userEmail);
			pstmt.setString(7, userProfile);
			pstmt.setString(8, userEmailHash);
			return pstmt.executeUpdate();
		} catch (Exception e) {// 오류가 발생하면 오류를 출력하고
			e.printStackTrace();
		} finally {// sql실행이 끝나면 모든 리소를 종료
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 데이터베이스 오류
	}
	
	public String getUserEmail(String userID) {
	
		String SQL = "SELECT userEmail FROM USER WHERE userID = ?";
		PreparedStatement pstmt = null;
		String str= "1";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			/* PreparedStatement pstmt = conn.prepareStatement(SQL); */
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				
			  str =rs.getString("userEmail"); // 이메일 주소 반환
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {// sql실행이 끝나면 모든 리소를 종료
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return str; // 데이터베이스 오류
	}
	
	public boolean getUserEmailChecked(String userID) {
		String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getBoolean(1); // 이메일 등록 여부 반환
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false; // 데이터베이스 오류
	}
	
	public boolean setUserEmailChecked(String userID) {
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";
		try {
			conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true; // 이메일 등록 설정 성공
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false; // 이메일 등록 설정 실패
	}

	public UserDTO getUser(String userID) {// 중복체크
		UserDTO user = new UserDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;// preparedstatement는 sql인젝션 공격을 방어해주고 안정적으로 실행할수있도록 해준다.
		ResultSet rs = null;
		String SQL = "SELECT * FROM USER WHERE userID=?";

		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				user.setUserID(userID);
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserName(rs.getString("userName"));
				user.setUserAge(rs.getInt("userAge"));
				user.setUserGender(rs.getString("userGender"));
				user.setUserEmail(rs.getString("userEmail"));
				user.setUserProfile(rs.getString("userProfile"));
			}
		} catch (Exception e) {// 오류가 발생하면 오류를 출력하고
			e.printStackTrace();
		} finally {// sql실행이 끝나면 모든 리소를 종료
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return user; // 데이터베이스 오류
	}
	
	public int update(String userID, String userPassword, String userName, String userAge, String userGender,
			String userEmail) {
		Connection conn = null;
		PreparedStatement pstmt = null;// preparedstatement는 sql인젝션 공격을 방어해주고 안정적으로 실행할수있도록 해준다.
		String SQL = "UPDATE USER SET userPassword = ? ,userName =? , userAge =?,userGender =?, userEmail=? WHERE userID = ?";
		/* String SQL = "INSERT INTO USER VALUES(?,?,?,?,?,?,?,?,false)"; */
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userName);
			pstmt.setInt(3, Integer.parseInt(userAge));
			pstmt.setString(4, userGender);
			pstmt.setString(5, userEmail);
			pstmt.setString(6, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {// 오류가 발생하면 오류를 출력하고
			e.printStackTrace();
		} finally {// sql실행이 끝나면 모든 리소를 종료
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 데이터베이스 오류
	}
	public int profile(String userID, String userProfile) {
		Connection conn = null;
		PreparedStatement pstmt = null;// preparedstatement는 sql인젝션 공격을 방어해주고 안정적으로 실행할수있도록 해준다.
		String SQL = "UPDATE USER SET userProfile = ? WHERE userID = ?";
		/* String SQL = "INSERT INTO USER VALUES(?,?,?,?,?,?,?,?,false)"; */
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userProfile);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {// 오류가 발생하면 오류를 출력하고
			e.printStackTrace();
		} finally {// sql실행이 끝나면 모든 리소를 종료
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 데이터베이스 오류
	}
}
