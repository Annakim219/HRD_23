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
	PreparedStatement pstmt = null;
	String send_orderDate = request.getParameter("orderDate");
	String send_orderName = request.getParameter("orderName");	

	try{
		String sql = "delete from order0203 where orderDate=? and orderName=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, send_orderDate);
		pstmt.setString(2, send_orderName);
		pstmt.executeUpdate();
		System.out.println("주문 삭제 성공");
%>
	<script>
		alert("주문 삭제 성공");
		location.href="orderSelect.jsp";
	</script>
<%		
	}catch(SQLException e){
		System.out.println("주문 삭제 실패");
		e.printStackTrace();
	}
%>
	<script>
		alert("삭제가 실패하였습니다.");
		location.href="productSelect.jsp";
	</script>
</body>
</html>