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
		String send_storeNo = request.getParameter("storeNo");
		
		try{
			String sql = "select * from store0203 where storeNo=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_storeNo);
			rs = pstmt.executeQuery();
			if(rs.next()){
				String storeNo = rs.getString(1);
				String storeName = rs.getString(2);
				String storeTel = rs.getString(3);
				String storeAddress = rs.getString(4);
				String arr_tel[] = storeTel.split("-");
				
				System.out.println("거래처 수정 조회 성공");
	%>
	<section>
		<h2>상품 등록 화면</h2>
		<form name="form" method="post" action="storeUpdate_process.jsp">
			<table id="tab" border=1>
				<tr>
					<th>거래처 코드</th>
					<td><input id="in1" type="text" name="storeNo" value="<%=storeNo %>" readonly></td>
				</tr>
				<tr>
					<th>거래처 이름</th>
					<td><input id="in1" type="text" name="storeName" value="<%=storeName %>"></td>
				</tr>
				<tr>
					<th>거래처 전화번호</th>
					<td><select id=sel1 name="storeTel1">
						<option value="02" <%if(arr_tel[0].equals("02")){%>selected<%} %>>서울(02)</option>
						<option value="031" <%if(arr_tel[0].equals("031")){%>selected<%} %>>경기(031)</option>
						<option value="032" <%if(arr_tel[0].equals("032")){%>selected<%} %>>인천(032)</option>
						<option value="033" <%if(arr_tel[0].equals("033")){%>selected<%} %>>강원(033)</option>
						<option value="041" <%if(arr_tel[0].equals("041")){%>selected<%} %>>충남(041)</option>
						<option value="042" <%if(arr_tel[0].equals("042")){%>selected<%} %>>대전(042)</option>
						<option value="043" <%if(arr_tel[0].equals("043")){%>selected<%} %>>충북(043)</option>
						<option value="044" <%if(arr_tel[0].equals("044")){%>selected<%} %>>세종(044)</option>
						<option value="051" <%if(arr_tel[0].equals("051")){%>selected<%} %>>부산(051)</option>
						<option value="052" <%if(arr_tel[0].equals("052")){%>selected<%} %>>울산(052)</option>
						<option value="053" <%if(arr_tel[0].equals("053")){%>selected<%} %>>대구(053)</option>
						<option value="054" <%if(arr_tel[0].equals("054")){%>selected<%} %>>경북(054)</option>
						<option value="055" <%if(arr_tel[0].equals("055")){%>selected<%} %>>경남(055)</option>
						<option value="061" <%if(arr_tel[0].equals("061")){%>selected<%} %>>전남(061)</option>
						<option value="062" <%if(arr_tel[0].equals("062")){%>selected<%} %>>광주(062)</option>
						<option value="063" <%if(arr_tel[0].equals("063")){%>selected<%} %>>전북(063)</option>
						<option value="064" <%if(arr_tel[0].equals("064")){%>selected<%} %>>제주(064)</option>
					</select>-
					<input id="in2" type="text" name="storeTel2" value="<%=arr_tel[1] %>">-
					<input id="in2" type="text" name="storeTel3" value="<%=arr_tel[2] %>">
					</td>
				</tr>
				<tr>
					<th>거래처 주소</th>
					<td><input id="in3" type="text" name="storeAddress" value="<%=storeAddress %>"></td>
				</tr>

				<tr id="btn_tr">
					<td colspan=2 align=center>
					<input id="btn" type="button" value="수정" onclick="check()"> 
					<input id="btn" type="reset" value="취소" onclick="retry()"></td>
				</tr>
			</table>

		</form>
					<%
			}
		}catch(SQLException e){
			System.out.println("거래처 수정 조회 실패");
			e.printStackTrace();
		}
			%>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>