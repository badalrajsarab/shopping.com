
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
/**
 * Servlet implementation class addToCart
 */
@WebServlet("/addToCart")
public class addToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addToCart() {
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
    	  String id = request.getParameter("id");
          String name = request.getParameter("name");
          String image_url = request.getParameter("image_url");
          String price = request.getParameter("price");
          String quantity = request.getParameter("quantity");

          try {
              Class.forName("com.mysql.jdbc.Driver");
              String url = "jdbc:mysql://localhost:3306/store";
              Connection con = DriverManager.getConnection(url, "root", "");

              String query = "INSERT INTO cart (id, name, image_url, price, quantity) VALUES (?, ?, ?, ?, ?)";
              PreparedStatement pstmt = con.prepareStatement(query);
              pstmt.setString(1, id);
              pstmt.setString(2, name);
              pstmt.setString(3, image_url);
              pstmt.setString(4, price);
              pstmt.setString(5, quantity);
              pstmt.executeUpdate();

              con.close();

              response.getWriter().write("Product added to cart");
          } catch (ClassNotFoundException | SQLException e) {
              e.printStackTrace();
              response.getWriter().write("Error adding product to cart: " + e.getMessage());
          }
      }
  }