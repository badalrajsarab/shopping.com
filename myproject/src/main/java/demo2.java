

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class demo2
 */
@WebServlet("/demo2")
public class demo2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public demo2() {
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
	        String productName = request.getParameter("productName");
	        String imageURL = request.getParameter("imageURL");
	        double price = Double.parseDouble(request.getParameter("price"));
	        int quantity = Integer.parseInt(request.getParameter("quantity"));
	        String description = request.getParameter("description");
	        String manufacturingDate = request.getParameter("manufacturingDate");
	        String expiryDate = request.getParameter("expiryDate");

	        try {
	            Class.forName("com.mysql.jdbc.Driver");
	            String url = "jdbc:mysql://localhost:3306/store";
	            Connection con = DriverManager.getConnection(url, "root", "");
	            String sql = "INSERT INTO biscuits (name, image_url, price, quantity, description, manufacturing_date, expiry_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
	            PreparedStatement preparedStatement = con.prepareStatement(sql);
	            preparedStatement.setString(1, productName);
	            preparedStatement.setString(2, imageURL);
	            preparedStatement.setDouble(3, price);
	            preparedStatement.setInt(4, quantity);
	            preparedStatement.setString(5, description);
	            preparedStatement.setString(6, manufacturingDate);
	            preparedStatement.setString(7, expiryDate);
	            preparedStatement.executeUpdate();
	            con.close();
	            response.sendRedirect("adbiscuits.jsp?message=Product added successfully");
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.sendRedirect("adbiscuits.jsp?message=Failed to add product");
	        }
	    }
	}