package pe.edu.vallegrande.sistventas.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor
public class DetalleDto {

    private int idprod;
    private String nombre;
    private int stock;
    private double precio;
    private int cantidad;
    private double subtotal;

    public DetalleDto(int idprod, String nombre, double precio, int cantidad, double subtotal) {
        this.idprod = idprod;
        this.nombre = nombre;
        this.precio = precio;
        this.cantidad = cantidad;
        this.subtotal = subtotal;
    }
}
