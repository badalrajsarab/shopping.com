<%@ page import="java.sql.*" %>
<%
String category = request.getParameter("category");
String image1 = request.getParameter("image1");
String image2 = request.getParameter("image2");
String image3 = request.getParameter("image3");

try {
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/store";
    String user = "root";
    String password = "";
    Connection con = DriverManager.getConnection(url, user, password);

    String query = "UPDATE slider_images SET image1=?, image2=?, image3=? WHERE name=?";
    PreparedStatement ps = con.prepareStatement(query);
    ps.setString(1, image1);
    ps.setString(2, image2);
    ps.setString(3, image3);
    ps.setString(4, category);
    int rowsUpdated = ps.executeUpdate();

    con.close(); 
    response.sendRedirect("adbiscuits.jsp"); 
} catch (ClassNotFoundException | SQLException e) {
    out.println("Error: " + e.getMessage());
}
%>
