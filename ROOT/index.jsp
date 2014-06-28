<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="teatapi1.Add" %>
<jsp:directive.page import="java.sql.Date" />
<jsp:directive.page import="java.sql.Timestamp" />
<jsp:directive.page import="java.sql.SQLException"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>My JSP 'listPerson.jsp' starting page</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<style type="text/css">body, td, th, input {font-size:12px; text-align:center; }</style>
	</head>
	<body>

		<table align=right>
			<tr>

				<td><a href="addPerson.jsp">
				<%
				int aa = 5;
				int bb =3;
				Add ad = new Add();
				int cc= ad.addnumber(aa,bb);
				out.println(cc);
				%></a>
				</td>
			</tr>
		</table>
		<br />
		<br />
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try{
		// 註冊 MySQL 驅動. 也可以使用下面兩種方式的任一種
		DriverManager.registerDriver(new com.mysql.jdbc.Driver());
		//new com.mysql.jdbc.Driver();
		//Class.forName("com.mysql.jdbc.Driver").newInstance();
		
		// 獲得資料庫連接。 三個參數分別為 連接URL，使用者名稱，密碼
		conn = DriverManager.getConnection(
							"jdbc:mysql://localhost:3306/member_database", 
							"root", 
							"801230");
		
		// 獲得 Statement。 Statement 對像用於執行 SQL。相當於控制台。
		stmt = conn.createStatement();
		String str=" select a.order_key,a.member,a.order_time,a.order_remark,b.name,c.product,c.product_number,d.product_name,d.product_price " ;
		str+=" from order_table a ";
		str+=" inner join member_table b ";
		str+=" on a.member =b.member ";
		str+=" inner join order_schedule_table c ";
		str+=" on a.order_key =c.order_key";
		str+=" inner join product_table d";
		str+=" on c.product =d.product";
		
				// 使用 Statement 執行 SELECT 敘述。傳回結果集。
		rs = stmt.executeQuery(str);	
%>
		<form action="operatePerson.jsp" method=get>
			<table bgcolor="#CCCCCC" cellspacing=1 cellpadding=5 width=100%>
				<tr bgcolor=#DDDDDD>
					<th></th>
					<th>
						ID
					</th>
					<th>
						訂單主表
					</th>
					<th>
						訂單時間
					</th>
					<th>
						訂單備註
					</th>
					<th>
						姓名
					</th>
					<th>
						訂單明細表
					</th>
					<th>
						商品
					</th>
					<th>
						商品名稱
					</th>
					<th>
						商品價格
					</th>
				</tr>
				<%
					// 檢查結果集。rs.next() 傳回結果集中是否還有下一條記錄。如果有，自動捲動到下一條記錄並傳回 true
					while (rs.next())
					{

						
						
						
						//member varchar
					//	name varchar
						//sex varchar
						//phone varchar
						//address varchar
						//order_schedule varchar
						//order_key varchar
						//product varchar
						//product_number int
					//	order_time datetime
				//		order_remark varchar
			//			product varchar
		//				product_name varchar
	//					product_description varchar
//						product_price int



						
						
						
						
						int order_key = rs.getInt("order_key"); // 整形類型
						int product_price  = rs.getInt("product_price");

						int product_number = rs.getInt("product_number");
						String 	product_name=rs.getString("product_name");
						String member = rs.getString("member"); // 字串類型
						String order_remark = rs.getString("order_remark");
						String name = rs.getString("name");
						//String description = rs.getString("description");
						String product=rs.getString("product");
						Date order_time = rs.getDate("order_time"); // 日期類型，只有日期資訊而沒有時間資訊
						//Timestamp createTime = rs.getTimestamp("create_time"); // 時間戳類型，既有日期又有時間。

						out.println("		<tr bgcolor=#FFFFFF>");
						out.println("	<td><input type=checkbox name=id value=" + order_key 
						+ "></td>");
						out.println("	<td>" + order_key  + "</td>");
						out.println("	<td>" + member + "</td>");
						out.println("	<td>" +order_time + "</td>");
						out.println("	<td>" + order_remark+ "</td>");
						out.println("	<td>" + name + "</td>");
						out.println("	<td>" + product + "</td>");
						out.println("	<td>" + product_number + "</td>");
						out.println("	<td>" + product_name + "</td>");
						
						out.println("	<td>" + product_price+ "</td>");
							//out.println("	<td>" + birthday + "</td>");
						//out.println("	<td>" + description + "</td>");
						//out.println("	<td>" + createTime + "</td>");
						out.println("	<td>");
						out.println("		<a href='operatePerson.jsp?action=del&id="
						+ order_key + "' onclick='return confirm(\"確定刪除該記錄？\")'>刪除</a>");
						out.println("		<a href='operatePerson.jsp?action=edit&id="
						+ order_key + "'>修改</a>");
						out.println("	</td>");
						out.println("		</tr>");

					}
				%>
			</table>
			<table align=left>
				<tr>
					<td>
						<input type='hidden' value='del' name='action'>
						<a href='#'
							onclick="var array=document.getElementsByName('id');for(var i=0; i<array.length;
							i++){array[i].checked=true;}">全選</a>
						<a href='#'
							onclick="var array=document.getElementsByName('id');for(var i=0; i<array.length;
							i++){array[i].checked=false;}">取消全選</a>
						<input type='submit'
							onclick="return confirm('即將刪除所選擇的記錄。是否刪除？'); " value='刪除'>
					</td>
				</tr>
			</table>
		</form>
<%
	}catch(SQLException e){
		out.println("發生了例外：" + e.getMessage());
		e.printStackTrace();
	}finally{
			// 關閉
			if(rs != null)
				rs.close();
			if(stmt != null)
				stmt.close();
			if(conn != null)
				conn.close();
	}
%>
	</body>
</html>
