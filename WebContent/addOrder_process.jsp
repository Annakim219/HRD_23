<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="DBconn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String orderDate = request.getParameter("orderDate");
	String orderName = request.getParameter("orderName");
	String productId = request.getParameter("productId");
	String unitprice = request.getParameter("unitprice");
	String orderQty = request.getParameter("orderQty");
	String orderAddress = request.getParameter("orderAddress");
	int p_orderQty = Integer.parseInt(orderQty);
	int unitsInstock = 0;
	int total_Instock = 0;
	
	try{
		String sql = "select unitsInstock from product0203 where productId=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			unitsInstock = rs.getInt(1);
			total_Instock = unitsInstock - p_orderQty;
		}
		
		sql = " update product0203 set unitsInstock=? where productId=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, total_Instock);
		pstmt.setString(2, productId);
		pstmt.executeUpdate();
		
		sql = "insert into order0203 values(?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, orderDate);
		pstmt.setString(2, orderName);
		pstmt.setString(3, productId);
		pstmt.setString(4, unitprice);
		pstmt.setString(5, orderQty);
		pstmt.setString(6, orderAddress);
		pstmt.executeUpdate();
		System.out.println("주문 등록 성공");
		%>
		
		<script>
			alert("등록이 완료되었습니다!");
			location.href="orderSelect.jsp";
		</script>
		
		<%		
	}catch(SQLException e){
		System.out.println("주문 등록 실패");
		e.printStackTrace();
	}
%>
		<script>
			alert("등록에 실패하였습니다!");
			history.back(-1);
		</script>
</body>
</html>