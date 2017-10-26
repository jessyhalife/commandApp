package comandapp

import grails.transaction.Transactional

@Transactional
class TipoProductoService {

    def listAll()
    {
		TipoProducto.findAll()
    }

}