package comandapp


import grails.transaction.Transactional

@Transactional
class RegimenAlimentoService {

    def listAll()
    {
    	RegimenAlimento.findAll()
    }
}