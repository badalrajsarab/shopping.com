import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateQuantity")
public class updateQuantity extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public updateQuantity() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String id = request.getParameter("id");
        String quantity = request.getParameter("quantity");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/store";
            Connection con = DriverManager.getConnection(url, "root", "");
            PreparedStatement stmt = con.prepareStatement("update biscuits SET quantity = quantity + ? where id = ?");
            stmt.setString(1, quantity);
            stmt.setString(2, id);
            int rowsAffected = stmt.executeUpdate();
            con.close();
            if (rowsAffected > 0) {
                response.sendRedirect("adbiscuits.jsp?message=quantity added successfully");
            } else {
                out.println("Failed to update quantity");
            }
        } catch (Exception e) {
            out.println(e.getMessage());
        }
    }
}
