package comandapp

class Usuario {
    String login
    String password
    static hasMany = [pedidos: Pedido]
    static constraints = {
    }

    static mapping = {
    	pedidos lazy: false
    }
}
