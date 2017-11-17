package comandapp

import grails.transaction.Transactional

@Transactional
class PedidoService {
	def getById(long id)
	{
		Pedido.findById(id)
	}
	
	def listAll()
	{
		Pedido.findAll()
	}
}