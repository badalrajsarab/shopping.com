import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateProduct")
public class updateProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public updateProduct() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/update_product.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the form data
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String imageUrl = request.getParameter("image_url");
        String price = request.getParameter("price");
        String quantity = request.getParameter("quantity");
        String description = request.getParameter("description");
        String manufacturingDate = request.getParameter("manufacturing");
        String expiryDate = request.getParameter("expiry");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/store";
            Connection con = DriverManager.getConnection(url, "root", "");

            String sql = "UPDATE product SET name=?, image_url=?, price=?, quantity=?, description=?, manufacturing_date=?, expiry_date=? WHERE id=?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, imageUrl);
            statement.setString(3, price);
            statement.setString(4, quantity);
            statement.setString(5, description);
            statement.setString(6, manufacturingDate);
            statement.setString(7, expiryDate);
            statement.setString(8, id);

            int rowsUpdated = statement.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("adsoap.jsp?message=Product updated successfully");

            } else {
                response.getWriter().println("Failed to update product.");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred.");
        }
    }
}
