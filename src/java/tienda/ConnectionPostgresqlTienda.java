package tienda;

import java.sql.*;

public class ConnectionPostgresqlTienda {

    public static Connection obtainConnection() {
        String url = "jdbc:postgresql://localhost:5432/tienda?characterEncoding=UTF8";
        String usuario = "postgres";
        String clave = "Passw0rd!";
        Connection conexion = null;
        try {
            Class.forName("org.postgresql.Driver");
            conexion = DriverManager.getConnection(url,usuario,clave);
        }catch(SQLException | ClassNotFoundException e){
            conexion = null;
        }
        return conexion;
    }
}