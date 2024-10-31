

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class upoffer
 */
@WebServlet("/upoffer")
public class upoffer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public upoffer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");

        if (id != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/store";
                Connection con = DriverManager.getConnection(url, "root", "");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM offerzone WHERE id = " + id);

                if (rs.next()) {
                    request.setAttribute("id", rs.getString("id"));
                    request.setAttribute("name", rs.getString("name"));
                    request.setAttribute("image_url", rs.getString("image_url"));
                    request.setAttribute("price", rs.getDouble("price"));
                    request.setAttribute("quantity", rs.getString("quantity"));
                    request.setAttribute("description", rs.getString("description")); 
                    request.setAttribute("manufacturing", rs.getString("manufacturing_date")); 
                    request.setAttribute("expiry", rs.getString("expiry_date")); 
                    request.getRequestDispatcher("/update_offer.jsp").forward(request, response);
                }

                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
