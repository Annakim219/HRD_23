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
	String id = request.getParameter("id");

	try{
		String sql = "delete from member0203 where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		System.out.println("회원 삭제 성공");
%>
	<script>
		alert("회원 삭제 성공");
		location.href="memberSelect.jsp";
	</script>
<%		
	}catch(SQLException e){
		System.out.println("회원 삭제 실패");
		e.printStackTrace();
	}
%>
	<script>
		alert("삭제가 실패하였습니다.");
		location.href="memberSelect.jsp";
	</script>
</body>
</html>