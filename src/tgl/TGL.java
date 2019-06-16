package tgl;

public class TGL { // tgl디비
	private int tglID;//tgl ID
	private String tglTitle;//tgl 제목
	private String userID;//작성자 아이디
	private int tglAvailable;//삭제를 위한 Boolean 키
	public int getTglID() {
		return tglID;
	}
	public void setTglID(int tglID) {
		this.tglID = tglID;
	}
	public String getTglTitle() {
		return tglTitle;
	}
	public void setTglTitle(String tglTitle) {
		this.tglTitle = tglTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getTglAvailable() {
		return tglAvailable;
	}
	public void setTglAvailable(int tglAvailable) {
		this.tglAvailable = tglAvailable;
	}
	
}
