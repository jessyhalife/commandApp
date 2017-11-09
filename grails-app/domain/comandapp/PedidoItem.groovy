package comandapp

class PedidoItem {

	Integer itemId
	String comentario
	static hasOne = [producto: Producto, pedido: Pedido, estado: Estado]
	static belongsTo = [producto: Producto, pedido: Pedido]
    static constraints = {
    	pedido (nullable:true)
    	comentario (nullable:true)
    	estado (nullable:true)
    }
    static mapping = {
    	producto lazy:false
    	pedido lazy:false
    	estado lazy:false
    }
}
