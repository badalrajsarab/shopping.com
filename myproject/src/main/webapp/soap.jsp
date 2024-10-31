<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.sql.*, java.io.*"%>
<jsp:include page="menu.jsp" />
<header>
	<div id="carouselExampleCaptions" class="carousel slide"
		data-bs-ride="carousel" data-bs-interval="2000">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <%
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/store";
                    String user = "root";
                    String password = "";
                    Connection con = DriverManager.getConnection(url, user, password);

                    String query = "SELECT image1, image2, image3 FROM slider_images WHERE name=?";
                    PreparedStatement pstmt = con.prepareStatement(query);
                    pstmt.setString(1, "product"); 
                    ResultSet rs = pstmt.executeQuery();

                    if (rs.next()) {
                %>
                        <div class="carousel-item active" id="slide1" style="background-image: url('<%= rs.getString("image1") %>')">
                        </div>
                        <div class="carousel-item" id="slide2" style="background-image: url('<%= rs.getString("image2") %>')">
                        </div>
                        <div class="carousel-item" id="slide3" style="background-image: url('<%= rs.getString("image3") %>')">
                        </div>
                <%
                    }
                    con.close();
                } catch (ClassNotFoundException | SQLException e) {
                    out.println("Error: " + e.getMessage());
                }
                %>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>
</header>
<style>
.carousel-item {
  height: 65vh;
  min-height: 350px;
  background: no-repeat center center scroll;
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}
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
.btn-custom {
    background-color: #ff6600; /* Orange background */
    color: white; /* White text color */
    border: 2px solid #ff6600; /* Orange border */
    border-radius: 5px; /* Rounded corners */
    padding: 5px 15px; /* Padding */
    font-weight: bold; /* Bold text */
}

.btn-custom:hover {
    background-color: #ff8533; /* Darker orange on hover */
    border-color: #ff8533; /* Darker orange border on hover */
}
.alert {
    padding: 20px;
    background-color: #4CAF50;
    color: white;
    margin-bottom: 15px;
    border-radius: 5px;
    text-align: center;
}

</style>
</head>
<body>
<div id="customAlertContainer"></div>

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
							<button type="button" class="btn btn-custom"
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
	            var message = name + " added to cart. Quantity: " + quantity;
	            var alertBox = '<div class="alert">' + message + '</div>';
	            $('#customAlertContainer').html(alertBox);
	            setTimeout(function() {
	                $('#customAlertContainer').html('');
	            }, 3000);
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
   