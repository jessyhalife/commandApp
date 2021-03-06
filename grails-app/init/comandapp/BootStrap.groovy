package comandapp

class BootStrap {

    def init = { servletContext ->
    	def usuario = new Usuario(login: "mesa1", password: "mesa1").save()
    	def t1 = new TipoProducto(descripcion: "Entrada").save()
    	def t2 = new TipoProducto(descripcion: "Plato Principal").save()
    	def t3 = new TipoProducto(descripcion: "Postre").save()
    	def t4 = new TipoProducto(descripcion: "Bebidas").save()
    	def t5 = new TipoProducto(descripcion: "Tragos").save()
    	def r1 = new RegimenAlimento(descripcion: "Sin TACC", urlIcono: "glutenfree.png").save()
    	def r2 = new RegimenAlimento(descripcion: "Vegetariano", urlIcono: "veggie.png").save()
 		def p1 = new Producto(nombre: "Fusilli brocoli", descripcion: "Pasta casera salteada con brocoli y aceite de oliva",
 					precio: 150, avgTimePrep: 15, urlFoto: "fusilli.jpg", tipo: t2).save(flush: true)
 
 		def p2 = new Producto(nombre: "Milanesa con papas", descripcion: "Milanesa de ternera con papas al horno",
 					precio: 168, avgTimePrep: 20, urlFoto: "milanesa.jpg", tipo: t2).addToRegimenes(r1).save(flush: true)

        def estado = new Estado(descripcion: "Pendiente", orden:1, glyphicon: "glyphicon glyphicon-hourglass").save()
        estado = new Estado(descripcion: "En proceso", orden:2, glyphicon: "glyphicon glyphicon-fire").save()
        estado = new Estado(descripcion: "Terminado", orden:3, glyphicon: "glyphicon glyphicon-ok-circle").save()
        estado = new Estado(descripcion: "Camino a la mesa", orden:4, glyphicon:"glyphicon glyphicon-send").save()
        estado = new Estado(descripcion: "Pagado", orden:4, glyphicon: "glyphicon glyphicon-usd").save()
    }	
    def destroy = {
    }
}
