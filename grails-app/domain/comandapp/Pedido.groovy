package comandapp

class Pedido {
	static hasMany = [items: PedidoItem]
	double total
	String fecha
	static hasOne = [mesa: Usuario, estado: Estado]
    static constraints = {
    	estado (nullable:true)
    	mesa lazy:false
    	estado lazy:false
    	items lazy:false
    }

    static mapping = {
        mesa lazy: false
        estado lazy: false 
        items lazy:false
    }
}
