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
	width: 1030px; 
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
			String sql = "select count(*) from product0203";
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
		<h3>상품 목록</h3>
		<div class="cnt" align=left>
			<p>
				총 <b><%=cnt%>개</b>의 상품이 있습니다.
			</p>
		</div>
		<table id="tab" border=1>
			<tr id="th1">
				<th width=100>상품코드</th>
				<th width=120>상품명</th>
				<th width=120>단가</th>
				<th width=200>상세정보</th>
				<th width=120>제조사</th>
				<th width=100>분류</th>
				<th width=80>재고수</th>
				<th width=120>상태</th>
				<th width=80>구분</th>
			</tr>
		<%
			try{
				String sql = "select * from product0203";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()){
					String productId = rs.getString("productId");
					String name = rs.getString("name");
					String unitprice = rs.getString("unitprice");
					String description = rs.getString("description");
					String category = rs.getString("category");
					String manufacturer = rs.getString("manufacturer");
					String unitsInstock = rs.getString("unitsInstock");
					String condition = rs.getString("condition");
					System.out.println("상품목록 데이터 조회 성공");
					
					if(category.equals("10")){category="it 제품";}
					else if(category.equals("20")){category="주방제품";}
					else if(category.equals("30")){category="전자제품";}
					else if(category.equals("40")){category="일반잡화";}
					%>

				<tr>
					<td><a href="productUpdate.jsp?productId=<%=productId %>"><%=productId %></a></td>
					<td><%=name %></td>
					<td><%=unitprice %></td>
					<td><%=description %></td>
					<td><%=manufacturer %></td>
					<td><%=category %></td>
					<td><%=unitsInstock %></td>
					<td><%=condition %></td>
					<td><a href="productDelete.jsp?productId=<%=productId %>" onclick="delOK()">삭제</a>
					
					<%
				}
				
			}catch(SQLException e){
				System.out.println("상품목록 데이터 조회 실패");
				e.printStackTrace();
			}
		%>
		
		</table>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>