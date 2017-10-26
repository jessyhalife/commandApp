package comandapp

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class TipoProductoController {

    TipoProductoService tipoProductoService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
   
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond tipoProductoService.list(params), model:[tipoProductoCount: tipoProductoService.count()]
    }

    def show(Long id) {
        respond tipoProductoService.get(id)
    }

    def create() {
        respond new TipoProducto(params)
    }

    def save(TipoProducto tipoProducto) {
        if (tipoProducto == null) {
            notFound()
            return
        }

        try {
            tipoProductoService.save(tipoProducto)
        } catch (ValidationException e) {
            respond tipoProducto.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tipoProducto.label', default: 'TipoProducto'), tipoProducto.id])
                redirect tipoProducto
            }
            '*' { respond tipoProducto, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond tipoProductoService.get(id)
    }

    def update(TipoProducto tipoProducto) {
        if (tipoProducto == null) {
            notFound()
            return
        }

        try {
            tipoProductoService.save(tipoProducto)
        } catch (ValidationException e) {
            respond tipoProducto.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'tipoProducto.label', default: 'TipoProducto'), tipoProducto.id])
                redirect tipoProducto
            }
            '*'{ respond tipoProducto, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        tipoProductoService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'tipoProducto.label', default: 'TipoProducto'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoProducto.label', default: 'TipoProducto'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
