<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <title>Registrar Venta</title>
</head>
<body>
<div class="container">

    <h1>REGISTRAR NUEVA VENTA</h1>

    <div class="card" id="divAcciones">
        <div class="card-header">
            Acciones
        </div>
        <div class="card-body">
            <div class="btn-group" role="group">
                <button type="button" class="btn btn-primary" id="btnGrabarVenta">Grabar venta</button>
                <button type="button" class="btn btn-secondary" id="btnNuevoItem">Nuevo item</button>
            </div>
        </div>
    </div> <!-- divAcciones -->

    <div class="card" id="divDatosVenta">
        <div class="card-header">
            Datos de la venta
        </div>
        <div class="card-body">

            <form method="post" action="VtaGrabar" id="formVenta">
                <div class="form-group row">
                    <label for="vtaCliente" class="col-sm-2 col-form-label">ID Cliente</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="vtaCliente" name="cliente" placeholder="Nombre del cliente">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="vtaDocumento" class="col-sm-2 col-form-label">Ruc o DNI</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="vtaDocumento" name="documento" placeholder="Documento del cliente / Empresa">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="vtaFecha" class="col-sm-2 col-form-label">Fecha de emision</label>
                    <div class="col-sm-10">
                        <input type="date" class="form-control" id="vtaFecha" name="fecha" placeholder="dd-mm-yyyy">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="vtaFechaPago" class="col-sm-2 col-form-label">Fecha de pago</label>
                    <div class="col-sm-10">
                        <input type="date" class="form-control" id="vtaFechaPago" name="fecha_pago" placeholder="dd-mm-yyyy">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="vtaImporte" class="col-sm-2 col-form-label">Importe</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="vtaImporte" name="importe" value="0.00" disabled>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="vtaTipoPago" class="col-sm-2 col-form-label">Tipo de Pago</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="vtaTipoPago" name="idtipopago" placeholder="Ingresa el número">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="vtaTipoComp" class="col-sm-2 col-form-label">Tipo de Comprobante</label>
                    <div class="col-sm-10">
                        <select class="form-control" id="vtaTipoComp" name="idtipocomp">
                            <option value="1">1</option>
                            <option value="2">2</option>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="vtaTipoEnvio" class="col-sm-2 col-form-label">Tipo de Comprobante</label>
                    <div class="col-sm-10">
                        <select class="form-control" id="vtaTipoEnvio" name="tipoEnvio">
                            <option value="En tienda">En tienda</option>
                            <option value="Envio">Envio</option>
                        </select>
                    </div>
                </div>
                <div class="form-group row" style="display: none">
                    <label for="vtaDescuento" class="col-sm-2 col-form-label">Descuento</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="vtaDescuento" name="descuento" placeholder="Ingresa el número" value="0.00" READONLY>
                    </div>
                </div>
                <div class="form-group row" style="display: none">
                    <label for="vtaImpuesto" class="col-sm-2 col-form-label">Impuesto</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="vtaImpuesto" name="impuesto" placeholder="Ingresa el número" value="0.00" READONLY>
                    </div>
                </div>
                <div class="form-group row" style="display: none">
                    <label for="vtaTotal" class="col-sm-2 col-form-label">Total</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="vtaTotal" name="total" placeholder="Ingresa el número" value="0.00" READONLY>
                    </div>
                </div>
            </form>

            <table class="table">
                <thead class="thead-light">
                <tr>
                    <th>COD</th>
                    <th>NOMBRE</th>
                    <th>PRECIO</th>
                    <th>CANTIDAD</th>
                    <th>SUBTOTAL</th>
                    <th>ACCION</th>
                </tr>
                </thead>
                <tbody id="vtaItems">
                </tbody>
            </table>

        </div> <!-- card-body -->

    </div> <!-- divDatosVenta -->

    <!-- Prefijo:bus -->
    <div class="card" id="divAgregarItem" style="display: none;">
        <div class="card-header">
            Agregar nuevo item
        </div>
        <div class="card-body">
            <div>
                <form>
                    <div class="form-group row">
                        <label for="busNombre" class="col-sm-2 col-form-label">Nombre</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="busNombre"
                                   placeholder="Nombre del producto">
                        </div>
                        <div class="col-sm-2">
                            <button type="button" class="btn btn-primary" id="busBtnBuscar">Buscar</button>
                        </div>
                    </div>
                </form>
            </div>
            <div>
                <table class="table">
                    <thead class="thead-light">
                    <tr>
                        <th>COD</th>
                        <th>NOMBRE</th>
                        <th>PRECIO</th>
                        <th>STOCK</th>
                        <th>ACCION</th>
                    </tr>
                    </thead>
                    <tbody id="busResultado">
                    </tbody>
                </table>
            </div>
            <div>
                <form>
                    <div class="form-row">
                        <div class="form-group col-md-3" style="display: none">
                            <label for="busCodigo">Código</label>
                            <input type="text" class="form-control" id="busCodigo">
                        </div>
                        <div class="form-group col-md-3" style="display: none">
                            <label for="busCantidad">Cantidad</label>
                            <input type="text" class="form-control" id="busCantidad">
                        </div>
                        <div class="form-group col-md-2">
                            <button type="button" class="btn btn-primary" id="busBtnAgregar">Agregar</button>
                        </div>
                        <div class="form-group col-md-2">
                            <button type="button" class="btn btn-secondary" id="busBtnCancelar">Cancelar</button>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div> <!-- divAgregarItem -->


