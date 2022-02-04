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
</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	<%@ include file="nav.jsp"%>
	<section>
		<h2>상품 등록 화면</h2>
		<form name="form" method="post" action="addProduct_process.jsp">
			<table id="tab" border=1>
				<tr>
					<th>상품코드</th>
					<td><input id="in1" type="text" name="productId"></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td><input id="in1" type="text" name="name"></td>
				</tr>
				<tr>
					<th>가 격</th>
					<td><input id="in1" type="text" name="unitprice"></td>
				</tr>
				<tr>
					<th>상세정보</th>
					<td><input id="in1" type="text" name="description"></td>
				</tr>
				<tr>
					<th>제조사</th>
					<td><input id="in1" type="text" name="manufacturer"></td>
				</tr>
				<tr>
					<th>분 류</th>
					<td><select id="sel1" name="category">
							<option value="10" selected>it 제품</option>
							<option value="20">주방제품</option>
							<option value="30">전자제품</option>
							<option value="40">일반 잡화</option>
					</select></td>
				</tr>
				<tr>
					<th>재고수</th>
					<td><input id="in1" type="text" name="unitsInstock"></td>
				</tr>
				<tr>
					<th>상 태</th>
					<td><input type="radio" name="condition" value="신규제품" checked>신규 제품
					<input type="radio" name="condition" value="중고제품">중고 제품
					<input type="radio" name="condition" value="재생제품">재생 제품
				</tr>
				<tr id="btn_tr">
					<td colspan=2 align=center>
					<input id="btn" type="button" value="등록" onclick="check()"> 
					<input id="btn" type="reset" value="취소"></td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>