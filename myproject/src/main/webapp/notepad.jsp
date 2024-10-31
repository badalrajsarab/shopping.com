<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
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
</head>
<body>
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

<div class="container mt-4">
    <form class="d-flex" onsubmit="event.preventDefault(); filterProducts();">
        <input class="form-control me-2" type="search" id="searchBar" name="search" placeholder="Search..." aria-label="Search"  onkeyup="filterProducts()">
    </form>

    <div id="customAlertContainer"></div>

    <div class="row row-cols-1 row-cols-md-4 g-4 mt-4">
        <%
        String searchValue = request.getParameter("search");
        String searchQuery = "";
        if (searchValue != null && !searchValue.trim().isEmpty()) {
            searchQuery = " WHERE name LIKE ?";
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/store";
            Connection con = DriverManager.getConnection(url, "root", "");
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM biscuits" + searchQuery);
            
            if (searchValue != null && !searchValue.trim().isEmpty()) {
                stmt.setString(1, "%" + searchValue + "%");
            }
            
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
        %>
        <div class="col">
            <div class="card shadow-sm">
                <img src="<%= rs.getString("image_url") %>" class="bd-placeholder-img card-img-top">
                <div class="card-body">
                    <h5 class="card-title"><%= rs.getString("name") %></h5>
                    <p class="card-text"> Price: &#8377;<%= rs.getDouble("price") %></p>
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="input-group">
                            <input type="number" class="form-control" value="1" id="quantity<%= rs.getString("id") %>">
                        </div>
                        <button type="button" class="btn btn-custom" onclick="AddToCart(<%= rs.getString("id") %>, '<%= rs.getString("name") %>', '<%= rs.getString("image_url") %>', <%= rs.getDouble("price") %>)" id="cartButton<%= rs.getString("id") %>">Add to Cart</button>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            out.println("Error: " + e.getMessage());
        }
        %>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function AddToCart(id, name, image, price) {
    var quantity = document.getElementById('quantity' + id).value;

    $.ajax({
        url: 'addToCart',
        method: 'POST',
        data: {
            id: id,
            name: name,
            image: image,
            price: price,
            quantity: quantity
        },
        success: function(response) {
            var message = 'Item added to cart';
            var alertBox = '<div class="alert">' + message + '</div>';
            $('#customAlertContainer').html(alertBox);
            setTimeout(function() {
                $('#customAlertContainer').html('');
            }, 3000);
            var button = document.getElementById('cartButton' + id);
            button.innerHTML = 'Added to Cart';
            button.setAttribute('disabled', 'disabled');
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
}

function filterProducts() {
    var searchValue = document.getElementById('searchBar').value;
    window.location.href = "?search=" + searchValue;
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-L3Q+vPl+GIOJp9SoUPuQu6gTVlINt5DpcME0j2tkPSrtkIWTaOpXar4P1s2z8R3r" crossorigin="anonymous"></script>
</body>
</html>
