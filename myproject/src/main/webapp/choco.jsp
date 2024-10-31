<jsp:include page="menu2.jsp" />
<%@ page import="java.sql.*"%>

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
                    pstmt.setString(1, "choco"); 
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
            height: 60vh;
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
	background-color: #f3d0f059;
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

.modal-body {
	color: #d245b5;
}
</style>
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
			<div class="card shadow-sm"
				data-description="<%=rs.getString("description")%>"
				data-name="<%=rs.getString("name")%>"
				data-manufacturing="<%=rs.getString("manufacturing_date")%>"
				data-expiry="<%=rs.getString("expiry_date")%>"
				data-imageUrl="<%=rs.getString("image_url")%>">

				<img src="<%=rs.getString("image_url")%>"
					class="bd-placeholder-img card-img-top">
				<div class="card-body">
					<h5 class="card-title"><%=rs.getString("name")%></h5>
					<p class="card-text">
						Quantity:
						<%=rs.getString("quantity")%><br> Price: &#8377;<%=rs.getDouble("price")%></p>
					<div class="d-flex justify-content-between align-items-center">
						<div class="input-group">
							<button type="button" class="btn btn-info"
								onclick="showDescription(this)">Details</button>
						</div>
						<button type="button" class="btn btn-primary"
							onclick="updateProduct(<%=rs.getString("id")%>)">Update
						</button>

						<button type="button" class="btn btn-danger"
							onclick="deleteProduct(<%=rs.getString("id")%>)">Delete
						</button>
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

<div class="modal fade" id="updateProductModal" tabindex="-1"
	aria-labelledby="updateProductModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="updateProductModalLabel">Update
					Product</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="updateFormContainer"></div>
		</div>
	</div>
</div>
<div class="modal fade" id="descriptionModal" tabindex="-1"
	aria-labelledby="descriptionModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="descriptionModalLabel"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="descriptionModalBody"></div>
		</div>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
function showDescription(button) {
    var card = $(button).closest('.card');
    var name = card.data('name');
    var description = card.data('description');
    var manufacturing = card.data('manufacturing');
    var expiry = card.data('expiry');
    var imageUrl = card.data('imageurl'); // Use 'imageurl' instead of 'image-url'

    var modalBody = "<b>Name:</b> " + name + "<br><img src='" + imageUrl + "' style='max-width: 200px; max-height: 200px;' /><br><b>Description:</b> " + description + "<br><b>Manufacturing Date:</b> " + manufacturing + "<br><b>Expiry Date:</b> " + expiry;

    $('#descriptionModalLabel').text("Product Details");
    $('#descriptionModalBody').html(modalBody);
    $('#descriptionModal').modal('show');
}
</script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    function deleteProduct(id) {
        $.ajax({
            url: "/myproject/deleteProduct3",
            type: "post",
            data: {
                id: id
            },
            success: function (response) {
                alert(response);
                location.reload();
            },
            error: function (xhr, status, error) {
                console.error(error);
            }
        });
    }

    function updateProduct(id) {
        $.ajax({
            url: "/myproject/upchoco?id=" + id,
            type: "get",
            success: function (response) {
                $('#updateFormContainer').html(response);
                $('#updateProductModal').modal('show');
            },
            error: function (xhr, status, error) {
                console.error(error);
            }
        });
    }
</script>
