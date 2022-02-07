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
		String sql = "insert into store0203 values(?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, storeNo);
		pstmt.setString(2, storeName);		
		pstmt.setString(3, storeTel);
		pstmt.setString(4, storeAddress);
		pstmt.executeUpdate();
		System.out.println("거래처 등록 성공");
%>
		<script>
			alret("거래처 등록 성공")
			href.location = "storeSelect.jsp";
		</script>
<%		
	}catch(SQLException e){		
		System.out.println("거래처 등록 실패");
		%>
		<script>
			alert("등록에 실패하였습니다!");
			history.back(-1);
		</script>
		<%
		e.printStackTrace();
	}
%>

</body>
</html>