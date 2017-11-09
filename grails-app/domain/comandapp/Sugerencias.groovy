package comandapp

class Sugerencias {
	Date fecha
	static hasMany = [productos: Producto]
    static constraints = {
    }

    static mapping = {
    	productos lazy:false
    }
}
