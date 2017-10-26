package comandapp

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class RegimenAlimentoController {

    RegimenAlimentoService regimenAlimentoService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond regimenAlimentoService.list(params), model:[regimenAlimentoCount: regimenAlimentoService.count()]
    }

    def show(Long id) {
        respond regimenAlimentoService.get(id)
    }

    def create() {
        respond new RegimenAlimento(params)
    }

    def save(RegimenAlimento regimenAlimento) {
        if (regimenAlimento == null) {
            notFound()
            return
        }

        try {
            regimenAlimentoService.save(regimenAlimento)
        } catch (ValidationException e) {
            respond regimenAlimento.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'regimenAlimento.label', default: 'RegimenAlimento'), regimenAlimento.id])
                redirect regimenAlimento
            }
            '*' { respond regimenAlimento, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond regimenAlimentoService.get(id)
    }

    def update(RegimenAlimento regimenAlimento) {
        if (regimenAlimento == null) {
            notFound()
            return
        }

        try {
            regimenAlimentoService.save(regimenAlimento)
        } catch (ValidationException e) {
            respond regimenAlimento.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'regimenAlimento.label', default: 'RegimenAlimento'), regimenAlimento.id])
                redirect regimenAlimento
            }
            '*'{ respond regimenAlimento, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        regimenAlimentoService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'regimenAlimento.label', default: 'RegimenAlimento'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'regimenAlimento.label', default: 'RegimenAlimento'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
