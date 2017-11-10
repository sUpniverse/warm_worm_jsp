package com.warm.dto;

public class boardDTO {

	private int boardID;	
	private String boardUserID;
	private String boardTitle;
	private String boardContent;
	private int boardCount;
	private String boardDate;
	private int boardAvailable;
	
	
	public int getBoardID() {
		return boardID;
	}
	public void setBoardID(int boardID) {
		this.boardID = boardID;
	}
	public String getBoardUserID() {
		return boardUserID;
	}
	public void setBoardUserID(String boardUserID) {
		this.boardUserID = boardUserID;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public int getBoardCount() {
		return boardCount;
	}
	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}
	public String getBoardDate() {
		return boardDate;
	}
	public void setBoardDate(String boardDate) {
		this.boardDate = boardDate;
	}
	public int getBoardAvailable() {
		return boardAvailable;
	}
	public void setBoardAvailable(int boardAvailable) {
		this.boardAvailable = boardAvailable;
	}
	
	
}
