<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
h2 {
	text-align: center;
	margin: 20px 0 5px 0;
}

#tab {
	margin: 10px auto;
	width: 700px;
}

tr {
	height: 30px;
}

th {
	width: 150px;
	background: lightgrey;
}

#in1 {
	width: 40%;
	height: 22px;
}

#in2 {
	width: 70%;
	height: 22px;
}

#in3 {
	width: 20%;
	height: 22px;
}

#in4 {
	width: 30%;
	height: 22px;
}

#sel1 {
	width: 30%;
	height: 25px;
}

#in5 {
	width: 90%;
	height: 22px;
}

#btn {
	width: 120px;
	height: 30px;
	background: black;
	color: white;
}

#btn_tr {
	height: 50px;
}
</style>
<script>
	function check(){
		if(document.form.id.value==""){
			alert("이름을 입력하세요.");
			document.form.id.focus();
		}else if(document.form.password.value==""){
			alert("비밀번호를 입력하세요.");
			document.form.password.focus();
		}else if(document.form.pw_check.value==""){
			alert("확인비밀번호를 입력하세요.");
			document.form.pw_check.focus();
		}else if(document.form.password.value!=document.form.pw_check.value){
			alert("비밀번호와 확인비밀번호가 일치하지 않습니다.");
			document.form.pw_check.focus();
		}else{
			document.form.submit();
		}
	}
	
	function mail_change(){
		if(document.form.domain.options[document.form.domain.selectedIndex].value==""){
			document.form.mail2.disabled=true;
			document.form.mail2.value=="";
		}
		if(document.form.domain.options[document.form.domain.selectedIndex].value=="9"){
			document.form.mail2.disabled=false;
			document.form.mail2.focus();
		}else{
			document.form.mail2.disabled=true;
			document.form.mail2.value=document.form.domain.options[document.form.domain.selectedIndex].value;
		}
	}
	
	function retry(){
		location.href="memberSelect.jsp";
	}
</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	<%@ include file="nav.jsp"%>
	<%@ include file="DBconn.jsp"%>
	<section>
		<%
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String send_id = request.getParameter("id");

		try {
			String sql = "select id,name,password,gender,to_char(birth,'yyyy-mm-dd'),email,phone,address,interest from member0203 where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String id = rs.getString(1);
				String name = rs.getString(2);
				String password = rs.getString(3);
				String gender = rs.getString(4);
				String birth = rs.getString(5);
				String email = rs.getString(6);
				String phone = rs.getString(7);
				String address = rs.getString(8);
				String interest = rs.getString(9);

				
				String birth_arr[] = birth.split("-");				
				String email_arr[] = email.split("@");
				String interest_arr[] = interest.split(",");				
				
				System.out.println("데이터 조회 성공");
			%>
			
		<h2>회원 가입 등록 화면</h2>
		<form name="form" method="post" action="memberUpdate_process.jsp">
			<table id="tab" border=1>
				<tr>
					<th>아이디</th>
					<td><input id="in1" type="text" name="id" value="<%=id%>" readonly> </td>
				</tr>
				<tr>
					<th>성 명</th>
					<td><input id="in1" type="text" name="name" value="<%=name%>"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input id="in2" type="password" name="password" value="<%=password %>"></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input id="in2" type="password" name="pw_check" value="<%=password%>"></td>
				</tr>
				<tr>
					<th>성 별</th>
					<td><input type="radio" name="gender" value="1"<%if(gender.equals("1")){%>checked<%}%>>남성
						<input type="radio" name="gender" value="2"<%if(gender.equals("2")){%>checked<%}%>>여성</td>
				</tr>
				<tr>
					<th>생 일</th>
					<td><input id="in3" type="text" name="birth_year" value="<%=birth_arr[0] %>">년 
					<input id="in3" type="text" name="birth_month" value="<%=birth_arr[1] %>">월 
					<input id="in3"	type="text" name="birth_day" value="<%=birth_arr[2] %>">일</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input id="in4" type="text" name="mail1" placeholder="이메일"	value="<%=email_arr[0] %>" onfocus="this.value='';">@ 
					<input id="in4" type="text" name="mail2" value="<%=email_arr[1] %>" disabled> 
					<select id="sel1" name="domain" onchange="mail_change()">
							<option value=""<%if(email_arr[1].equals("")){%>selected<%} %>>선택하세요</option>
							<option value="9"<%if(email_arr[1].equals("9")){%>selected<%} %>>직접입력</option>
							<option value="korea.com"<%if(email_arr[1].equals("korea.com")){%>selected<%} %>>korea.com</option>
							<option value="naver.com"<%if(email_arr[1].equals("naver.com")){%>selected<%} %>>naver.com</option>
							<option value="hanmail.net"<%if(email_arr[1].equals("hanmail.net")){%>selected<%} %>>hanmail.net</option>
							<option value="gmail.com"<%if(email_arr[1].equals("gmail.com")){%>selected<%} %>>gmail.com</option>
					</select></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input id="in1" type="text" name="phone" value="<%=phone%>"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input id="in5" type="text" name="address" value="<%=address %>"></td>
				</tr>
				<tr>
				<tr>
					<th>관심분야</th>
					<td><input type="checkbox" name="interest" value="프로그램"<%for(int i=0;i<interest_arr.length;i++)if("프로그램".equals(interest_arr[i]))out.print("checked"); %>>프로그램
						<input type="checkbox" name="interest" value="독서"<%for(int i=0;i<interest_arr.length;i++)if("독서".equals(interest_arr[i]))out.print("checked"); %>>독서
						<input type="checkbox" name="interest" value="등산"<%for(int i=0;i<interest_arr.length;i++)if("등산".equals(interest_arr[i]))out.print("checked"); %>>등산 
						<input type="checkbox" name="interest" value="여행"<%for(int i=0;i<interest_arr.length;i++)if("여행".equals(interest_arr[i]))out.print("checked"); %>>여행 
						<input type="checkbox" name="interest" value="컴퓨터"<%for(int i=0;i<interest_arr.length;i++)if("컴퓨터".equals(interest_arr[i]))out.print("checked"); %>>컴퓨터 
						<input type="checkbox" name="interest" value="영화"<%for(int i=0;i<interest_arr.length;i++)if("영화".equals(interest_arr[i]))out.print("checked"); %>>영화 
						<input type="checkbox" name="interest" value="운동"<%for(int i=0;i<interest_arr.length;i++)if("운동".equals(interest_arr[i]))out.print("checked"); %>>운동 
						<input type="checkbox" name="interest" value="진학"<%for(int i=0;i<interest_arr.length;i++)if("진학".equals(interest_arr[i]))out.print("checked"); %>>진학</td>
				</tr>
				<tr id="btn_tr">
					<td colspan=2 align=center>
					<input id="btn" type="button" value="등록" onclick="check()"> 
					<input id="btn" type="reset" value="취소" onclick="retry()"></td>
				</tr>
			</table>
		</form>
					<%
			}

		} catch (SQLException e) {
			System.out.println("데이터 조회 실패");
			e.printStackTrace();
		}
	%>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>