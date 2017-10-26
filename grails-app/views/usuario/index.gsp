
<%@ page import="comandapp.Usuario" %>
<!DOCTYPE html>
<html>
	<head>
		<asset:stylesheet src="signin.css"/>
		<asset:stylesheet src="bootstrap.css"/>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<title>COMANDAPP - Login</title>
	</head>
	<body>
	 	<g:img class="loginimage" dir="./assets/images" file="banner1.png"/>
	 <div class="container">
		 <g:if test="${flash.errores}">
					<p class="alert alert-danger">
						<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
						<strong><g:message error="${flash.errores}"/></strong>
					</p>
			</g:if>
		<div class="signin-box">
		 <form class="form-signin">
			 <h2 class="form-signin-heading">Inicie sesión para abrir la mesa</h2>
			 <label for="inputEmail" class="sr-only">Mesa</label>
			 <input type="text" id="inputLogin" class="form-control" placeholder="Mesa" required autofocus name="login">
			 <label for="inputPassword" class="sr-only">Contraseña</label>
			 <input type="password" id="inputPassword" class="form-control" placeholder="Contraseña" required name="password">
			 <g:actionSubmit class="btn btn-lg btn-block butblack"  value="Abrir Mesa" action="doLogin" controller="Usuario"/>
		 </form>
		</div>
	 </div> <!-- /container -->

	</body>
</html>
