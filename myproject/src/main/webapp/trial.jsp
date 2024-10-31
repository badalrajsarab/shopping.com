<%@ page import="java.sql.*"%>
<jsp:include page="menu.jsp" />
<header>
    <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel" data-bs-interval="2000">
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
                pstmt.setString(1, "biscuits");
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
            %>
                    <div class="carousel-item active" id="slide1" style="background-image: url('<%= rs.getString("image1") %>')"></div>
                    <div class="carousel-item" id="slide2" style="background-image: url('<%= rs.getString("image2") %>')"></div>
                    <div class="carousel-item" id="slide3" style="background-image: url('<%= rs.getString("image3") %>')"></div>
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
</style>

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
                        <button type="button" class="btn btn-custom" onclick="showQuantityModal('<%=rs.getString("id")%>', '<%=rs.getString("name")%>', '<%=rs.getString("image_url")%>', <%=rs.getDouble("price")%>)" id="cartButton<%=rs.getString("id")%>">Add to Cart</button>
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

<!-- Modal for quantity selection -->
<div class="modal fade" id="quantityModal" tabindex="-1" aria-labelledby="quantityModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="quantityModalLabel">Select Quantity</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="input-group">
                    <input type="number" class="form-control" id="modalQuantity" value="1" min="1">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="addToCart()">Add to Cart</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
let currentProduct = {};

function showQuantityModal(id, name, image_url, price) {
    currentProduct = { id, name, image_url, price };
    document.getElementById('quantityModalLabel').innerText = name;
    $('#quantityModal').modal('show');
}

function addToCart() {
    const quantity = document.getElementById('modalQuantity').value;
    const { id, name, image_url, price } = currentProduct;

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
        success: function(response) {
            var message = name + " added to cart. Quantity: " + quantity;
            var alertBox = '<div class="alert">' + message + '</div>';
            $('#customAlertContainer').html(alertBox);
            setTimeout(function() {
                $('#customAlertContainer').html('');
            }, 3000);
            $('#quantityModal').modal('hide');
            
            // Disable the Add to Cart button and change text
            var button = document.getElementById('cartButton' + id);
            button.innerHTML = 'Added to Cart';
            button.setAttribute('disabled', 'disabled');
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
}
</script>
</body>
