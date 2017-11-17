package comandapp



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = false)
class PedidoController {
    def TipoProductoService
    def ProductoService
    def RegimenAlimentoService
    def PedidoService
    def EstadoService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

/* Métodos para pedido/index */
    def index() {
      List<TipoProducto> tipoProdList = new ArrayList<TipoProducto>()
      tipoProdList = TipoProductoService.listAll()
      List<RegimenAlimento> regimenList = new ArrayList<RegimenAlimento>()
      regimenList = RegimenAlimentoService.listAll()
      [productList: tipoProdList, regimenList: regimenList]
    }

    //TODO: conver to AJAX
    def addToCart(){
        Pedido p = (Pedido)session.cart
        PedidoItem item = new PedidoItem()
        Producto prod = ProductoService.getById(params?.id.toInteger()); 
        for(def i=0; i < params["qty"+params?.id].toInteger(); i++){
         
            def proxId = p?.items?.itemId.max()
         
            if (!proxId.equals(null)){
         
                proxId = proxId+1
            }
            else{
         
                proxId = 1
            }
            item = new PedidoItem()  
            item.itemId = proxId
            item.producto = prod
            println item
            p.items?.add(item)
        }
        println p.items
        p.total += (item.producto.precio)
        session.cart = p
        flash.platoOk = "Se agregó correctamente!"
        redirect action: 'index'
    }

    //Elimino por Ajax un item del Modal
    def eliminarItemModal()
    {
        Pedido p = (Pedido)session?.cart
        PedidoItem item = p?.items?.find{x -> x.itemId.equals(params.itemId.toInteger())}
        p.items.removeElement(item)
        def total = 0
        p.items.each {
            total += it.producto.precio
        }
        p.total = total
        //Si ya existía el pedido
        if (!p.id.equals(null) && !item.id.equals(null)){
            println "ENTRA AL IF DE LOS NULLS"
            if(item.delete(failOnError:true)){
                println "borro item"
            }else{
                println item.errors
            }
            if(p.save(flush:true)){

            }
        }
        session.cart = p
        def result = total + "|" + session.cart.items.size()
        render result
    }
/* Métodos de pedido/cartview */ 

    def cartView()
    {   
        if (session.cart.items.size() > 0){
        println  "cart view " + session?.cart?.id?.toLong()
        if (!session?.cart?.id.equals(null)){
            Pedido p = PedidoService.getById((long)session?.cart?.id?.toLong())
            println "pedido:" + p.items.itemId
            println "session:" + session.cart.items.itemId
            if (p){
                session.cart.items.each{
                    x-> 
                        p.items.each{ y -> 
                            println "comparo " + x.itemId + " con " + y.itemId
                            if (y.itemId.equals(x.itemId)){
                                println "le asigno a x el estado de y " + y.estado
                                x.estado = y.estado
                            }else{
                                
                            }
                        }
                }
            }
        }
        println session.cart.items.estado
        println session.cart?.id
        }else{
            flash.carritoVacio = "Para confirmar el carrito primero debes agregar algun plato"
            redirect action: "index"
        }
    }
    def eliminarDelPedido(){
        Pedido p = (Pedido)session?.cart
        PedidoItem item = p?.items?.find{x -> x.itemId.equals(params.itemId.toInteger())}
        item.removeFrom
        p.items.removeElement(item)
        def total = 0
        p.items.each {
            total += it.producto.precio
        }
        p.total = total
        println "////ELIMINANDO UN ITEM///"
        println "id pedido " + p.id
        println "id item " +item.id
        if (!p.id.equals(null) && !item.id.equals(null)){
            if(item.destroy()){
                println "flash limon"
            }
            //grabo cambios
            if(p.save(flush:true))
                println "volvio a grabarlo"
            session.cart = p;
        }
        println "items de p" + p.items
        println "items de session " + session.cart.items
        if (p?.items?.size() > 0)
            redirect action: 'cartView'
        else
            redirect action: 'index'
    }

    def agregarComentario(Integer itemId, String comentario){
        println itemId
        Pedido p = (Pedido)session.cart
        println itemId
        PedidoItem item = p.items.find{x-> x.itemId.equals(itemId)}
        if (item){
            item.comentario = comentario
            println item.producto.nombre
            println item.comentario
        }

        render view:'cartView'
    }
 
    @Transactional
    def guardarPedido(){  
        println "/////GUARDAR PEDIDO////"
        println session.cart.id      
        Pedido p = (Pedido)session?.cart
        Pedido pExistente = null
        if (!p.id.equals(null)){
            pExistente = PedidoService.getById((long)p.id)
        }
        p.fecha = new Date().format('dd/MM/yyyy hh:mm:ss')
        p?.items.each{
            if (!it.pedido.equals(p)){
                println "hay uno que no tenia estado"
                it.pedido = p
                it.estado = EstadoService.getByOrden(1.toInteger())
            }else{
            }
        }
           
        println p.items.id
        println "///FIN GUARDAR///"
         
        if (p.hasErrors()){
            println p.errors
        }
        else{
            if(p.save(flush: true, failOnError:true)){
                session.cart = p
                session?.CURRENT_CART_ID = p.id
                println "Current Cart Id post grabar: " + session.CURRENT_CART_ID
                redirect (action: 'statusPedido')
            }
            else{
                flash.errorSave = p.errors
                render view: 'CartView'
            }
        }
    }

/* métodos de pedido/statusPedido */
    def statusPedido(){
        def total = 0
        println "PEDIDO ACTUAL POR CURRENT_CART_ID" + session?.CURRENT_CART_ID
        int idCart = session?.CURRENT_CART_ID
        Pedido ped = new Pedido()
        if (idCart){
            ped = PedidoService.getById(idCart)
            println ped.items
            ped?.items?.each{
                total = total + it.producto.avgTimePrep
            }
        }else{

        }
        [pedidoInstance: ped, tiempoAvg: total]
    }

/*Métodos de pedido/vistaCocinero*/

    def vistaCocinero()
    {
        //Cargo todos los pedidos que haya en la BD
        List<Pedido> listPedidos = PedidoService.listAll()
        List<Estado> listEstados = EstadoService.listAll()
        [lPedidos: listPedidos, lEstados: listEstados]
    }

    def actualizarEstado(int idPedido, int itemId){
        println "entra a actualizarEstado"
        Pedido p = PedidoService.getById(idPedido)
        def estadoNuevo
        println "pedido para estado levantado: " + p
        if (!p.equals(null)){
            PedidoItem item =  p.items.find { x -> x.itemId.equals(itemId) }
            println "busco el item " + itemId + " encontro " + item
            if (item){
                Estado eActual = item.estado
                estadoNuevo = eActual.id + "|" + eActual.glyphicon + "|" + eActual.descripcion
                println "estado actual " + eActual
                if (eActual){
                    Estado eProximo = EstadoService.getByOrden(eActual.orden+1)
                    println "estado proximo " + eProximo
                    if (eProximo){
                        item.estado = eProximo
                        if (p.save(flush: true))
                        {
                            estadoNuevo = item.estado.id + "|" + item.estado.glyphicon + "|" + item.estado.descripcion
                        }
                    }
                }
            }
        }
        render estadoNuevo
        //redirect action: 'vistaCocinero'
    }
}
