<%@ page import="comandapp.Pedido" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <asset:stylesheet src="bootstrap.css"/>
    <asset:stylesheet src="menu.css"/>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
                <th>Pedido</th>
                <th>itemId</th>
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
                    <tr id="${p.id}">
                        <td>${p.id}</td>
                        <td>${it.itemId}</td>
                        <td>hh:mm</td>
                        <td>${p.mesa.login}</td>
                        <td>${it.producto.tipo.descripcion}</td>
                        <td>${it.producto.nombre}</td>
                        <td>VER</td>
                        <td>${it.comentario}</td>
                        <td>${it.producto.avgTimePrep}</td>
                        <td>
                        <g:if test="${it.estado.orden == 1}">
                            <a id="${it.itemId}" class="btn cambiarEstado" href="#" style="width: 100%;" >
                        </g:if>
                        <g:if test="${it.estado.orden == 2}">
                            <a id="${it.itemId}" class="btn btn-info cambiarEstado" href="#" style="width: 100%;">
                        </g:if>
                        <span id="iconoEstado" class="${it.estado.glyphicon}"></span><span class="estadoDesc">${it.estado.descripcion}</span></a></td>
                        </td>
                    </tr>
                </g:if>
                </g:each>
            </g:each>
    	</tbody>
    </table>
    </div>
    <script>
        $(".cambiarEstado").click(function(){
            var itemId = $(this).attr('id');
            var pedidoId = $(this).parent().parent().attr('id');
            var element = $(this)
            var URL="${createLink(controller:'pedido',action:'actualizarEstado')}";
            $.ajax({                    
                    url:URL,
                    data: {idPedido: pedidoId,itemId: itemId},
                    success: function(data){
                        if (data.split("|")[0] == "2"){
                            var classActual = element.attr('class');
                            element.attr('class',classActual+" btn-info");
                            element.find("#iconoEstado").attr('class',data.split("|")[1]);
                            element.find(".estadoDesc").text(data.split("|")[2]);
                        }else{
                            element.parent().parent().remove();
                        }
                    }
                });
        })
    </script>
</body>
</html>