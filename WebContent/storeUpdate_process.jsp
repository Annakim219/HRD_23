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
	String storeName = request.getParameter("storeName");
	String storeTel = request.getParameter("storeTel1")+"-"+request.getParameter("storeTel2")+"-"+request.getParameter("storeTel3");
	String storeAddress = request.getParameter("storeAddress");
	
	try{
		String sql = "update store0203 set storeName=?, storeTel=?, storeAddress=? where storeNo=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, storeName);		
		pstmt.setString(2, storeTel);
		pstmt.setString(3, storeAddress);
		pstmt.setString(4, storeNo);
		pstmt.executeUpdate();
		System.out.println("거래처 수정 성공");
%>
		<script>
			alert("거래처 수정 성공")
			location.href = "storeSelect.jsp";
		</script>
<%		
	}catch(SQLException e){		
		System.out.println("거래처 수정 실패");
		%>
		<script>
			alert("수정이 실패하였습니다.");
			history.back(-1);
		</script>
		<%
		e.printStackTrace();
	}
%>

</body>
</html>