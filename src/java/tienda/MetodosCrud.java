package tienda;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MetodosCrud {

    public static boolean verificarUsuario(Connection connection, String username, String password) {
        boolean bandera = false;
        String query = "SELECT * FROM Usuario WHERE username = ? AND password = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            bandera = false;
        }

        return bandera;
    }

    //Methods to register new User -- First we check if the username exists in the data base
    //                                after that we go ahead with the inserting of the data
    public static boolean usernameExists(Connection connection, String username) {
        boolean exists = false;
        String query = "SELECT 1 FROM Usuario WHERE username = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                exists = rs.next(); // If there's a result, the username exists
            }
        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
        return exists;
    }

    public static boolean registerUser(Connection connection,
            String nombre, String apellidos, String username,
            String password, Date fecha_nacimiento) {

        boolean success = false;

        // Check if the username already exists
        if (usernameExists(connection, username)) {
            System.out.println("Username already exists. Please choose another.");
            return false; // Exit the method without inserting if the username is already taken
        }

        String query = "INSERT INTO Usuario(nombre, apellidos, username, password, fecha_nacimiento) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, nombre);
            ps.setString(2, apellidos);
            ps.setString(3, username);
            ps.setString(4, password); // Consider hashing the password for security
            ps.setDate(5, fecha_nacimiento);

            int affectedRows = ps.executeUpdate();

            success = (affectedRows > 0);
            if (success) {
                System.out.println("User inserted successfully.");
            } else {
                System.out.println("User not inserted.");
            }

        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }

        return success; // Return the success status
    }

    //Metodos CRUD
    //1.Create Product
    public static boolean createProduct(Connection connection,
            String nombre, BigDecimal precio,
            String departament, int cantidad) {

        boolean inserted = false;
        String query = "INSERT INTO Producto(nombre, precio, departament, cantidad) VALUES(?, ?, ?, ?)";

        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, nombre);
            pstmt.setBigDecimal(2, precio);
            pstmt.setString(3, departament);
            pstmt.setInt(4, cantidad);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return inserted;
    }

    //2.Read Product
    public static List<String[]> readProduct(Connection connection, int idProducto) {
        List<String[]> productDetailsList = new ArrayList<>();
        String sql = "SELECT * FROM Producto WHERE id_producto::INTEGER = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idProducto);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Create an array for the product details
                String[] details = new String[5];
                details[0] = String.valueOf(rs.getInt("id_producto"));  // ID
                details[1] = rs.getString("nombre");                   // Name
                details[2] = String.valueOf(rs.getFloat("precio"));    // Price
                details[3] = rs.getString("departament");              // Department
                details[4] = String.valueOf(rs.getInt("cantidad"));     // Quantity

                productDetailsList.add(details);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productDetailsList;
    }

    //3.Update Product
    public static boolean updateProduct(Connection connection, int idProducto, String nombre, double precio, String departament, int cantidad) {
        boolean success = true;
        try {
            String query = "UPDATE Producto SET nombre = ?, precio = ?, departament = ?, cantidad = ? WHERE id_producto = ?";

            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, nombre);
            ps.setBigDecimal(2, BigDecimal.valueOf(precio));
            ps.setString(3, departament);
            ps.setInt(4, cantidad);
            ps.setInt(5, idProducto);

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                System.out.println("Product updated successfully.");
                return true;
            } else {
                System.out.println("No rows affected during update.");
                success = false;
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Log any SQL exceptions for debugging
            success = false;
        }
        return success;
    }

    //4.Delete Product
    public static boolean deleteProduct(Connection connection, int idProducto) {
        boolean success = true;

        try {
            String query = "DELETE FROM Producto WHERE id_producto = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, idProducto);

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                return true;
            } else {
                success = false;
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Log any SQL exceptions for debugging
            success = false;
        }

        return success;
    }

    //5. Ver base de datos completa
    public static List<String[]> baseDatos(Connection connection) throws SQLException {
        List<String[]> productList = new ArrayList<>();
        String query = "SELECT id_producto, nombre, precio, departament, cantidad FROM Producto"; // Use correct table and column names
        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                String[] productDetails = new String[5];
                productDetails[0] = String.valueOf(rs.getInt("id_producto")); // ID
                productDetails[1] = rs.getString("nombre");                  // Name
                productDetails[2] = String.valueOf(rs.getBigDecimal("precio")); // Price
                productDetails[3] = rs.getString("departament");             // Department
                productDetails[4] = String.valueOf(rs.getInt("cantidad"));    // Quantity
                productList.add(productDetails);
            }
        }
        return productList;
    }

    //Obtener los ids disponibles para ver uno de los productos.
    public static List<Integer> getAvailableProductIds(Connection connection) {
        List<Integer> productIds = new ArrayList<>();
        String query = "SELECT id_producto FROM Producto";

        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                productIds.add(rs.getInt("id_producto"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productIds;
    }

    //Obtener los departamentso disponibles
    public static List<String> getAvailableDepartments(Connection connection) {
        List<String> departamentos = new ArrayList<>();
        String query = "SELECT DISTINCT departament FROM Producto";
        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()){
                departamentos.add(rs.getString("departament"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return departamentos;
    }

}
