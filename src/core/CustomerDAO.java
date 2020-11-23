package core;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CustomerDAO {
	private DataSource dataFactory;
	private Connection conn;
	private PreparedStatement pstmt;
	
	public CustomerDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context)ctx.lookup("java:comp.env");
			dataFactory = (DataSource) envContext.lookup("jbbc/oracle");
		}  catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<CustomerVO> listMembers() {
		List<CustomerVO> customerList = new ArrayList<CustomerVO>();
		String query = "select * from tblCustomer order by joinDate desc";
		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String id = rs.getString("CTMID");
				String hashedPassword = rs.getString("CTMPW");
				String no = rs.getString("CTMNO");
				String name = rs.getString("CTMNM");
				String address = rs.getString("ADDR");
				String tel = rs.getString("TEL");
				String email = rs.getString("EMAIL");
				String isAdmin = rs.getString("isAdmin");
				String joinDate = rs.getString("joinDate");
				
				CustomerVO c = new CustomerVO();
				
				c
					.setId(id)
					.setPassword(hashedPassword)
					.setNo(no)
					.setName(name)
					.setAddress(address)
					.setTel(tel)
					.setEmail(email)
					.setIsAdmin(isAdmin)
					.setJoinDate(joinDate);
				
				customerList.add(c);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		return customerList;
	}
	
	public void addCustomer(CustomerVO c) {
		try {
			
			conn = dataFactory.getConnection();
			
			String no = c.getNo();
			String id = c.getId();
			String hashedPassword = c.getPassword();
			String name = c.getName();
			String address = c.getAddress();
			String tel = c.getTel();
			String email = c.getEmail();
			String isAdmin = c.getIsAdmin();
			String joinDate = c.getJoinDate();
			String salt = c.getSalt();
			
			String query = "insert into tblCustomer" + 
					" values(?, ?, ?, ?, ?, ?, ?, ?, ?, ? )";
		
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, hashedPassword);
			pstmt.setString(3, name);
			pstmt.setString(4, address);
			pstmt.setString(5, tel);
			pstmt.setString(6, email);
			pstmt.setString(7, isAdmin);
			pstmt.setString(8, joinDate);
			pstmt.setString(9, salt);
			
		} catch (SQLException e) {
			
		}
	}
}
