
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
     <nav class="navbar navbar-default navbar-fixed-top filterOps">
      <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="">Filtros</span>
            <span class="glyphicon glyphicon-filter
" aria-hidden="true"></span>
            </button>
            
            
            
        </div>
        <div id="navbar" class="navbar-form navbar-left nav-bar-collapse" role="filter">
            <ul class="nav navbar-nav">
            
                <li><a><div class="nofilter"><strong>Filtrar</strong></div></a></li>
            
                <g:each in="${productList}" var="item">
                    <li><a href="#" id="${item.id}" class="btn-tipo"><div class="filter">${item.descripcion}</div></a></li>
                </g:each>
            </ul>
            <ul class="nav navbar-nav">
                <g:each in="${regimenList}" var="reg">
                    <li><a class="btn-reg" id="${reg.id}" href="#"><div class="filter"><asset:image class="iconoRegimen" src="iconregimen/${reg.urlIcono}"/> ${reg.descripcion}</div></a></li>
                </g:each>
            </ul>
           <!-- <form id="navbar" class="navbar-form navbar-right search" role="search">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Buscar plato" name="q">
                    <div class="input-group-btn">
                        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                    </div>
                </div>
            </form>-->
        </div>
        
      </div>
    </nav>
    <div class="container menuDiv">
        <g:set var="lastTipo" value="-1"/>
        <g:each in="${productList}" status="i" var="item">
            <g:if test="${lastTipo != item.id}">
                <g:if test="${i>0}">
                    <hr>
                    </section>
                </g:if>
                <section class="platosSection" id="${item.id}">
                    <h3>${item.descripcion}</h3>
                    <g:set var="lastTipo" value="${item.id}"/>
            </g:if>
            
            <g:if test="${item?.productos.size()==0}">
                <div class="noPlatos"><h5>No hay platos :(</h5></div>
            </g:if>
            <g:else>
                <table class="table">
                <g:each in="${item.productos}" var="plato">
                    <tr id="plato${plato.id}">
                        <td>
                            <asset:image class="plato-img img-thumbnail" src="platos/${plato.urlFoto}"/>
                            
                        </td>
                        <td>
                        <strong>${plato.nombre}</strong>
                             <g:each in="${plato?.regimenes}" var="reg">
                                <asset:image class="iconoRegimen" src="iconregimen/${reg.urlIcono}"/>
                            </g:each>
                            <br>
                            ${plato.descripcion}
                        </td>
                        <td><h4>$${plato.precio}</h4></td>
                        <td><div class="input-group qty">
                            <span class="input-group-btn">
                                <button type="button" class="btn btn-default btn-number" data-type="minus" data-field="cant[${plato.id}]">
                                    <span class="glyphicon glyphicon-minus"></span>
                                </button>
                            </span>
                            <input type="text" name="cant[${plato.id}]" class="form-control input-number" value="0" min="0" max="10"/>
                            <span class="input-group-btn">
                                <button type="button" class="btn btn-default btn-number" data-type="plus" data-field="cant[${plato.id}]">
                            <span class="glyphicon glyphicon-plus"></span>
                            </button>
                            </span>
                          </div>
                      </td>
                    </tr>
                </g:each>
                </table>
           </g:else>
        </g:each>
        </div>
    </div>
    <hr>
    <div class="container">
        <g:set var="lastTipo" value="-1"/>
            <g:each in="${productList}" var="item" status="i">
                <h4><div class="label label-info">${item.descripcion}</div></h4>
                <div class="row">
                <g:each in="${item.productos}" var="pl"> 
                    <div class="col-md-3">
                        <asset:image class="plato-img img-rounded" src="platos/${pl.urlFoto}"/>
                        <h4>
                            ${pl.nombre} <g:each in="${pl.regimenes}" var="reg"><asset:image class="iconoRegimen" src="iconregimen/${reg.urlIcono}" alt="${reg.descripcion}"/></g:each>
                        </h4>
                        <h6>${pl.descripcion}</h6>
                        <h5><div class="label label-success">$${pl.precio}</div> <div class="label label-danger">chef!</div></h5>
                    </div>
                </g:each>
                </div>  
                <hr>
            </g:each>
        </div>
    </div>
        <script>
            $(".btn-number").click(function(e){
                fieldName = $(this).attr("data-field");
                type = $(this).attr("data-type");
                var input = $("input[name='"+fieldName+"']");
                var currentVal = parseInt(input.val());
                if(!isNaN(currentVal)){
                    if(type=='minus'){
                        if(currentVal > input.attr("min")){
                            input.val(currentVal-1).change();
                        }
                       
                    }else{
                        if (currentVal < input.attr("max"))
                        {
                            input.val(currentVal+1).change();
                        }
                       

                    }
                }
            });
            $(".btn-reg").click(function(e){
                if ($(this).children().attr("class") == "filter"){
                    $(this).children().attr("class", "filter-active")
                }else{
                    $(this).children().attr("class", "filter")
                }
            });
            $(".btn-tipo").click(function(e){
                if ($(this).children().attr("class") == "filter"){
                    //activo el filtro
                    $(this).children().attr("class", "filter-active")
                    var actualId = $(this).attr("id");
                    $(".platosSection").each(function(index){
                        if ($(this).attr("id") != actualId){
                           $(this).attr("display", "none"); 
                        }
                    });
                }else{
                    $(this).children().attr("class", "filter")
                }

            });
        </script>
	</body>
</html>
