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
	width: 99%;
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
	function check() {
		if (document.form.orderDate.value == "") {
			alert("주문일자를 입력하세요.");
			document.form.orderDate.focus();
		} else if (document.form.orderName.value == "") {
			alert("주문자이름을 입력하세요.");
			document.form.orderName.focus();
		} else if (document.form.productId.value == "") {
			alert("상품코드를 입력하세요.");
			document.form.productId.focus();
		} else if (document.form.orderAddress.value == "") {
			alert("주문자 주소를 입력하세요.");
			document.form.orderAddress.focus();
		} else {
			form.action = "orderUpdate_process.jsp";
			document.form.submit();
		}
	}

	function changesubmit() {
		document.form.submit();
	}
	function changesubmit1() {
		document.form.submit();
	}

	function goList() {
		location.href = "orderSelect.jsp";
	}
</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	<%@ include file="nav.jsp"%>
	<%@ include file="DBconn.jsp"%>
	<%
		request.setCharacterEncoding("utf-8");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		

		String send_orderName = request.getParameter("orderName");
		String send_orderDate = request.getParameter("orderDate");
		
		String p_Qty = request.getParameter("orderQty");
		
		String orderDate = "";
		String orderName = ""; 
		String productId = "";
		String orderQty = "";
		String orderAddress = "";
		int p_orderQty = 0;
		System.out.println("Qty"+p_Qty);
		System.out.println("orderQty"+orderQty);
		String name = "";
		int unitprice = 0;
		int unitsInstock = 0;
		int total = 0;
		
		try{
			String sql = "select to_char(orderDate,'yyyy-mm-dd'),orderName, productId, orderQty, orderAddress from order0203 where orderName=? and orderDate=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_orderName);
			pstmt.setString(2, send_orderDate);
			rs = pstmt.executeQuery();
			if(rs.next()){
				orderDate = rs.getString(1);
				orderName = rs.getString(2);
				productId = rs.getString(3);
				orderQty = rs.getString(4);
				if(p_Qty==null){
					
				}else{
					if(p_Qty.equals(orderQty)){
						
					}else{
						orderQty=p_Qty;
					}
				}
				orderAddress = rs.getString(5);
				System.out.println("수정 데이터 조회 성공");
			
			}
			}catch(SQLException e){
				System.out.println("수정 데이터 조회 실패");
				e.printStackTrace();
			}

		if (productId == null) {
			orderDate = "";
			orderName = "";
			productId = "";
			orderQty = "";
			orderAddress = "";
			p_orderQty = 0;
		} else {
			p_orderQty = Integer.parseInt(orderQty);
		}


		try {
			String sql = "select name, unitprice, unitsInstock from product0203 where productId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				name = rs.getString(1);
				unitprice = rs.getInt(2);
				unitsInstock = rs.getInt(3);
				total = p_orderQty * unitprice;

			} else if (productId != "") {
	%>
	<script>
		alert("등록되지 않은 코드입니다.");
	</script>
	<%
		}
		} catch (SQLException e) {
			System.out.println("데이터 조회 실패");
			e.printStackTrace();
		}
		
		if(p_orderQty>unitsInstock){
			%>
			<script>
				alert("주문 수량이 재고 수량보다 많습니다.");
			</script>
			<%
		}
	%>
	<section>
		<h2>주문 정보 등록</h2>
		<form name="form" method="post" action="orderUpdate.jsp">
			<table id="tab" border=1>
				<tr>
					<th>주문일자</th>
					<td><input id="in1" type="text" name="orderDate" value="<%=orderDate%>" readonly></td>
					<th>주문자 이름</th>
					<td><input id="in1" type="text" name="orderName" value="<%=orderName%>" readonly></td>
				</tr>
				<tr>
					<th>상품코드</th>
					<td><input id="in1" type="text" name="productId" value="<%=productId%>" onchange="changesubmit();"></td>
					<th>상 품 명</th>
					<td><input id="in1" type="text" name="name" value="<%=name%>"></td>
				</tr>
				<tr>
					<th>단 가</th>
					<td><input id="in1" type="text" name="unitprice" value="<%=unitprice%>" ></td>
					<th>주문수량</th>
					<td><input id="in1" type="text" name="orderQty" value="<%=p_orderQty%>" onchange="changesubmit();"></td>
				</tr>
				<tr>
					<th>주문금액</th>
					<td><input id="in1" type="text" name="total" value="<%=total%>" ></td>
					<th>주문주소</th>
					<td><input id="in1" type="text" name="orderAddress"	value="<%=orderAddress%>"></td>
				</tr>
				<tr id="btn_tr">
					<td colspan=4 align=center>
					<input id="btn" type="button" value="목록" onclick="goList()"> 
					<input id="btn"	type="button" value="저장" onclick="check()"></td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>