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
	System.out.println(orderQty);
	String orderAddress = request.getParameter("orderAddress");
	int p_orderQty = Integer.parseInt(orderQty);
	int bf_orderQty = 0; //수정 전 주문수량
	int pr_Instock = 0; // 수정 전 재고 수
	int total_Instock = 0; // 수정 반영 재고 수 
	System.out.println("에러1");
	try{
		String sql = "select a.orderQty, b.unitsInstock from order0203 a, product0203 b where a.productId=b.productId and a.productId=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		rs = pstmt.executeQuery();
		System.out.println("에러2");
		if (rs.next()) {
			bf_orderQty = rs.getInt(1);
			pr_Instock = rs.getInt(2);
			total_Instock = (pr_Instock+bf_orderQty)-p_orderQty;
		}
		
		sql = " update product0203 set unitsInstock=? where productId=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, total_Instock);
		pstmt.setString(2, productId);
		pstmt.executeUpdate();
		
		sql = "update order0203 set productId=?, unitprice=?, orderQty=?, orderAddress=? where orderDate=? and orderName=?" ;
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		pstmt.setString(2, unitprice);
		pstmt.setString(3, orderQty);
		pstmt.setString(4, orderAddress);
		pstmt.setString(5, orderDate);
		pstmt.setString(6, orderName);
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