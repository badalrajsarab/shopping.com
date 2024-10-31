<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Products</title>
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
        crossorigin="anonymous">
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
        integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        .card-img-top {
            height: 200px; /* Set the desired height for the images */
            width: 100%; /* Ensure the image takes up the full width of its container */
            object-fit: cover; /* Ensure the image covers the entire space */
        }
        .card {
            height: 350px; /* Set a fixed height for all cards */
            margin-bottom: 20px; /* Add some bottom margin for spacing */
        }
        .card-body {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 80%; /* Fill the height of the card body */
        }
    </style>
</head>
<body>
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

                while(rs.next()) { %>
                    <div class="col">
                        <div class="card shadow-sm">
                            <img src="<%= rs.getString("image_url") %>" class="bd-placeholder-img card-img-top">
                            <div class="card-body">
                                <h5 class="card-title"><%= rs.getString("name") %></h5>
                                <p class="card-text">&#8377;<%= rs.getDouble("price") %></p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="input-group">
                                        <input type="number" class="form-control" value="1" id="quantity<%= rs.getString("id") %>">
                                    </div>
                                    <button type="button" class="btn btn-primary" onclick="buyProduct(<%= rs.getString("id") %>)">Buy</button>
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
            } %>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
    function buyProduct(id) {
        var quantity = document.getElementById('quantity' + id).value;
        $.ajax({
            url: "/myproject/kitu2",
            type: "post",
            data: {
                id: id,
                quantity: quantity
            },
            success: function(response) {
                alert(response);
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
    }
    </script>
</body>
</html>
