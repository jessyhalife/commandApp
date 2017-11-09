package comandapp

class Estado {
	String descripcion
	int orden //con este vamos a ir iterando
	String glyphicon
	static hasMany = [pedidos: Pedido, items: PedidoItem]
    static constraints = {
    	glyphicon (nullable:true)
    }

    static mapping = {
    	pedidos lazy: false
    	items lazy: false 
    }
}
