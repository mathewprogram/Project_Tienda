package tienda;

import java.math.BigDecimal;

public class Product {
    private String idProducto;
    private String nombre;
    private BigDecimal precio;
    private String departamento;
    private int cantidad;

    // Getters
    public String getIdProducto() {
        return idProducto;
    }

    public String getNombre() {
        return nombre;
    }

    public BigDecimal getPrecio() {
        return precio;
    }

    public String getDepartamento() {
        return departamento;
    }

    public int getCantidad() {
        return cantidad;
    }

    // Setters
    public void setIdProducto(String idProducto) {
        this.idProducto = idProducto;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
}

