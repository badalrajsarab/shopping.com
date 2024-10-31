<%@ page import="java.sql.*"%>
<jsp:include page="menu.jsp" />
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
    background-color: #ff6600; 
    color: white; 
    border: 2px solid #ff6600; 
    border-radius: 5px; 
    padding: 5px 15px; 
    font-weight: bold; 
}

.btn-custom:hover {
    background-color: #ff8533; 
    border-color: #ff8533; 
}
.alert {
	padding: 20px;
	background-color: #4CAF50;
	color: white;
	margin-bottom: 15px;
	border-radius: 5px;
	text-align: center;
}
.alert {
    padding: 20px;
    background-color: #4CAF50;
    color: white;
    margin-bottom: 15px;
    border-radius: 5px;
    text-align: center;
}

.discounted-price {
	color: red; /* Or any other style you want */
	font-weight: bold;
}

.original-price {
	text-decoration: line-through;
	color: gray;
	font-style: italic;
}
</style>
</head>
<body>
<div id="customAlertContainer"></div>

	<div class="container">
		<div class="row row-cols-1 row-cols-md-4 g-4">
			<%
			try {
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/store";
				Connection con = DriverManager.getConnection(url, "root", "");
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM offerzone");

				while (rs.next()) {
                    // Discount calculation
                    double price = rs.getDouble("price");
                    double discount = 0.20; // 20% discount
                    double discountedPrice = price - (price * discount);
			%>
			<div class="col">
    <div class="card shadow-sm">
        <img src="<%=rs.getString("image_url")%>" class="bd-placeholder-img card-img-top">
        <div class="card-body">
            <h5 class="card-title"><%=rs.getString("name")%></h5>
            <p class="card-text"> Price: &#8377;<span class="original-price"><%=price%></span> <span class="discounted-price">&#8377;<%=discountedPrice%></span></p>
            <div class="d-flex justify-content-between align-items-center">
                <div class="input-group">
                    <input type="number" class="form-control" value="1" id="quantity<%=rs.getString("id")%>">
                </div>
               <button type="button" class="btn btn-custom"
        onclick="AddToCart(<%=rs.getString("id")%>, '<%=rs.getString("name")%>', '<%=rs.getString("image_url")%>', <%=discountedPrice%>)" id="cartButton<%=rs.getString("id")%>">Add to Cart</button>

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
            var message = name + " added to cart. Quantity: " + quantity;
            var alertBox = '<div class="alert">' + message + '</div>';
            $('#customAlertContainer').html(alertBox);
            setTimeout(function() {
                $('#customAlertContainer').html('');
            }, 5000);
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
