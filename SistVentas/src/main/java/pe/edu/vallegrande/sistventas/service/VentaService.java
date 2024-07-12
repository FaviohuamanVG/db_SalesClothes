package pe.edu.vallegrande.sistventas.service;

import pe.edu.vallegrande.sistventas.db.AccesoDB;
import pe.edu.vallegrande.sistventas.dto.DetalleDto;
import pe.edu.vallegrande.sistventas.dto.VentaDto;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VentaService {

    public VentaDto registrarVenta(VentaDto ventaDto, List<DetalleDto> items) {
        // Variables
        Connection cn = null;
        String sql, sqlInsertDetalle, sqlUpdateStock;
        PreparedStatement pstm, pstmInsertDetalle, pstmUpdateStock;
        ResultSet rs;
        int idVenta, stock;
        // Proceso
        try {
            // Inicio de la Tx
            cn = AccesoDB.getConnection();
            cn.setAutoCommit(false);
            // Registrar la venta
            sql = "INSERT INTO venta(idcliente, documento, fecha, fecha_pago, importe, idtipopago, idtipocomp, tipoEnvio, descuento, impuesto, total) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstm = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstm.setInt(1, ventaDto.getIdcliente());
            pstm.setString(2, ventaDto.getDocumento());
            pstm.setDate(3, ventaDto.getFecha() != null ? new java.sql.Date(ventaDto.getFecha().getTime()) : null);
            pstm.setDate(4, ventaDto.getFecha_pago() != null ? new java.sql.Date(ventaDto.getFecha_pago().getTime()): null);
            pstm.setDouble(5, ventaDto.getImporte());
            pstm.setInt(6, ventaDto.getIdtipopago());
            pstm.setInt(7, ventaDto.getIdtipocomp());
            pstm.setString(8, ventaDto.getTipoEnvio());
            pstm.setDouble(9, ventaDto.getDescuento());
            pstm.setDouble(10, ventaDto.getImpuesto());
            pstm.setDouble(11, ventaDto.getTotal());
            pstm.executeUpdate();

            // Obtener el id de venta generado
            rs = pstm.getGeneratedKeys();
            if (rs.next()) {
                idVenta = rs.getInt(1);
            } else {
                throw new SQLException("Error al obtener el ID de la venta.");
            }
            rs.close();
            pstm.close();

            // Preparar las consultas para actualizar stock y registrar detalles
            sql = "SELECT stock FROM PRODUCTO WHERE idprod = ?";
            pstm = cn.prepareStatement(sql);
            sqlUpdateStock = "UPDATE PRODUCTO SET stock = ? WHERE idprod = ?";
            pstmUpdateStock = cn.prepareStatement(sqlUpdateStock);
            sqlInsertDetalle = "INSERT INTO detalle(idventa, idprod, cant, precio, subtotal) VALUES(?, ?, ?, ?, ?)";
            pstmInsertDetalle = cn.prepareStatement(sqlInsertDetalle);
            pstmInsertDetalle.setInt(1, idVenta);

            for (DetalleDto bean : items) {
                // Verificar stock
                pstm.setInt(1, bean.getIdprod());
                rs = pstm.executeQuery();
                if (!rs.next()) {
                    throw new SQLException("Producto no existe.");
                }
                stock = rs.getInt("stock");
                rs.close();

                if (stock < bean.getCantidad()) {
                    throw new SQLException("No hay stock suficiente para el producto con ID " + bean.getIdprod());
                }

                // Actualizar stock
                stock -= bean.getCantidad();
                pstmUpdateStock.setInt(1, stock);
                pstmUpdateStock.setInt(2, bean.getIdprod());
                pstmUpdateStock.executeUpdate();

                // Insertar detalle
                pstmInsertDetalle.setInt(2, bean.getIdprod());
                pstmInsertDetalle.setInt(3, bean.getCantidad());
                pstmInsertDetalle.setDouble(4, bean.getPrecio());
                pstmInsertDetalle.setDouble(5, bean.getSubtotal());
                pstmInsertDetalle.executeUpdate();
            }

            // Confirmar transacción
            cn.commit();
        } catch (SQLException e) {
            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (SQLException e1) {
                throw new RuntimeException("Error al hacer rollback: " + e1.getMessage(), e1);
            }
            throw new RuntimeException("Error en la transacción: " + e.getMessage(), e);
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException e) {
                throw new RuntimeException("Error al cerrar la conexión: " + e.getMessage(), e);
            }
        }

        return ventaDto;
    }

    public List<DetalleDto> buscarProductos(String nombre) {
        Connection cn = null;
        PreparedStatement pstm;
        ResultSet rs;
        String sql;
        List<DetalleDto> lista = new ArrayList<>();
        try {
            cn = AccesoDB.getConnection();
            sql = "SELECT idprod, nombre, precio, stock FROM PRODUCTO WHERE nombre LIKE ?";
            pstm = cn.prepareStatement(sql);
            nombre = "%" + nombre.trim() + "%";
            pstm.setString(1, nombre);
            rs = pstm.executeQuery();
            while (rs.next()) {
                DetalleDto bean = new DetalleDto();
                bean.setIdprod(rs.getInt("idprod"));
                bean.setNombre(rs.getString("nombre"));
                bean.setStock(rs.getInt("stock"));
                bean.setPrecio(rs.getDouble("precio"));
                lista.add(bean);
            }
            rs.close();
            pstm.close();
        } catch (SQLException e) {
            throw new RuntimeException("Error al buscar productos: " + e.getMessage(), e);
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException e) {
                throw new RuntimeException("Error al cerrar la conexión: " + e.getMessage(), e);
            }
        }
        return lista;
    }

    public DetalleDto buscarProductoId(int idprod) {
        Connection cn = null;
        PreparedStatement pstm;
        ResultSet rs;
        String sql;
        DetalleDto bean = null;
        try {
            cn = AccesoDB.getConnection();
            sql = "SELECT idprod, nombre, precio, stock FROM PRODUCTO WHERE idprod = ?";
            pstm = cn.prepareStatement(sql);
            pstm.setInt(1, idprod);
            rs = pstm.executeQuery();
            if (rs.next()) {
                bean = new DetalleDto();
                bean.setIdprod(rs.getInt("idprod"));
                bean.setNombre(rs.getString("nombre"));
                bean.setStock(rs.getInt("stock"));
                bean.setPrecio(rs.getDouble("precio"));
            }
            rs.close();
            pstm.close();
        } catch (SQLException e) {
            throw new RuntimeException("Error al buscar producto por ID: " + e.getMessage(), e);
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException e) {
                throw new RuntimeException("Error al cerrar la conexión: " + e.getMessage(), e);
            }
        }
        return bean;
    }
}
