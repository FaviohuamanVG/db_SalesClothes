package pe.edu.vallegrande.sistventas.controller;

import com.google.gson.Gson;
import pe.edu.vallegrande.sistventas.dto.DetalleDto;
import pe.edu.vallegrande.sistventas.dto.VentaDto;
import pe.edu.vallegrande.sistventas.service.VentaService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet({"/VtaConProductos", "/VtaAddItem", "/VtaGetItems", "/VtaGrabar"})
public class VentaController extends HttpServlet {

    private VentaService ventaService;

    @Override
    public void init() throws ServletException {
        super.init();
        ventaService = new VentaService();
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        switch (path) {
            case "/VtaConProductos":
                conProductos(request, response);
                break;
            case "/VtaAddItem":
                addItem(request, response);
                break;
            case "/VtaGetItems":
                getItems(request, response);
                break;
            case "/VtaGrabar":
                grabar(request, response);
                break;
        }
    }

    private void grabar(HttpServletRequest request, HttpServletResponse response) {
        try {
            // Datos
            int idcliente = parseInt(request.getParameter("idcliente"));
            String documento = request.getParameter("documento");
            String dateString = request.getParameter("fecha");
            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
            Date fecha = null;
            if (dateString != null && !dateString.isEmpty()) {
                fecha = sdf1.parse(dateString);
            }
            String dateString2 = request.getParameter("fecha_pago");
            SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
            Date fecha_pago = null;
            if (dateString != null && !dateString.isEmpty()) {
                fecha_pago = sdf2.parse(dateString2);
            }
            double importe = parseDouble(request.getParameter("importe"));
            int idtipopago = parseInt(request.getParameter("idtipopago"));
            int idtipocomp = parseInt(request.getParameter("idtipocomp"));
            String tipoEnvio = request.getParameter("tipoEnvio");
            String serie = request.getParameter("serie");
            double descuento = parseDouble(request.getParameter("descuento"));
            double impuesto = parseDouble(request.getParameter("impuesto"));
            double total = parseDouble(request.getParameter("total"));

            // Validación adicional si es necesario

            // Items
            HttpSession session = request.getSession();
            List<DetalleDto> lista = (List<DetalleDto>) session.getAttribute("listaItems");
            if (lista == null) {
                lista = new ArrayList<>();
            }

            // Proceso
            VentaDto ventaDto = new VentaDto(0, idcliente, documento,fecha, fecha_pago,importe, idtipopago, idtipocomp, tipoEnvio, serie, descuento, impuesto, total);
            ventaService.registrarVenta(ventaDto, lista);

            // Respuesta
            UtilController.responseText(response, "1");
        } catch (NumberFormatException | ParseException e) {
            e.printStackTrace();
            UtilController.responseText(response, "Error en los datos: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            UtilController.responseText(response, "Error interno del servidor: " + e.getMessage());
        }
    }

    private double parseDouble(String value) {
        if (value == null || value.isEmpty()) {
            return 0.0;
        }
        return Double.parseDouble(value);
    }

    private int parseInt(String value) {
        if (value == null || value.isEmpty()) {
            return 0;
        }
        return Integer.parseInt(value);
    }

    private void getItems(HttpServletRequest request, HttpServletResponse response) {
        // Recuperando los datos
        HttpSession session = request.getSession();
        List<DetalleDto> lista = (List<DetalleDto>) session.getAttribute("listaItems");
        if (lista == null) {
            lista = new ArrayList<>();
        }
        // Reporte
        Gson gson = new Gson();
        String data = gson.toJson(lista);
        UtilController.responseJson(response, data);
    }

    private void addItem(HttpServletRequest request, HttpServletResponse response) {
        // Datos
        int idprod = Integer.parseInt(request.getParameter("idprod"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        // Proceso
        agregarItemVenta(request, idprod, cantidad);
        // Reporte
        UtilController.responseText(response, "1");
    }

    private void agregarItemVenta(HttpServletRequest request, int idprod, int cantidad) {
        HttpSession session = request.getSession();
        List<DetalleDto> lista;
        if (session.getAttribute("listaItems") == null) {
            lista = new ArrayList<>();
            session.setAttribute("listaItems", lista);
        } else {
            lista = (List<DetalleDto>) session.getAttribute("listaItems");
        }
        DetalleDto item = ventaService.buscarProductoId(idprod);
        item.setCantidad(cantidad);
        item.setSubtotal(item.getPrecio() * cantidad);
        lista.add(item);
    }

    private void conProductos(HttpServletRequest request, HttpServletResponse response) {
        // Datos
        String nombre = request.getParameter("nombre");
        // Proceso
        List<DetalleDto> lista = ventaService.buscarProductos(nombre);
        Gson gson = new Gson();
        String data = gson.toJson(lista);
        UtilController.responseJson(response, data);
    }
}
