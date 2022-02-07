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
		String sql = "update member0203 set password=?,name=?,gender=?,birth=?,email=?,phone=?,address=?,interest=? where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(9, id);
		pstmt.setString(1, password);
		pstmt.setString(2, name);
		pstmt.setString(3, gender);
		pstmt.setString(4, birth);
		pstmt.setString(5, email);
		pstmt.setString(6, phone);
		pstmt.setString(7, address);
		pstmt.setString(8, chk);
		pstmt.executeUpdate();
		System.out.println("회원 정보 수정 성공");
%>
	<script>
		alert("수정이 완료되었습니다.");
		location.href="memberSelect.jsp";
	</script>
<%		
	}catch(SQLException e){
		System.out.println("회원 정보 수정 실패");
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