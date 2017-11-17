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
		 
       <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#"><strong>COMANDAPP</strong></a>
        </div>
      </div>
    </nav>
    <div class="container">
    	<div class="jumbotron">
            <div class="row" style="margin-left: 350px;">
             <div class="col-md-3">
                <hgroup class="speech-bubble">
                    <h4>Tu pedido esta marchando!</h4>
                </hgroup>
                </div>
            <div class="col-md-3">
                <asset:image src="logoapp.png" class="logoapp"/>
            </div>
          </div>
          <hr>
          <p>Nro Pedido: ${pedidoInstance?.id}</p>
          <div style="text-align: center;">
          <span class="glyphicon glyphicon-time" aria-hidden="true" style="font-size: 50px;"></span>
          	<h3>Estará listo en ${tiempoAvg} <g:if test="${tiempoAvg < 60}">minutos!</g:if><g:else>${tiempoAvg.intdiv(60)} hora y ${(tiempoAvg.div(60)) - tiempoAvg.intdiv(60)} minutos!</g:else></h3>
      	  </div>
      	  <hr>
      	  <table class="table tableroEspera">
      	  	<g:each in="${pedidoInstance.items.sort(true){it.itemId}}" var="it">
      	  		<tr>
      	  			<td>${it.producto.nombre}</td>
      	  			<td><span class="${it?.estado?.glyphicon}" aria-hidden="true"></span><b>  ${it?.estado?.descripcion}</b></td>
      	  		</tr>
      	  	</g:each>
      	  	<table>
      	  </div>
        </div>
        <div style="text-align: center">
       	<a href="${createLink(action:'index')}" class="btn btn-primary btn-lg">
    		<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    			Seguir pidiendo
		</a>
		</div>
        </div>
    <script>
     var time = new Date().getTime();
     $(document.body).bind("mousemove keypress", function(e) {
         time = new Date().getTime();
     });

     function refresh() {
         if(new Date().getTime() - time >= 600) 
             window.location.reload(true);
         else 
             setTimeout(refresh, 100);
     }

     setTimeout(refresh, 360000);
	</script>    
	</body>

</html>