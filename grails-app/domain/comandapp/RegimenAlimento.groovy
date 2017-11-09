package comandapp

class RegimenAlimento {
    String descripcion
    String urlIcono
    static hasMany = [productos: Producto]
    static belongsTo = Producto
    static constraints = {
    	urlIcono nullable:true
    }
    static mapping = {
    	productos lazy: false
    }
}
