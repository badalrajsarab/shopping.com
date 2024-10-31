import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/kitu")
public class kitu extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/store";
            try (Connection con = DriverManager.getConnection(url, "root","")) {
                ResultSet rs = con.createStatement().executeQuery("SELECT * FROM cart");
                try (PreparedStatement stmtBiscuits = con.prepareStatement("UPDATE biscuits SET quantity = quantity - ? WHERE name = ?");
                     PreparedStatement stmtProduct = con.prepareStatement("UPDATE product SET quantity = quantity - ? WHERE name = ?");
                     PreparedStatement stmtChoco = con.prepareStatement("UPDATE choco SET quantity = quantity - ? WHERE name = ?");
                     PreparedStatement stmtOfferzone = con.prepareStatement("UPDATE offerzone SET quantity = quantity - ? WHERE name = ?")) {
                    while (rs.next()) {
                        String name = rs.getString("name");
                        String quantityString = rs.getString("quantity");
                        if (quantityString != null && !quantityString.isEmpty()) {
                            int quantityBought = Integer.parseInt(quantityString);
                            stmtBiscuits.setInt(1, quantityBought);
                            stmtBiscuits.setString(2, name);
                            stmtBiscuits.addBatch();

                            stmtProduct.setInt(1, quantityBought);
                            stmtProduct.setString(2, name);
                            stmtProduct.addBatch();

                            stmtChoco.setInt(1, quantityBought);
                            stmtChoco.setString(2, name);
                            stmtChoco.addBatch();

                            stmtOfferzone.setInt(1, quantityBought);
                            stmtOfferzone.setString(2, name);
                            stmtOfferzone.addBatch();
                        }
                    }
                    stmtBiscuits.executeBatch();
                    stmtProduct.executeBatch();
                    stmtChoco.executeBatch();
                    stmtOfferzone.executeBatch();
                }

                con.createStatement().executeUpdate("DELETE FROM cart");

                response.sendRedirect("cart.jsp?message=Successfully purchased products.");

            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Failed to purchase products: " + e.getMessage());
        }
    }
}
