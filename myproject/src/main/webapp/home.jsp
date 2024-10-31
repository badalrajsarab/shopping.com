<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet" %>
<jsp:include page="menu.jsp" />
<div class="container">
		<div class="row row-cols-1 row-cols-md-4 g-4">
			<%
			try {
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/store";
				Connection con = DriverManager.getConnection(url, "root", "");
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM biscuits");

				while (rs.next()) {
			%>
			<div class="col">
    <div class="card shadow-sm">
        <img src="<%=rs.getString("image_url")%>" class="bd-placeholder-img card-img-top">
        <div class="card-body">
            <h5 class="card-title"><%=rs.getString("name")%></h5>
            <p class="card-text"> Price: &#8377;<%=rs.getDouble("price")%></p>
            <div class="d-flex justify-content-between align-items-center">
                <div class="input-group">
                    <input type="number" class="form-control" value="1" id="quantity<%=rs.getString("id")%>">
                </div>
                <button type="button" class="btn btn-primary"
        onclick="AddToCart(<%=rs.getString("id")%>, '<%=rs.getString("name")%>', '<%=rs.getString("image_url")%>', <%=rs.getDouble("price")%>)" id="cartButton<%=rs.getString("id")%>">Add to Cart</button>

            </div>
        </div>
    </div>
</div>
			<%
			}
			con.close();
			} catch (Exception e) {
			out.println(e.getMessage());
			}
			%>
		</div>
	</div>
<div class="container">
		<div class="row row-cols-1 row-cols-md-4 g-4">
			<%
			int productIdCounter = 1;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/store";
				Connection con = DriverManager.getConnection(url, "root", "");
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM product");

				while (rs.next()) {
			%>
			<div class="col">
				<div class="card shadow-sm">
					<img src="<%=rs.getString("image_url")%>"
						class="bd-placeholder-img card-img-top">
					<div class="card-body">
						<h5 class="card-title"><%=rs.getString("name")%></h5>
						<p class="card-text">
							&#8377;<%=rs.getDouble("price")%></p>
						<div class="d-flex justify-content-between align-items-center">
							<div class="input-group">
								<input type="number" class="form-control" value="1"
									id="quantity<%=rs.getString("id")%>">
							</div>
							 <button type="button" class="btn btn-primary"
        onclick="AddToCart(<%=rs.getString("id")%>, '<%=rs.getString("name")%>', '<%=rs.getString("image_url")%>', <%=rs.getDouble("price")%>)" id="cartButton<%=rs.getString("id")%>">Add to Cart</button>

						</div>
					</div>
				</div>
			</div>
			<%
			productIdCounter++;
			}
			con.close();
			} catch (Exception e) {
			out.println(e.getMessage());
			}
			%>
		</div>
	</div>
   	<div class="container">
		<div class="row row-cols-1 row-cols-md-4 g-4">
			<%
			try {
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/store";
				Connection con = DriverManager.getConnection(url, "root", "");
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM choco");

				while (rs.next()) {
			%>
			<div class="col">
				<div class="card shadow-sm">
					<img src="<%=rs.getString("image_url")%>"
						class="bd-placeholder-img card-img-top">
					<div class="card-body">
						<h5 class="card-title"><%=rs.getString("name")%></h5>
						<p class="card-text">
						 Price: &#8377;<%=rs.getDouble("price")%></p>
						<div class="d-flex justify-content-between align-items-center">
							<div class="input-group">
								<input type="number" class="form-control" value="1"
									id="quantity<%=rs.getString("id")%>">
							</div>
						 <button type="button" class="btn btn-primary"
        onclick="AddToCart(<%=rs.getString("id")%>, '<%=rs.getString("name")%>', '<%=rs.getString("image_url")%>', <%=rs.getDouble("price")%>)" id="cartButton<%=rs.getString("id")%>">Add to Cart</button>


						</div>
					</div>
				</div>
			</div>
			<%
			}
			con.close();
			} catch (Exception e) {
			out.println(e.getMessage());
			}
			%>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<script>
	function AddToCart(id, name, image_url, price) {
	    var quantity = document.getElementById('quantity' + id).value;
	    $.ajax({
	        url: "/myproject/addToCart",
	        type: "post",
	        data: {
	            id: id,
	            name: name,
	            image_url: image_url,
	            price: price,
	            quantity: quantity
	        },
	        success: function (response) {
	            alert(response);
	            var button = document.getElementById('cartButton' + id);
	            button.innerHTML = 'Added to Cart';
	            button.setAttribute('disabled', 'disabled');
	        },
	        error: function (xhr, status, error) {
	            console.error(error);
	        }
	    });
	}
</script>
	
<style>
.card-img-top {
	height: 200px;
	width: 100%;
	object-fit: cover;
}

.card {
	height: 350px;
	margin-bottom: 20px;
}

.card-body {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	height: 80%;
}

form {
	max-width: 400px;
	margin: 0 auto;
	padding: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
	background-color: #f9f9f9;
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
	background-color: #4CAF50;
	color: white;
	border: none;
	cursor: pointer;
}

input[type="submit"]:hover {
	background-color: #45a049;
}
</style>