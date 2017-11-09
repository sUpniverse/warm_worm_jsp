package com.warm.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.warm.dto.userDTO;


public class userDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public userDAO() {
		// TODO Auto-generated constructor stub
		String dbUrl = "jdbc:mysql://localhost:3306/board";
		String dbID = "root";
		String dbPassowrd = "22345335";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbUrl,dbID,dbPassowrd);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public int login(String userID,String userPassword) {
		String query = "select userPassword from user where userID = ?";
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;	// 로그인 성공
				} else {
					return 0;	// 비밀번호 틀림
				}
			} return -1; 		// 아이디가 존재 하지 않음
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return -2;		//데이터 베이스 오류
	}
	
	public int join(userDTO user) {
		String query = "insert into user values(?,?,?,?,?)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();	
		}		
		
		return -1;
	}
	
	

}


