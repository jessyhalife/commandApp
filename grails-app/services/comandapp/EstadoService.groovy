package comandapp

import grails.transaction.Transactional

@Transactional
class EstadoService {

	def getByOrden(Integer orden)
	{
		Estado.findByOrden(orden)
	}

}