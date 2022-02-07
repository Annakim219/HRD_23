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
	width: 650px; 
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
.btn_group{
	margin:10px 0 0 0;
}

.btn_group button{
	width:120px;
	height:25px;
	color:white;
	background:black;
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
		int no = 0;

		try {
			String sql = "select count(*) from store0203";
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
		<h3>거래처 목록</h3>
		<div class="cnt" align=left>
			<p>
				총 <b><%=cnt%>개</b>의 거래처가 있습니다.
			</p>
		</div>
		<table id="tab" border=1>
			<tr id="th1">
				<th width=50>no</th>
				<th width=90>거래처 코드</th>
				<th width=110>거래처 이름</th>
				<th width=150>거래처 전화번호</th>
				<th width=200>거래처 주소</th>
				<th width=50>구분</th>
			</tr>
		<%
			try{
				String sql = "select * from store0203 order by storeNo";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()){
					String storeNo = rs.getString("storeNo");
					String storeName = rs.getString("storeName");
					String storeTel = rs.getString("storeTel");
					String storeAddress = rs.getString("storeAddress");
					no++;

					System.out.println("거래처목록 데이터 조회 성공");
					
					%>

				<tr>
					<td><%=no %></a></td>
					<td><a href="storeUpdate.jsp?storeNo=<%=storeNo %>"><%=storeNo %></td>
					<td><%=storeName %></td>
					<td><%=storeTel %></td>
					<td><%=storeAddress %></td>
					<td><a href="storeDelete.jsp?storeNo=<%=storeNo %>" onclick="delOK()">삭제</a>
					
					<%
				}
				
			}catch(SQLException e){
				System.out.println("상품목록 데이터 조회 실패");
				e.printStackTrace();
			}
		%>
		
		</table>
		<div class="btn_group" align=center>
			<button type="button" onclick="location.href='addStore.jsp'">작성</button>
		</div>	
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>