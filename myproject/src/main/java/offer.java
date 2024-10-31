

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

/**
 * Servlet implementation class offer
 */
@WebServlet("/offer")
public class offer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public offer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
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
	            PreparedStatement stmt = con.prepareStatement("update offerzone SET quantity = quantity + ? where id = ?");
	            stmt.setString(1, quantity);
	            stmt.setString(2, id);
	            int rowsAffected = stmt.executeUpdate();
	            con.close();
	            if (rowsAffected > 0) {
	                response.sendRedirect("offerzone2.jsp?message=quantity added successfully");
	            } else {
	                out.println("Failed to update quantity");
	            }
	        } catch (Exception e) {
	            out.println(e.getMessage());
	        }
	    }
	}
