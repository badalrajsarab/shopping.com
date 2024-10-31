import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/kitu2")
public class kitu2 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public kitu2() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        String id = request.getParameter("id");
        String quantity = request.getParameter("quantity");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/store";
            Connection con = DriverManager.getConnection(url, "root", "");
            PreparedStatement stmt = con.prepareStatement("UPDATE product SET quantity = quantity - ? WHERE id = ?");
            stmt.setString(1, quantity);
            stmt.setString(2, id);
            int rowsAffected = stmt.executeUpdate();
            con.close();
            if (rowsAffected > 0) {
                out.println("Successfully purchased product");
            } else {
                out.println("Failed to update quantity");
            }
        } catch (Exception e) {
            out.println(e.getMessage());
        }
    }
}
