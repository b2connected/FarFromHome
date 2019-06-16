package bbs;

public class Bbs {
		private int bbsID;//게시판 ID
		private String bbsTitle;//게시판 제목
		private String userID;//작성자 아이디
		private String bbsDate;//작성 날짜
		private String bbsContent;//작성내용
		private int bbsAvailable;//삭제를 위한 Boolean 키
		
		private String search;//게시글 검색
		
		public String getSearch() {
			return search;
		}
		public void setSearch(String search) {
			this.search = search;
		}

	
		
	//	private String filename;//파일 이름
	//	private int filesize;//파일 사이즈 
		
		
	//	public String getFilename() {
	//		return filename;
	//	}
	//	public void setFilename(String filename) {
	//		this.filename = filename;
	//	}
	//	public int getFilesize() {
	//		return filesize;
	//	}
	//	public void setFilesize(int filesize) {
	//		this.filesize = filesize;
	//	}

		public int getBbsID() {
			return bbsID;
		}
		public void setBbsID(int bbsID) {
			this.bbsID = bbsID;
		}
		public String getBbsTitle() {
			return bbsTitle;
		}
		public void setBbsTitle(String bbsTitle) {
			this.bbsTitle = bbsTitle;
		}
		public String getUserID() {
			return userID;
		}
		public void setUserID(String userID) {
			this.userID = userID;
		}
		public String getBbsDate() {
			return bbsDate;
		}
		public void setBbsDate(String bbsDate) {
			this.bbsDate = bbsDate;
		}
		public String getBbsContent() {
			return bbsContent;
		}
		public void setBbsContent(String bbsContent) {
			this.bbsContent = bbsContent;
		}
		public int getBbsAvailable() {
			return bbsAvailable;
		}
		public void setBbsAvailable(int bbsAvailable) {
			this.bbsAvailable = bbsAvailable;
		}
}
