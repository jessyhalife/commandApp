
<%@ page import="comandapp.Pedido" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<asset:stylesheet src="bootstrap.css"/>
		<asset:stylesheet src="menu.css"/>
        <asset:stylesheet src="flexbox.css"/>
		<!-- jQuery library -->
          <asset:javascript src="jquery-2.2.0.min.js"/>
        <asset:javascript src="bootstrap.js"/>
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
        <ul class="nav navbar-nav navbar-right" style="padding-top: 3px;">
                <g:if test="${!session?.cart?.id.equals(null)}">
                <li>
                    <a href="statusPedido">
                        <button type="button" class="btn btn-danger">
                            Ver estado <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
                        </button>
                    </a>
                </li>
                </g:if>
                <li>
                    <a href="#cartModal" data-toggle="modal" data-target="#cartModal" style="color:black;">                        
                        <button type="button" class="btn verCarrito">
                            Cart <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true">
                            </span>&nbsp&nbsp<span class="badge labelCart">${session?.cart?.items?.size()}</span>
                        </button>
                        
                    </a>
                </li>

            </ul>
      </div>
    </nav>
     <nav class="navbar navbar-default navbar-fixed-top filterOps">
      <div class="container">
        <div class="navbar-header">
            <a href="#filtroModal" class="navbar-toggle collapsed" data-toggle="modal" data-target="#filtroModal" style="color:black">
                       <span class="sr-only">Toggle navigation</span>
                <span class="">Filtros</span>
                <span class="glyphicon glyphicon-filter" aria-hidden="true"></span>
            </a>
        </div>
        <div id="navbar" class="navbar-form navbar-left nav-bar-collapse" role="filter">
            <ul class="nav navbar-nav">
                <li><a><div class="nofilter"><strong>Filtrar</strong></div></a></li>
                <li><a href="#" id="-1" class="btn-todos"><div class="filter-active">Todos</div></a></li>
                <g:each in="${productList}" var="item">
                    <li><a href="#" id="${item.id}" class="btn-tipo"><div class="filter">${item.descripcion}</div></a></li>
                </g:each>
            </ul>
            <ul class="nav navbar-nav">
                <g:each in="${regimenList}" var="reg">
                    <li><a class="btn-reg" id="${reg.id}" href="#"><div class="filter"><asset:image class="iconoRegimen" src="iconregimen/${reg.urlIcono}"/> ${reg.descripcion}</div></a></li>
                </g:each>
            </ul>
        </div>
      </div>
    </nav>
    <g:form action="cartView" id="form-cartContinue" class="btnFloat">
                <g:submitButton class="btn btn-success btn-lg" value="Confirmar pedido!" name="btn-cartContinue" />
    </g:form>
    <g:if test="${flash.carritoVacio}">
        <p class="alert alert-danger" style="margin-top:44px; text-align:center; margin-bottom:5px;">
            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
            <strong><g:message error="${flash.carritoVacio}"/></strong>
        </p>
    </g:if>
    <g:if test="${flash.platoOk}">
        <p class="alert alert-success" style="margin-top:44px; text-align:center;">
            <span class="glyphicon glyphicon-piggy-bank" aria-hidden="true"></span>
            <strong><g:message error="${flash.platoOk}"/></strong>
        </p>
    </g:if>
    <div class="container menuDiv">
        <div class="jumbotron backMenu">
            <div style="z-index:1;">
            <g:each in="${productList}" var="item" status="i">
            <div id="tipo${item.id}" style="display: block;">
                <h2>${item.descripcion}</h2>
                <g:if test="${item.productos.size() == 0}">
                    <h5>No tenemos ningun plato de este tipo :(</h5>
                </g:if>
                <div class="row">
                <g:each in="${item.productos.sort(true){it.nombre.toUpperCase()}}" var="pl"> 
                    <div class="col-sm-4 plato">
                    <span class="label imgSugerido"><span class="glyphicon glyphicon-heart" aria-hidden="true"></span>  Recomendado</span>
                        <asset:image class="plato-img img-rounded" src="platos/${pl.urlFoto}"/>
                        <div class="datos-plato">
                            <h4>
                                ${pl.nombre}<br>
                                <g:each in="${pl.regimenes}" var="reg"><asset:image id="${reg.id}" class="iconoRegimen" src="iconregimen/${reg.urlIcono}" alt="${reg.descripcion}"/>&nbsp</g:each>
                            </h4>
                            <p>${pl.descripcion}</p>
                            <h4>$${pl.precio}</h4>
                        </div>
                        <g:if test="${!pl.urlVideo.equals(null) && !pl.urlVideo.equals("")}">
                                    <a href="#videoModal" data-toggle="modal" data-target="#videoModal" class="btn btn-default videoOpen gly-spin" style="margin:4px;float:right;">
                                        <i class="glyphicon glyphicon-facetime-video"></i>  video
                                    </a>
                                </g:if>
                        <div class="form-group">
                            <g:form action="addToCart" id="${pl.id}">
                                <g:select class="form-control qty-select" name="qty${pl.id}" from="${1..10}"/>
                                <g:submitButton class="btn btn-secondary btn-sm addPlato"  value="Agregar a mi pedido" name="add${pl.id}"/>
                            </g:form>
                        </div>
                    </div>
                </g:each>
                </div>  
                <hr>
                </div>
            </g:each>
        </div>
        </div>
    </div>
   
        </div>
    <!-- Modal -->
    <div class="modal fade" id="cartModal" tabindex="-1" role="dialog" aria-labelledby="cartModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
           <div class="row" style="margin-left: 90px;">
             <div class="col-md-5">
                <hgroup class="speech-bubble">
                    <h4>Tu pedido hasta ahora</h4>
                </hgroup>
                </div>
            <div class="col-md-5">
                <asset:image src="logoapp.png" class="logoapp"/>
            </div>
          </div>
          <div class="modal-body">
            <table class="table">
            <g:each in="${session?.cart?.items}" var="it" session="i">
                <tr>
                    <td class="hidden">${i}</td>
                    <td style="display:none;">${it.producto?.id}</td>
                    <td><h3>${it.producto?.nombre}</h3></td>
                    <td><h3>$${it.producto?.precio}</h3></td>
                    <td><h3><a href="#" class="eliminarItemModal" aria-label="Close" id="${it.itemId}" >
                            <span class="btn btn-danger quitar">&times; Quitar</span></a></h3></td>
                </tr>
            </g:each>
            <tr>
                <td colspan="2"><h2>Total:</h2></td>
                <td><h2 id="totalModal">$${session?.cart?.total}</h2></td>
            </tr>
            </table>
          </div>
          <div class="modal-footer">
            <div class="row right">
                <div class="col-md-2">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Volver</button>
                </div>
                <div class="col-md-10">
                <g:form action="CartView" id="form-cartContinue">
                    <g:submitButton class="btn btn-success" value="Confirmar pedido!" name="btn-cartContinue" />
                </g:form>
                </div>
            </div>
          </div>
        </div>
      </div>
    </div>
<!-- modal filtros mobile -->
    <div id="filtroModal" class="modal fade" role="dialog" tabindex="-1" aria-labelledby="filtroModalLabel" aria-hidden="true">
         <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                
                <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal" aria-label="Close" style="float:right;">
                  Aplicar
                </button>
              </div>
              <div class="modal-body">
            <h4 class="modal-title" id="filtroModalLabel">Filtros</h4>
                <ul class="nav navbar-nav">
                    <li><a href="#" id="-1" class="btn-todos"><div class="filter-active">Todos</div></a></li>
                    <g:each in="${productList}" var="item">
                        <li><a href="#" id="${item.id}" class="btn-tipo"><div class="filter">${item.descripcion}</div></a></li>
                    </g:each>
                </ul>
                <ul class="nav navbar-nav">
                    <g:each in="${regimenList}" var="reg">
                        <li><a class="btn-reg" id="${reg.id}" href="#"><div class="filter"><asset:image class="iconoRegimen" src="iconregimen/${reg.urlIcono}"/> ${reg.descripcion}</div></a></li>
                    </g:each>
                </ul>
               </div>
           </div>
        </div>
    </div>
   <!-- modal video -->
    <div id="videoModal" class="modal">
            PRUEBA!!!!!!
    </div>
   <!-- fin modal video -->
    <!-- fin modal filtros mobile-->
        <script>

            $(".btn-reg").click(function(e){
                var actualId = $(this).attr("id");
                if ($(this).children().attr("class") == "filter"){
                    $(this).children().attr("class", "filter-active")

                }else{
                    $(this).children().attr("class", "filter")
                }
            });


            $(".btn-tipo").click(function(e){
                var mostrar = false;
                if ($(this).children().attr("class") == "filter"){
                    mostrar = true;
                    //activo el filtro
                    $(".btn-todos").children().attr("class","filter");
                    $(this).children().attr("class", "filter-active")
                }else{
                    mostrar = false;
                    $(this).children().attr("class", "filter")
                }
                var DesmarcoTodos = true;
                $(".btn-tipo").each(function(){
                    if ($(this).children().attr("class").includes("filter-active"))
                        DesmarcoTodos= false;
                });
                
                    var actualId = $(this).attr("id");
                    var idloop=-1;
                    var seccion;
                    if (!DesmarcoTodos){
                    <g:each in="${productList}" var="tp">
                        var idloop = ${tp.id};
                        seccion = document.getElementById("tipo"+idloop);
                  
                        if (idloop != actualId){
                            var fil = $(".btn-tipo#"+idloop);
                            if (!fil.children().attr("class").includes("filter-active"))
                                seccion.style.display = "none";
                        }else{
                            if (mostrar)
                                seccion.style.display = "block";
                            else 
                                seccion.style.display="none";

                        }
                    
                    </g:each>
                 }else{
                    $(".btn-todos").click();
                 }

            });
            $(".btn-todos").click(function(e){
                if ($(this).children().attr("class") == "filter"){
                    mostrar = true;
                    //activo el filtro
                    $(this).children().attr("class", "filter-active")
                }else{
                    mostrar = false;
                    $(this).children().attr("class", "filter")
                }
                $(".btn-tipo").each(function(){
                    $(this).children().attr("class", "filter")   
                    var platos = document.getElementById("tipo"+ $(this).attr("id"));
                    platos.style.display = "block"; 
                });
            });
            $(".eliminarItemModal").click(function(){
                var itemId = $(this).attr('id');
                var URL="${createLink(controller:'pedido',action:'eliminarItemModal')}";
                var element = $(this).parent().parent().parent();
                $.ajax({
                    url:URL,
                    data: {itemId: itemId},
                    success: function(data){
                        $(".labelCart").text(data.split("|")[1]);
                        element.remove();
                        $("#totalModal").text("$"+data.split("|")[0]);
                        if(data.split("|")[1] == "0"){
                            $("#cartModal").modal("toggle");
                        }
                    }
                });
            });
            $(".videoOpen").click(function(){
                  alert("hola");
                  
                });
        </script>
	</body>
</html>
