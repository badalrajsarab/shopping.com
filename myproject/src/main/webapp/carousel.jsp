
<%@ page import="java.sql.*" %>
    <style>
        .carousel-item {
            height: 400px; 
            background-size: cover;
            background-position: center;
        }
    </style>
<body>
    <div class="container mt-5">
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
                    pstmt.setString(1, "choco"); // Retrieve images for the "biscuits" category
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

</body>

https://cdn.wallpapersafari.com/76/82/HYMK2B.jpg
