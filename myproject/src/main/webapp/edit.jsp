<jsp:include page="menu2.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Image Slider</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .carousel-item {
            height: 400px; /* Set the height of the carousel item */
            background-size: cover;
            background-position: center;
        }
    </style>
</head>
<body>
    <header>
        <div class="container mt-5">
            <h2>Choose</h2>
            <form action="" method="get">
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="category" id="biscuits" value="biscuits" checked>
                    <label class="form-check-label" for="biscuits">
                        Biscuits
                    </label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="category" id="product" value="product">
                    <label class="form-check-label" for="product">
                        Product
                    </label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="category" id="choco" value="choco">
                    <label class="form-check-label" for="choco">
                        Choco
                    </label>
                </div>
                <button type="submit" class="btn btn-primary mt-3">Show Slider</button>
            </form>
        </div>
    </header>

    <div class="container mt-5">
        <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel" data-bs-interval="2000">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <%
                String category = request.getParameter("category");
                if (category != null) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        String url = "jdbc:mysql://localhost:3306/store";
                        String user = "root";
                        String password = "";
                        Connection con = DriverManager.getConnection(url, user, password);

                        String query = "SELECT image1, image2, image3 FROM slider_images WHERE name=?";
                        PreparedStatement pstmt = con.prepareStatement(query);
                        pstmt.setString(1, category);
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

    <div class="container mt-5">    
        <h2>Update Images</h2>
        <form action="update_images.jsp" method="post">	
            <div class="mb-3">
                <label for="image1" class="form-label">Image 1 URL:</label>
                <input type="text" class="form-control" id="image1" name="image1">
            </div>
            <div class="mb-3">
                <label for="image2" class="form-label">Image 2 URL:</label>
                <input type="text" class="form-control" id="image2" name="image2">
            </div>
            <div class="mb-3">
                <label for="image3" class="form-label">Image 3 URL:</label>
                <input type="text" class="form-control" id="image3" name="image3">
            </div>
            <input type="hidden" name="category" value="<%= category %>">
            <button type="submit" class="btn btn-primary">Update Images</button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
