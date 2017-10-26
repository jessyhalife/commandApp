package comandapp

class TipoProducto {
	String descripcion 
	static hasMany = [productos : Producto]
    static constraints = {
    }
}
