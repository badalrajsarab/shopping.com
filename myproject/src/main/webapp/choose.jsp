<jsp:include page="menu2.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String product = request.getParameter("product");
if (product != null) {
	if (product.equals("biscuits")) {
%>
<h3 class="text-center">Add a new biscuit.</h3>
<div class="container">
	<div class="row">
		<div class="col-md-6">
			<form method="post" action="/myproject/demo2">
				<label for="productName">Product Name:</label> <input type="text"
					id="productName" name="productName" required><br> <label
					for="imageURL">Image URL:</label> <input type="text" id="imageURL"
					name="imageURL" required><br> <label for="price">Price:</label>
				<input type="number" id="price" name="price" required><br>
				<label for="quantity">Quantity:</label> <input type="number"
					id="quantity" name="quantity" required><br>
					<label for="manufacturingDate">Manufacturing Date:</label>
                <input type="date" id="manufacturingDate" name="manufacturingDate" required><br>
                <label for="expiryDate">Expiry Date:</label>
                <input type="date" id="expiryDate" name="expiryDate" required><br>
                  <label for="description">Description:</label>
                <textarea id="description" name="description" required></textarea><br>
                <input type="submit" value="Add New Product">
			</form>
		</div>
		<div class="col-md-6">
			<%@ page import="java.sql.*"%>
			<%
			try {
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/store";
				Connection con = DriverManager.getConnection(url, "root", "");
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery("select * from biscuits");
			%>
			<form method="post" action="/myproject/updateQuantity">
				<select id="id" name="id">
					<%
					while (rs.next()) {
					%>
					<option value="<%=rs.getString("id")%>"><%=rs.getString("name")%></option>
					<%
					}
					%>
				</select><br> Quantity: <input type="text" name="quantity" id="quantity">
				<input type="submit" value="Add Quantity">
			</form>
			<%
			con.close();
			} catch (Exception e) {
			out.println(e.getMessage());
			}
			%>
		</div>
	</div>
</div>
<%
} else if (product.equals("soap")) {
%>
<h3 class="text-center">Add a new product.</h3>
<div class="container">
	<div class="row">
		<div class="col-md-6">
			<form method="post" action="/myproject/demo">
				<label for="productName">Product Name:</label> <input type="text"
					id="productName" name="productName" required><br> <label
					for="imageURL">Image URL:</label> <input type="text" id="imageURL"
					name="imageURL" required><br> <label for="price">Price:</label>
				<input type="number" id="price" name="price" required><br>
				<label for="quantity">Quantity:</label> <input type="number"
					id="quantity" name="quantity" required><br>
					<label for="manufacturingDate">Manufacturing Date:</label>
                <input type="date" id="manufacturingDate" name="manufacturingDate" required><br>
                <label for="expiryDate">Expiry Date:</label>
                <input type="date" id="expiryDate" name="expiryDate" required><br>
                  <label for="description">Description:</label>
                <textarea id="description" name="description" required></textarea><br>
                <input type="submit" value="Add New Product">
			</form>
		</div>
		<div class="col-md-6">
			<%@ page import="java.sql.*"%>
			<%
			try {
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/store";
				Connection con = DriverManager.getConnection(url, "root", "");
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery("select * from product");
			%>
			<form method="post" action="/myproject/soap">
				<select id="id" name="id">
					<%
					while (rs.next()) {
					%>
					<option value="<%=rs.getString("id")%>"><%=rs.getString("name")%></option>
					<%
					}
					%>
				</select><br> Quantity: <input type="text" name="quantity" id="quantity">
				<input type="submit" value="Add Quantity">
			</form>
			<%
			con.close();
			} catch (Exception e) {
			out.println(e.getMessage());
			}
			%>
		</div>
	</div>
</div>
<%
} else if (product.equals("chocolate")) {
%>
<h3 class="text-center">Add a new chocolate.</h3>
<div class="container">
	<div class="row">
		<div class="col-md-6">
			<form method="post" action="/myproject/demo3">
				<label for="productName">Product Name:</label> <input type="text"
					id="productName" name="productName" required><br> <label
					for="imageURL">Image URL:</label> <input type="text" id="imageURL"
					name="imageURL" required><br> <label for="price">Price:</label>
				<input type="number" id="price" name="price" required><br>
				<label for="quantity">Quantity:</label> <input type="number"
					id="quantity" name="quantity" required><br>
					<label for="manufacturingDate">Manufacturing Date:</label>
                <input type="date" id="manufacturingDate" name="manufacturingDate" required><br>
                <label for="expiryDate">Expiry Date:</label>
                <input type="date" id="expiryDate" name="expiryDate" required><br>
                  <label for="description">Description:</label>
                <textarea id="description" name="description" required></textarea><br>
                <input type="submit" value="Add New Product">
			</form>
		</div>
		<div class="col-md-6">
			<%@ page import="java.sql.*"%>
			<%
			try {
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/store";
				Connection con = DriverManager.getConnection(url, "root", "");
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery("select * from choco");
			%>
			<form method="post" action="/myproject/choco">
				<select id="id" name="id">
					<%
					while (rs.next()) {
					%>
					<option value="<%=rs.getString("id")%>"><%=rs.getString("name")%></option>
					<%
					}
					%>
				</select><br> Quantity: <input type="text" name="quantity" id="quantity">
				<input type="submit" value="Add Quantity">
			</form>
			<%
			con.close();
			} catch (Exception e) {
			out.println(e.getMessage());
			}
			%>
		</div>
	</div>
</div>
<%
} else if (product.equals("offerzone")) {
%>
<h3 class="text-center">Add a new offerzone.</h3>
<div class="container">
	<div class="row">
		<div class="col-md-6">
			<form method="post" action="/myproject/offerzone">
				<label for="productName">Product Name:</label> <input type="text"
					id="productName" name="productName" required><br> <label
					for="imageURL">Image URL:</label> <input type="text" id="imageURL"
					name="imageURL" required><br> <label for="price">Price:</label>
				<input type="number" id="price" name="price" required><br>
				<label for="quantity">Quantity:</label> <input type="number"
					id="quantity" name="quantity" required><br>
					<label for="manufacturingDate">Manufacturing Date:</label>
                <input type="date" id="manufacturingDate" name="manufacturingDate" required><br>
                <label for="expiryDate">Expiry Date:</label>
                <input type="date" id="expiryDate" name="expiryDate" required><br>
                  <label for="description">Description:</label>
                <textarea id="description" name="description" required></textarea><br>
                <input type="submit" value="Add New Product">
			</form>
		</div>
		<div class="col-md-6">
			<%@ page import="java.sql.*"%>
			<%
			try {
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/store";
				Connection con = DriverManager.getConnection(url, "root", "");
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery("select * from offerzone");
			%>
			<form method="post" action="/myproject/offer">
				<select id="id" name="id">
					<%
					while (rs.next()) {
					%>
					<option value="<%=rs.getString("id")%>"><%=rs.getString("name")%></option>
					<%
					}
					%>
				</select><br> Quantity: <input type="text" name="quantity" id="quantity">
				<input type="submit" value="Add Quantity">
			</form>
			<%
			con.close();
			} catch (Exception e) {
			out.println(e.getMessage());
			}
			%>
		</div>
	</div>
</div>
<%
}
} else {
%>
<h1>No product chosen</h1>
<%
}
%>

<style>
form {
	max-width: 400px;
	margin: 0 auto;
	padding: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
	background-color:#f3d0f059;
}

select, input[type="text"], input[type="submit"] {
	width: 100%;
	padding: 10px;
	margin: 5px 0;
	border-radius: 3px;
	border: 1px solid #ccc;
	box-sizing: border-box;
}

input[type="submit"] {
	background-color: #8f50adb3;
	color: white;
	border: none;
	cursor: pointer;
}

input[type="submit"]:hover {
	background-color: #0e0c10bd;
}
</style>
