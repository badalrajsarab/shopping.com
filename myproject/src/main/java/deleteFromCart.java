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

@WebServlet("/deleteFromCart")
public class deleteFromCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/store";
                Connection con = DriverManager.getConnection(url, "root", "");
                PreparedStatement stmt = con.prepareStatement("DELETE FROM cart WHERE id = ?");
                stmt.setString(1, id);
                stmt.executeUpdate();
                con.close();
                response.sendRedirect("cart.jsp"); // Redirect to cart page after deletion
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Failed to delete item from cart.");
            }
        } else {
            response.getWriter().println("Invalid item ID.");
        }
    }
}
