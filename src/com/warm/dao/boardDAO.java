package com.warm.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.warm.dto.boardDTO;

public class boardDAO {
	private Connection con;	
	private ResultSet rs;
	
	public boardDAO() {
		// TODO Auto-generated constructor stub
		String dbUrl = "jdbc:mysql://localhost:3306/board";
		String dbId = "root";
		String dbPassword = "22345335";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbUrl,dbId,dbPassword);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	public int getNext() {		
		String query = "Select boardID from board ORDER BY boardID desc";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1 ;
			}
			return 1;		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return -1; // 데이터 베이스 오류		
	}
	
	public String getDate() {
		String query = "Select NOW()";
		PreparedStatement pstmt;
		try {
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return " ";
	}
	
	public ArrayList<boardDTO> getlist(int pageNumber) {
		
		String query = "select * from board where boardId < ? AND boardAvailable = 1 ORDER BY boardId desc Limit 10";
		ArrayList<boardDTO> list = new ArrayList<boardDTO>();
		
		try {
			PreparedStatement pstmt  = con.prepareStatement(query);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				boardDTO boardDTO = new boardDTO();
				boardDTO.setBoardID(rs.getInt(1));
				boardDTO.setBoardUserID(rs.getString(2));
				boardDTO.setBoardTitle(rs.getString(3));
				boardDTO.setBoardContent(rs.getString(4));
				boardDTO.setBoardCount(rs.getInt(5));
				boardDTO.setBoardDate(rs.getString(6));
				boardDTO.setBoardAvailable(rs.getInt(7));
				list.add(boardDTO);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return list;	
	}
	
	public int update(int boardID,String boardTitle,String boardContent) {
		String query = "update board SET boardTitle = ?, boardContent = ? where boardID = ?";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);		
			pstmt.setString(1, boardTitle);
			pstmt.setString(2, boardContent);
			pstmt.setInt(3, boardID);
			return  pstmt.executeUpdate();			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public int delete(int boardID) {
		String query = "update board SET boardAvailable = 0 where boardID = ?";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, boardID);
			return  pstmt.executeUpdate();			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public void count (int boardID) {
		String query = "update board SET boardCount = boardCount+1 where boardID = ?";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, boardID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	public int write(String boardTitle, String userID, String boardContent) {
		String query = "Insert into board values(?,?,?,?,?,?,?)";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1,getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, boardTitle);
			pstmt.setString(4, boardContent);
			pstmt.setInt(5,0);
			pstmt.setString(6, getDate());
			pstmt.setInt(7, 1);
			return  pstmt.executeUpdate();			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public boardDTO read(int boardID) {
			
		String query = "Select * from board where boardID = ?";		
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, boardID);
			rs= pstmt.executeQuery();
			if(rs.next()) {				
					boardDTO boardDTO = new boardDTO();	
					boardDTO.setBoardID(rs.getInt(1));
					boardDTO.setBoardUserID(rs.getString(2));
					boardDTO.setBoardTitle(rs.getString(3));
					boardDTO.setBoardContent(rs.getString(4));
					boardDTO.setBoardCount(rs.getInt(5));
					boardDTO.setBoardDate(rs.getString(6));
					boardDTO.setBoardAvailable(rs.getInt(7));					
					return boardDTO;				
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}				
		
		return null;
	}
}
