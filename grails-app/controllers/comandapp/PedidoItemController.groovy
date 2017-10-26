package comandapp



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PedidoItemController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PedidoItem.list(params), model:[pedidoItemInstanceCount: PedidoItem.count()]
    }

    def show(PedidoItem pedidoItemInstance) {
        respond pedidoItemInstance
    }

    def create() {
        respond new PedidoItem(params)
    }

    @Transactional
    def save(PedidoItem pedidoItemInstance) {
        if (pedidoItemInstance == null) {
            notFound()
            return
        }

        if (pedidoItemInstance.hasErrors()) {
            respond pedidoItemInstance.errors, view:'create'
            return
        }

        pedidoItemInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'pedidoItem.label', default: 'PedidoItem'), pedidoItemInstance.id])
                redirect pedidoItemInstance
            }
            '*' { respond pedidoItemInstance, [status: CREATED] }
        }
    }

    def edit(PedidoItem pedidoItemInstance) {
        respond pedidoItemInstance
    }

    @Transactional
    def update(PedidoItem pedidoItemInstance) {
        if (pedidoItemInstance == null) {
            notFound()
            return
        }

        if (pedidoItemInstance.hasErrors()) {
            respond pedidoItemInstance.errors, view:'edit'
            return
        }

        pedidoItemInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PedidoItem.label', default: 'PedidoItem'), pedidoItemInstance.id])
                redirect pedidoItemInstance
            }
            '*'{ respond pedidoItemInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PedidoItem pedidoItemInstance) {

        if (pedidoItemInstance == null) {
            notFound()
            return
        }

        pedidoItemInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PedidoItem.label', default: 'PedidoItem'), pedidoItemInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pedidoItem.label', default: 'PedidoItem'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
