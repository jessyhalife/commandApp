
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
    <g:form action="showCart" id="form-cartContinue" class="btnFloat">
                <g:submitButton class="btn btn-success btn-lg" value="Confirmar pedido!" name="btn-cartContinue" />
            </g:form>

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
                    <div class="col-md-3 plato">
                        <asset:image class="plato-img img-rounded" src="platos/${pl.urlFoto}"/>
                        <h4>
                            ${pl.nombre}<br>
                            <g:each in="${pl.regimenes}" var="reg"><asset:image class="iconoRegimen" src="iconregimen/${reg.urlIcono}" alt="${reg.descripcion}"/></g:each>
                        </h4>
                        <p>${pl.descripcion}</p>
                        <span class="label label-precio">$${pl.precio}</span>
                        <br><br>
                             <div class="form-group">
                                <g:form action="addToCart" id="${pl.id}">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <g:select class="form-control qty-select" name="qty${pl.id}" from="${1..10}"/>
                                    </div>
                                    <div class="col-sm-4">
                                    <g:submitButton class="btn btn-secondary btn-sm" style="float:left;" value="Agregar" name="add${pl.id}"/>
                                    </div>
                                </div>
                                </g:form>
                            </div>
                        
                    </div>
                </g:each>
                </div>  
                <hr>
                </div>
                <br>
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
            <g:each in="${session?.cart?.items}" var="it">
                <tr>
                    <td style="display:none;">${it.producto?.id}</td>
                    <td><h3>${it.producto?.nombre}</h3></td>
                    <td><h3>$${it.producto?.precio}</h3></td>
                    <td><h3><a href="#" class="close eliminarItemModal" aria-label="Close" id="${it.itemId}" >
                            <span aria-hidden="true">&times;</span></a></h3></td>
                </tr>
            </g:each>
            <tr>
                <td colspan="2"><h2>Total:</h2></td>
                <td><h2>$${session?.cart?.total}</h2></td>
            </tr>
            </table>
          </div>
          <div class="modal-footer">
            <div class="row right">
                <div class="col-md-2">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Volver</button>
                </div>
                <div class="col-md-10">
                <g:form action="showCart" id="form-cartContinue">
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
    <!-- fin modal filtros mobile-->
        <script>
            $(".btn-reg").click(function(e){
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
                $.ajax({
                    url:URL,
                    data: {itemId: itemId}
                });
            });
            
        </script>
	</body>
</html>
