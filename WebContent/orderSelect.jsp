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
	width: 1000px; 
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
			String sql = "select count(*) from order0203";
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
		<h3>주문 목록</h3>
		<div class="cnt" align=left>
			<p>
				총 <b><%=cnt%>개</b>의 주문정보가 있습니다.
			</p>
		</div>
		<table id="tab" border=1>
			<tr id="th1">
				<th width=50>no</th>
				<th width=160>주문일자</th>
				<th width=90>주문자성명</th>
				<th width=90>상품번호</th>
				<th width=140>상품명</th>
				<th width=100>단가</th>
				<th width=80>주문수량</th>
				<th width=200>주문자주소</th>
				<th width=90>구분</th>
			</tr>
		<%
			int no = 0;
		
			try{
				String sql = "select to_char(a.orderDate,'yyyy-mm-dd'), a.orderName, a.productId, b.name, a.unitprice, a.orderQty, a.orderAddress from order0203 a, product0203 b where a.productId=b.productId";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()){
					String orderDate = rs.getString(1);
					String orderName = rs.getString(2);
					String productId = rs.getString(3);
					String name = rs.getString(4);
					String unitprice = rs.getString(5);
					String orderQty = rs.getString(6);
					String orderAddress = rs.getString(7);
					no++;
					System.out.println("주문목록 데이터 조회 성공");
					%>

				<tr>
					<td><%=no %></td>
					<td><%=orderDate %></td>
					<td><%=orderName %></td>
					<td><%=productId %></td>
					<td><%=name %></td>
					<td><%=unitprice %></td>
					<td><%=orderQty %></td>
					<td><%=orderAddress %></td>
					<td>
					<a href="orderUpdate.jsp?orderName=<%=orderName %>&orderDate=<%=orderDate %>">수정</a>
					<span>/</span>
					<a href="orderDelete.jsp?orderName=<%=orderName %>&orderDate=<%=orderDate %>" onclick="delOK()">삭제</a>
					
					<%
				}
				
			}catch(SQLException e){
				System.out.println("주문목록 데이터 조회 실패");
				e.printStackTrace();
			}
		%>
		
		</table>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>