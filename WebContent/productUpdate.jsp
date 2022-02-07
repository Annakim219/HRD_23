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
	width: 80%;
	height: 22px;
}

#sel1{
	width: 80%;
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
		if(document.form.productId.value==""){
			alert("상품코드를 입력하세요.");
			document.form.productId.focus();
		}else if(document.form.name.value.length<4 || document.form.name.value.length>50){
			alert("[상품명]\n최소 4자에서 최대 50자까지 입력하세요.");
			document.form.name.focus();
		}else if(document.form.unitprice.value==""){
			alert("가격을 입력하세요.");
			document.form.unitprice.focus();
		}else if(isNaN(document.form.unitprice.value)){
			alert("[가격]\n숫자만 입력하세요.");
			document.form.unitprice.focus();
		}else if(document.form.unitprice.value<0){
			alert("[가격]\n음수를 입력할 수 없습니다.");
			document.form.unitprice.focus();
		}else if(isNaN(document.form.unitsInstock.value)){
			alert("[재고]\n숫자만 입력하세요.");
			document.form.unitsInstock.focus();
		}else{
			document.form.submit();
		}
	}
	
	function retry(){
		location.href="productSelect.jsp";
	}
</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	<%@ include file="nav.jsp"%>
	<%@ include file="DBconn.jsp" %>
	<section>
	<%
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String send_productId = request.getParameter("productId");
		
		try{
			String sql = "select * from product0203 where productId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_productId);
			rs = pstmt.executeQuery();
			if(rs.next()){
				String productId = rs.getString("productId");
				String name = rs.getString("name");
				String unitprice = rs.getString("unitprice");
				String description = rs.getString("description");
				String category = rs.getString("category");
				String manufacturer = rs.getString("manufacturer");
				String unitsInstock = rs.getString("unitsInstock");
				String condition = rs.getString("condition");
				System.out.println("데이터 조회 성공");
				%>

		<h2>상품 수정 화면</h2>
		<form name="form" method="post" action="productUpdate_process.jsp">
			<table id="tab" border=1>
				<tr>
					<th>상품코드</th>
					<td><input id="in1" type="text" name="productId" value="<%=productId %>" readonly></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td><input id="in1" type="text" name="name" value="<%=name %>"></td>
				</tr>
				<tr>
					<th>가 격</th>
					<td><input id="in1" type="text" name="unitprice" value="<%=unitprice %>"></td>
				</tr>
				<tr>
					<th>상세정보</th>
					<td><input id="in1" type="text" name="description" value="<%=description %>"></td>
				</tr>
				<tr>
					<th>제조사</th>
					<td><input id="in1" type="text" name="manufacturer" value="<%=manufacturer %>"></td>
				</tr>
				<tr>
					<th>분 류</th>
					<td><select id="sel1" name="category">
							<option value="10"<%if(category.equals("10")){%>selected<%} %>> it 제품</option>
							<option value="20"<%if(category.equals("20")){%>selected<%} %>>주방제품</option>
							<option value="30"<%if(category.equals("30")){%>selected<%} %>>전자제품</option>
							<option value="40"<%if(category.equals("40")){%>selected<%} %>>일반 잡화</option>
					</select></td>
				</tr>
				<tr>
					<th>재고수</th>
					<td><input id="in1" type="text" name="unitsInstock" value="<%=unitsInstock %>"></td>
				</tr>
				<tr>
					<th>상 태</th>
					<td><input type="radio" name="condition" value="신규제품"<%if(condition.equals("신규제품")){%>checked<%} %>>신규 제품
					<input type="radio" name="condition" value="중고제품"<%if(condition.equals("중고제품")){%>checked<%} %>>중고 제품
					<input type="radio" name="condition" value="재생제품"<%if(condition.equals("재생제품")){%>checked<%} %>>재생 제품
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
			
		}catch(SQLException e){
			System.out.println("데이터 조회 실패");
			e.printStackTrace();
		}
	%>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>