package com.warm.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class boardDAO {
	private Connection con;	
	private PreparedStatement pstmt;
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
			pstmt = con.prepareStatement(query);
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
	
	
	public int write(String boardTitle, String userID, String boardContent) {
		String query = "Insert into values(?,?,?,?,?,?,?)";
		
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
}
