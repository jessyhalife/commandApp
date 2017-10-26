package comandapp

import grails.transaction.Transactional

@Transactional
class ProductoService {

    def listAll()
    {
    	Producto.findAll()
    }

    def getById(String nombre)
    {
    	Producto.findByNombre(nombre)
    }
}