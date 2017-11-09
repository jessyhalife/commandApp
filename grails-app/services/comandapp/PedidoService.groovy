package comandapp

import grails.transaction.Transactional

@Transactional
class PedidoService {
	def getById(int id)
	{
		Pedido.findById(id)
	}
	
	def listAll()
	{
		Pedido.findAll()
	}
}