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
	String storeNo = request.getParameter("storeNo");

	try{
		String sql = "delete from store0203 where storeNo=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, storeNo);
		pstmt.executeUpdate();
		System.out.println("거래처 삭제 성공");
%>
	<script>
		alert("거래처 삭제 성공");
		location.href="storeSelect.jsp";
	</script>
<%		
	}catch(SQLException e){
		System.out.println("거래처 삭제 실패");
		%>
		<script>
			alert("삭제에 실패하였습니다.");
			location.href="storeSelect.jsp";
		</script>
		<% 
		e.printStackTrace();
	}
%>
	
</body>
</html>