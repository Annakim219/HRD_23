<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat" %>
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

#tab{
	margin:10px auto;
}

#th1{
	height:40px;
	background:lightgrey;
	text-align:center;
}
td{
	height:30px;
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
</head>
<body>
	<%@ include file="header.jsp"%>
	<%@ include file="nav.jsp"%>
	<%@ include file="DBconn.jsp"%>

	<section>
		<h2>주문 목록(주문일자별 수량 및 금액 합계)</h2>
		<table id="tab" border=1>
			<tr id="th1">
				<th width=50>no</th>
				<th width=120>주문일자</th>
				<th width=100>주문자수량</th>
				<th width=150>주문금액</th>
			</tr>
		<%
 		 	DecimalFormat fo=new DecimalFormat("###,###");
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int no = 0;
		
			try{
				String sql = "select to_char(orderDate,'yyyy-mm-dd'),sum(orderQty),sum(orderQty*unitprice) from order0203 group by to_char(orderDate,'yyyy-mm-dd') order by to_char(orderDate,'yyyy-mm-dd') asc";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()){
					String orderDate = rs.getString(1);
					String sum_orderQty = rs.getString(2);
					String orderSum = rs.getString(3);
					no++;
					System.out.println("주문목록 데이터 조회 성공");									
		%>

				<tr>
					<td align=center><%=no %></td>
					<td align=center><%=orderDate %></td>
					<td align=center><%=sum_orderQty %></td>
					<td align=right><%=fo.format(Integer.parseInt(orderSum))%></td>
				</tr>
				
		<%				
				}
				
			}catch(SQLException e){
				System.out.println("주문목록 데이터 조회 실패");
				e.printStackTrace();
			}
		%>
		
		<%
			try{
				String sql = "select sum(orderQty),sum(orderQty*unitprice) from order0203";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()){
					String t_orderQty = rs.getString(1);
					String t_orderSum = rs.getString(2);
					no++;
					System.out.println("주문목록 데이터 조회 성공");				
					
					%>
			
				<tr>
					<td colspan=2 align=center style="background: lightgray;"><b>합계</b></td>
					<td align=center><b><%=t_orderQty %></b></td>
					<td align=right><b><%=fo.format(Integer.parseInt(t_orderSum)) %></b></td>
					
					<%			
				}
				
			}catch(SQLException e){
				System.out.println("주문목록 데이터 조회 실패");
				e.printStackTrace();
			}									
		%>
		</table>
		<div class="btn_group" align=center>
			<button type="button" onclick="location.href='addOrder.jsp'">작성</button>
		</div>	
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>