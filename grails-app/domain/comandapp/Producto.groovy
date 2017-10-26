package comandapp

class Producto {
    double precio
    String nombre
    String descripcion
    int avgTimePrep
    String urlFoto 
    String urlVideo
    static belongsTo = [tipo : TipoProducto]
    static hasMany = [regimenes : RegimenAlimento]
    static constraints = {
        urlFoto (nullable: true)
        urlVideo (nullable: true)
        regimenes (nullable: true)
    }
}
