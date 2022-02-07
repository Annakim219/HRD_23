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
	width: 500px;
}

tr {
	height: 30px;
}

th {
	width: 150px;
	background: lightgrey;
}

#in1 {
	width: 60%;
	height: 22px;
}

#in2 {
	width: 25%;
	height: 22px;
}

#in3 {
	width: 90%;
	height: 22px;
}


#sel1{
	width: 25%;
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
		if(document.form.storeName.value==""){
			alert("거래처이름을 입력하세요.");
			document.form.storeName.focus();
		}else{
			document.form.submit();
		}
	}
	
	function retry(){
		location.href="index.jsp";
	}
</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	<%@ include file="nav.jsp"%>
	<%@ include file="DBconn.jsp" %>
	<%
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = 0;
		
		try{
			String sql = "select storeNo_seq.nextval from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1);
			}
		}catch(SQLException e){
			System.out.println("sequence 오류");
			e.printStackTrace();
		}
	%>
	<section>
		<h2>상품 등록 화면</h2>
		<form name="form" method="post" action="addStore_process.jsp">
			<table id="tab" border=1>
				<tr>
					<th>거래처 코드</th>
					<td><input id="in1" type="text" name="storeNo" value="<%=num %>">
					<span>(sequence 발생)</span></td>
				</tr>
				<tr>
					<th>거래처 이름</th>
					<td><input id="in1" type="text" name="storeName"></td>
				</tr>
				<tr>
					<th>거래처 전화번호</th>
					<td><select id=sel1 name="storeTel1">
						<option value="02" selected>서울(02)</option>
						<option value="031">경기(031)</option>
						<option value="032">인천(032)</option>
						<option value="033">강원(033)</option>
						<option value="041">충남(041)</option>
						<option value="042">대전(042)</option>
						<option value="043">충북(043)</option>
						<option value="044">세종(044)</option>
						<option value="051">부산(051)</option>
						<option value="052">울산(052)</option>
						<option value="053">대구(053)</option>
						<option value="054">경북(054)</option>
						<option value="055">경남(055)</option>
						<option value="061">전남(061)</option>
						<option value="062">광주(062)</option>
						<option value="063">전북(063)</option>
						<option value="064">제주(064)</option>
					</select>-
					<input id="in2" type="text" name="storeTel2">-
					<input id="in2" type="text" name="storeTel3">
					</td>
				</tr>
				<tr>
					<th>거래처 주소</th>
					<td><input id="in3" type="text" name="storeAddress"></td>
				</tr>

				<tr id="btn_tr">
					<td colspan=2 align=center>
					<input id="btn" type="button" value="등록" onclick="check()"> 
					<input id="btn" type="reset" value="취소" onclick="retry()"></td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>