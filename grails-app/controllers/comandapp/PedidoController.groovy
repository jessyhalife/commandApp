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

    def index() {
      List<TipoProducto> tipoProdList = new ArrayList<TipoProducto>()
      tipoProdList = TipoProductoService.listAll()
      List<RegimenAlimento> regimenList = new ArrayList<RegimenAlimento>()
      regimenList = RegimenAlimentoService.listAll()
      [productList: tipoProdList, regimenList: regimenList]
    }

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
      
        redirect action: 'index'
    }

    def showCart(){
        redirect action: 'cartView'
    }
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
        //render view: 'cartView'   
    }
    def cartView()
    {
        println session.cart.id         
        if(!session?.cart.id.equals(null))
        {
            session.cart.items.each {
                
                //buscarlo aca
            }
            session.cart = PedidoService.getById(session?.cart.id.toInteger())
        }
        render view: 'cartView'
    }
    def eliminarDelPedido(){
        Pedido p = (Pedido)session?.cart
        PedidoItem item = p?.items?.find{x -> x.itemId.equals(params.itemId.toInteger())}
        p.items.removeElement(item)
        def total = 0
        p.items.each {
            total += it.producto.precio
        }
        p.total = total
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
    def vistaCocinero()
    {
        List<Pedido> listPedidos = PedidoService.listAll()
        println listPedidos
        [lPedidos: listPedidos]
    }
    @Transactional
    def guardarPedido(){
        Pedido p = (Pedido)session?.cart
        p.fecha = new Date().format('dd/MM/yyyy hh:mm:ss')
        p?.items.each{
            it.pedido = p
            it.estado = EstadoService.getByOrden(1.toInteger())
        }        
        if (p.hasErrors())
            println p.errors
        else
            if(p.save(flush: true)){
                session.cart = p
                redirect (action: 'statusPedido')
            }
            else{
                render view: 'CartView'
            }
        

    }

    def statusPedido(){
        def total = 0
        Pedido ped = Pedido.find{x -> x.id.equals(session?.cart?.id)}
        ped?.items?.each{
            total = total + it.producto.avgTimePrep
        }
        [pedidoInstance: ped, tiempoAvg: total]
    }
}
