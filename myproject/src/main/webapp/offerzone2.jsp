<jsp:include page="menu2.jsp" />
<%@ page import="java.sql.*"%>
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

.modal-body {
	color: #d245b5;
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
</style>
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
            url: "/myproject/deleteoffer",
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
            url: "/myproject/upoffer?id=" + id,
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
