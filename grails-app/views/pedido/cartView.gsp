
<%@ page import="comandapp.Pedido" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<asset:stylesheet src="bootstrap.css"/>
		<asset:stylesheet src="menu.css"/>
		<!-- jQuery library -->
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<!--<asset:javascript src="jquery-3.2.1.min.js"/>
		<asset:javascript src="bootstrap.js"/>-->
		<title>Menú</title>
	</head>
	<body>
		    <!-- Button trigger modal -->
     <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#"><strong>COMANDAPP</strong></a>
        </div>
      </div>
    </nav>
    <div class="container">
    	<a href="${createLink(action:'index')}" style="float:left; margin:20px;" class="btn btn-primary btn-sm">
    		<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    			Volver
		</a>
    	<div class="jumbotron" 	\>
    		<h2>Detalle de tu pedido <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span></h2>
    		<h3>Agregá todos los comentarios que creas necesarios!</h3>
    		<table class="table">
	    		<g:each in="${session?.cart?.items.sort(true){it.producto.nombre}}" var="it" >
	    			
	    			<tr>
	    				<td>${it.itemId}</td>
	    				<td>
	    					<asset:image class="plato-img img-rounded" src="platos/${it.producto.urlFoto}"/>
	    				</td>
	    				<td>
	    					<h3>${it.producto.nombre}</h3><br>
	    					<h5>${it.producto.descripcion}</h5>
	    				</td>
	    				<td>
	    					<h4>$${it.producto.precio}</h4>
	    				</td>
    					<td>
    						<g:if test="${it.estado.equals(null) || it.estado.orden == 1}">
							<button class="btn btn-secondary btn-sm btnComment" id="${it.itemId}">Agregar comentario  
								<span class="glyphicon glyphicon-pencil" aria-hidden="true">
							</button>
							<a href="${createLink(action: 'eliminarDelPedido', params:[itemId: it.itemId])}" class="close" aria-label="Close">
							<span aria-hidden="true">&times;</span></a>
							<textarea id="comentario${it.itemId}" placeholder="Retocá tu plato!" class="form-control comment hidden"></textarea>
							<div id="comentarioTexto${it.itemId}" class="commentText">${it.comentario}</div>
							</g:if>
							<g:else>
							<span class="${it.estado?.glyphicon}"> </span> <b>${it.estado?.descripcion}</b>
							<br><label>No podes modificar este plato</label>
							</g:else>
    					</td>
	    			</tr>
	    		</g:each>
	    		<tr>
	    			<td></td>
	    			<td><h3>Total</u></h3></td>
	    			<td><h3>$${session?.cart?.total}</h3></td>

	    		</tr>
	    	</table>
				 <g:form action="guardarPedido" id="form-cartPedir">
                <g:submitButton class="btn btn-success btn-lg btnPedir" value="Pedir!" name="btn-cartPedir" />
            </g:form>
    	</div>
    </div>
    <script>
    	$(".btnComment").click(function(){
    		var row = $(this).attr('id');
    		var textarea = "#comentario"+row;
    		var existente = "#comentarioTexto" + row;
    		if ($(textarea).attr('class').includes("hidden"))
    		{
    			$(".btnComment"+ "#" + row).html("Guardar comentario  <span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\">");
    			$(textarea).attr('class','form-control comment');
    			$(textarea).text($(existente).text());
    			$(existente).attr('class','commentText hidden');
    		}else{
    			$(".btnComment"+ "#" + row).html("Agregar comentario  <span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\">");
    			$(existente).text($(textarea).val());
    			$(textarea).attr('class','form-control comment hidden');
    			$(existente).attr('class','commentText');
    			var URL="${createLink(controller:'pedido',action:'agregarComentario')}";
	            $.ajax({
	                url:URL,
	                data: {itemId:row, comentario: $(textarea).val()}
	            });
    		}
    	});

    </script>
	</body>
</html>