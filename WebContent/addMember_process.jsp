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

	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String gender = request.getParameter("gender");
	String birth = request.getParameter("birth_year")+"-"+request.getParameter("birth_month")+"-"+request.getParameter("birth_day");
	String email = request.getParameter("mail1")+"@"+request.getParameter("domain");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	String interest[] = request.getParameterValues("interest");
	String chk="";
	for(int i=0;i<interest.length;i++){
		if((i+1)==interest.length){
			chk=chk+interest[i];
		}else{
		chk=chk+interest[i]+",";
		}
	}
	String timestamp = request.getParameter("timestamp");
	
	try{
		String sql = "insert into member0203 values(?,?,?,?,?,?,?,?,?,sysdate)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, password);
		pstmt.setString(3, name);
		pstmt.setString(4, gender);
		pstmt.setString(5, birth);
		pstmt.setString(6, email);
		pstmt.setString(7, phone);
		pstmt.setString(8, address);
		pstmt.setString(9, chk);
		pstmt.executeUpdate();
		System.out.println("회원 가입 등록 성공");
%>
	<script>
		alert("등록이 완료되었습니다.");
		location.href="memberSelect.jsp";
	</script>
<%		
	}catch(SQLException e){
		System.out.println("회원 가입 등록 실패");
		e.printStackTrace();
	}
%>
	<script>
		alert("등록 실패");
		history.back(-1);
	</script>
</body>
</html>