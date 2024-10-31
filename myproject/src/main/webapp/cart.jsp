<%@ page import="java.sql.*"%>
<jsp:include page="menu.jsp" />
<style>
table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

th, td {
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

img {
	max-width: 100px;
	max-height: 100px;
}

form {
	display: inline-block;
}

button.delete {
	padding: 5px 10px;
	margin-right: 5px;
	background-color: #f44336;
	color: white;
	border: none;
	cursor: pointer;
}

h4 {
	margin-top: 20px;
}

.alert {
	padding: 20px;
	background-color: #4CAF50;
	color: white;
	margin-bottom: 15px;
	border-radius: 5px;
	text-align: center;
}

.btn1 {
	background-color: #ff6600;
	color: white;
	border: 2px solid #ff6600;
	border-radius: 5px;
	padding: 5px 15px;
	font-weight: bold;
	transition: background-color 0.3s, color 0.3s;
}

.btn1:hover {
	background-color: #ff8533;
	color: black;
}
</style>
<%
try {
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/store";
	Connection con = DriverManager.getConnection(url, "root", "");
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery("SELECT * FROM cart");

	double totalPrice = 0;
	boolean hasProducts = false;
%>
<table>
	<thead>
		<tr>
			<th>Name</th>
			<th>Image</th>
			<th>Price</th>
			<th>Quantity</th>
			<th>Action</th>
		</tr>
	</thead>
	<tbody>
		<%
		while (rs.next()) {
			double price = Double.parseDouble(rs.getString("price"));
			int quantity = Integer.parseInt(rs.getString("quantity"));
			totalPrice += price * quantity;
			hasProducts = true;
		%>
		<tr>
			<td><%=rs.getString("name")%></td>
			<td><img src="<%=rs.getString("image_url")%>"
				alt="<%=rs.getString("name")%>"></td>
			<td>&#8377;<%=rs.getString("price")%></td>
			<td><%=rs.getString("quantity")%></td>
			<td>
				<form method="post" action="/myproject/deleteFromCart">
					<input type="hidden" name="id" value="<%=rs.getString("id")%>">
					<button type="submit" class="delete">Delete</button>
				</form>
			</td>
		</tr>
		<%
		}
		%>
	</tbody>
</table>
<%
if (!hasProducts) {
%>
<p>
	No products in the cart. <a href="biscuits.jsp">Add products</a>.
</p>
<%
}
%>

<h4>
	Total Price:&#8377;<%=totalPrice%></h4>
<div>
	<form method="post" action="/myproject/kitu">
		<button type="submit" class="btn1">Buy All</button>
	</form>
</div>

<%
con.close();
} catch (Exception e) {
out.println(e.getMessage());
}
%>

<script>
	function BuyProduct2() {
		$.ajax({
			url : "/myproject/kitu",
			type : "post",
			success : function(response) {
				alert(response);
			},
			error : function(xhr, status, error) {
				console.error(error);
			}
		});
	}
</script>
<script>
	window.onload = function() {
		var urlParams = new URLSearchParams(window.location.search);
		if (urlParams.has('message')) {
			var message = urlParams.get('message');
			var alertDiv = document.createElement('div');
			alertDiv.className = 'alert';
			alertDiv.appendChild(document.createTextNode(message));
			document.body.insertBefore(alertDiv, document.body.firstChild);
		}
	};
</script>
