<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
h3 {
	text-align: center;
	margin: 20px 0 10px 0;
}
#tab{
	margin:10px auto;
}
.cnt {
	display: table; 
	width: 1250px; 
	height: 25px;
	margin: 0 auto; 
}
#th1{
	height:30px;
	background:lightgrey;
	text-align:center;
}
td{
	height:25px;
	text-align:center;
}
</style>
<script>
	function delOK(){
		if(!confirm('정말로 삭제하시겠습니까?')){
			return false;
		}
	}
</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	<%@ include file="nav.jsp"%>
	<%@ include file="DBconn.jsp"%>
	<%
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;

		try {
			String sql = "select count(*) from member0203";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt(1);
			} else {
				cnt = 0;
			}
		} catch (SQLException e) {
			System.out.println("cnt 조회 실패");
			e.printStackTrace();
		}
	%>

	<section>
		<h3>회원 목록</h3>
		<div class="cnt" align=left>
			<p>
				총 <b><%=cnt%>명</b>의 회원이 있습니다.
			</p>
		</div>
		<table id="tab" border=1>
			<tr id="th1">
				<th width=80>id</th>
				<th width=80>성명</th>
				<th width=80>비밀번호</th>
				<th width=50>성별</th>
				<th width=160>생년월일</th>
				<th width=160>이메일</th>
				<th width=120>연락처</th>
				<th width=200>주소</th>
				<th width=200>관심분야</th>
				<th width=120>구분</th>
			</tr>
		<%
			try{
				String sql = "select * from member0203";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()){
					String id = rs.getString("id");
					String password = rs.getString("password");
					String name = rs.getString("name");
					String gender = rs.getString("gender");
					String birth = rs.getString("birth");
					String email = rs.getString("email");
					String phone = rs.getString("phone");
					String address = rs.getString("address");
					String interest = rs.getString("interest");
					System.out.println("회원목록 데이터 조회 성공");
					
					if(gender.equals("1")){gender="남성";}
					else if(gender.equals("2")){gender="여성";}		
					%>

				<tr>
					<td><%=id %></td>
					<td><%=name %></td>
					<td><%=password %></td>
					<td><%=gender %></td>
					<td><%=birth %></td>
					<td><%=email %></td>
					<td><%=phone %></td>
					<td><%=address %></td>
					<td><%=interest %></td>
					<td><a href="memberUpdate.jsp?id=<%=id %>">수정</a>
					<span>/</span>
					<a href="memberDelete.jsp?id=<%=id %>" onclick="delOK()">삭제</a>
					
					<%
				}
				
			}catch(SQLException e){
				System.out.println("회원목록 데이터 조회 실패");
				e.printStackTrace();
			}
		%>
		
		</table>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>