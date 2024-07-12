package pe.edu.vallegrande.sistventas.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data @AllArgsConstructor @NoArgsConstructor
public class VentaDto {

    private int idventa;
    private int idcliente;
    private String documento;
    private Date fecha;
    private Date fecha_pago;
    private double importe;
    private int idtipopago;
    private int idtipocomp;
    private String tipoEnvio;
    private String serie;
    private double descuento;
    private double impuesto;
    private double total;


    public VentaDto(int idcliente, String documento, Date fecha, Date fecha_pago, double importe, int idtipopago, int idtipocomp, String tipoEnvio, String serie, double descuento, double impuesto, double total) {
        this.idcliente = idcliente;
        this.documento = documento;
        this.fecha = fecha;
        this.fecha_pago = fecha_pago;
        this.importe = importe;
        this.idtipopago = idtipopago;
        this.idtipocomp = idtipocomp;
        this.tipoEnvio = tipoEnvio;
        this.serie = serie;
        this.descuento = descuento;
        this.impuesto = impuesto;
        this.total = total;
    }
}