</div><!-- Container -->


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
        crossorigin="anonymous"></script>

<script>
    $(function () {
        // Acciones
        $("#btnNuevoItem").click(fnBtnNuevoItem);
        $("#btnGrabarVenta").click(fnBtnGrabarVenta);

        // Formulario nuevo item
        $("#busBtnCancelar").click(fnBusBtnCancelar);
        $("#busBtnBuscar").click(fnBusBtnBuscar);
    });

    function fnBtnGrabarVenta(){
        // Datos
        let cliente = $("#vtaCliente").val();
        let documento = $("#vtaDocumento").val();
        let fecha = $("#vtaFecha").val();
        let fecha_pago = $("#vtaFechaPago").val();
        let importe = $("#vtaImporte").val();
        let idtipopago = $("#vtaTipoPago").val();
        let idtipocomp = $("#vtaTipoComp").val();
        let tipoEnvio = $("#vtaTipoEnvio").val();
        let descuento = $("#vtaDescuento").val();
        let impuesto = $("#vtaImpuesto").val();
        let total = $("#vtaTotal").val();

        // Proceso
        let parametros = "idcliente=" + cliente + "&documento=" + documento +"&fecha=" + fecha + "&fecha_pago=" + fecha_pago +"&importe=" + importe + "&idtipopago=" + idtipopago + "&idtipocomp=" + idtipocomp + "&tipoEnvio=" + tipoEnvio + "&descuento=" + descuento + "&impuesto=" + impuesto + "&total=" + total;
        $.post("VtaGrabar",parametros, function(respuesta){
            alert(respuesta);
        });
    }

    function fnBtnNuevoItem() {
        $("#divAcciones").hide();
        $("#divDatosVenta").hide();
        $("#divAgregarItem").show();
    }

    // Nuevo ITem

    function fnBusBtnCancelar(){
        fnBusCargarItem();
        $("#divAcciones").show();
        $("#divDatosVenta").show();
        $("#divAgregarItem").hide();
    }

    function fnBusCargarItem(){
        // Datos
        let url = "VtaGetItems";
        // Proceso
        $.getJSON( url, function( data ) {
            let html = "";
            let total = 0.0;
            $.each( data, function( key, prod ) {
                html += "<tr>";
                html += "<td>" + prod.idprod + "</td>";
                html += "<td>" + prod.nombre + "</td>";
                html += "<td>" + prod.precio + "</td>";
                html += "<td>" + prod.cantidad + "</td>";
                html += "<td>" + prod.subtotal + "</td>";
                html += "<td>Eliminar</td>";
                html += "</tr>";
                total += prod.subtotal;
            });
            $("#vtaItems").html(html);
            $("#vtaImporte").val(total);
        });
    }

    function fnBusBtnBuscar(){
        // Datos
        let nombre = $("#busNombre").val();
        // Proceso
        let url = "VtaConProductos?nombre=" + nombre;
        $.getJSON( url, function( data ) {
            let html = "";
            $.each( data, function( key, prod ) {
                html += "<tr>";
                html += "<td>" + prod.idprod + "</td>";
                html += "<td>" + prod.nombre + "</td>";
                html += "<td>" + prod.precio + "</td>";
                html += "<td>" + prod.stock + "</td>";
                html += "<td><a href='javascript:fnBusAgregarItem(" + prod.idprod + ",1)'>Agregar</a></td>";
                html += "</tr>";
            });
            $("#busResultado").html(html);
        });
    }

    function fnBusAgregarItem(idprod, cantidad){
        let url = "VtaAddItem?idprod=" + idprod + "&cantidad=" + cantidad;
        $.get( url, function( texto ) {
            console.log("Rpta: " + texto);
        });
    }

</script>


</body>
</html>
