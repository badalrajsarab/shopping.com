import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/editProduct")
public class editProduct extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the product details from the request
        String productId = request.getParameter("id");
        String name = request.getParameter("name");
        String imageUrl = request.getParameter("image_url");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/store";
        String username = "root";
        String password = "";

        try (Connection con = DriverManager.getConnection(url, username, password)) {
            // Prepare and execute the SQL query to update the product details
            String query = "UPDATE biscuits SET name = ?, image_url = ?, price = ?, quantity = ? WHERE id = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, imageUrl);
            pst.setDouble(3, price);
            pst.setInt(4, quantity);
            pst.setString(5, productId);
            int rowsUpdated = pst.executeUpdate();

            // Check if the update was successful
            if (rowsUpdated > 0) {
                response.getWriter().println("Product updated successfully");
            } else {
                response.getWriter().println("Failed to update product");
            }
        } catch (SQLException e) {
            // Handle any SQL errors
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace();
        }
    }
}
