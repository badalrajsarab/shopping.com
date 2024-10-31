<%@ page import="java.sql.*"%>

<%
String id = request.getParameter("id");

if (id != null) {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/store";
        Connection con = DriverManager.getConnection(url, "root", "");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM offerzone WHERE id = " + id);

        if (rs.next()) {
%>
<form action="/myproject/updateoffer" method="post">
    <input type="hidden" name="id" value="<%=rs.getString("id")%>">
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" value="<%=rs.getString("name")%>">
    <br>
    <label for="image_url">Image URL:</label>
    <input type="text" id="image_url" name="image_url" value="<%=rs.getString("image_url")%>">
    <br>
    <label for="price">Price:</label>
    <input type="text" id="price" name="price" value="<%=rs.getDouble("price")%>">
    <br>
    <label for="quantity">Quantity:</label>
    <input type="text" id="quantity" name="quantity" value="<%=rs.getString("quantity")%>">
    <br>
     <label for="description">Description:</label>
    <textarea id="description" name="description"><%=rs.getString("description")%></textarea>
    <br>
    <label for="manufacturing">Manufacturing Date:</label>
    <input type="date" id="manufacturing" name="manufacturing" value="<%=rs.getString("manufacturing_date")%>">
    <br>
    <label for="expiry">Expiry Date:</label>
    <input type="date" id="expiry" name="expiry" value="<%=rs.getString("expiry_date")%>">
    <br>
    <input type="submit" value="Update">
</form>

<%
        }
        con.close();
    } catch (Exception e) {
        out.println(e.getMessage());
    }
}
%>
