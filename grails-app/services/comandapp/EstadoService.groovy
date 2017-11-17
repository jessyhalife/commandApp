package comandapp

import grails.transaction.Transactional

@Transactional
class EstadoService {

	def listAll()
	{
		Estado.findAll()
	}
	def getByOrden(Integer orden)
	{
		Estado.findByOrden(orden)
	}

	def getById(long id)
	{
		Estado.finById(id)
	}

}