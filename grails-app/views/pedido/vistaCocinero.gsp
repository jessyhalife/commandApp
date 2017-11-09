<%@ page import="comandapp.Pedido" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <asset:stylesheet src="bootstrap.css"/>
    <asset:stylesheet src="menu.css"/>
    <META http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body style="background-image: none;">
     <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#"><strong>COMANDAPP</strong></a>
        </div>
      </div>
    </nav>
<div>
    <table width="100%" class="table table-striped chef">
    	<thead style="text-align: center;">
    		<tr>
    			<th>Descartar</th>
    			<th>Hora</th>
    			<th>Mesa</th>
    			<th>Tipo de Plato</th>
    			<th>Plato</th>
    			<th>Cantidad</th>
    			<th>Observaciones</th>
    			<th>Tiempo de Cocción</th>
    			<th>Estado</th>
    			<th></th>
    		</tr>
    	</thead>
    	<tbody>
            <g:each in="${lPedidos}" var="p">
                <g:each in="${p.items}" var="it">
                <g:if test="${it.estado.orden == 1 || it.estado.orden == 2}">
                    <tr>
                        <td style="text-align: center;"><a class="btn btn-default" href="#"><span class="glyphicon glyphicon-trash"></span></a></td>
                        <td>hh:mm</td>
                        <td>${p.mesa.login}</td>
                        <td>${it.producto.tipo.descripcion}</td>
                        <td>${it.producto.nombre}</td>
                        <td>VER</td>
                        <td>${it.comentario}</td>
                        <td>${it.producto.avgTimePrep}</td>
                        <td>
                        <g:if test="${it.estado.orden == 1}">
                            <a class="btn" href="#" style="width: 100%; border: solid; color:black;" >
                        </g:if>
                        <g:if test="${it.estado.orden == 2}">
                            <a class="btn btn-info" href="#" style="width: 100%;">
                        </g:if>
                        <span class="${it.estado.glyphicon}"></span>${it.estado.descripcion}</a></td>
                        </td>
                    </tr>
                </g:if>
                </g:each>
            </g:each>
    	</tbody>
    </table>
    </div>
</body>
</html>