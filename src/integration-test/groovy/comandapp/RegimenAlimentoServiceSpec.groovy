package comandapp

import grails.test.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class RegimenAlimentoServiceSpec extends Specification {

    RegimenAlimentoService regimenAlimentoService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new RegimenAlimento(...).save(flush: true, failOnError: true)
        //new RegimenAlimento(...).save(flush: true, failOnError: true)
        //RegimenAlimento regimenAlimento = new RegimenAlimento(...).save(flush: true, failOnError: true)
        //new RegimenAlimento(...).save(flush: true, failOnError: true)
        //new RegimenAlimento(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //regimenAlimento.id
    }

    void "test get"() {
        setupData()

        expect:
        regimenAlimentoService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<RegimenAlimento> regimenAlimentoList = regimenAlimentoService.list(max: 2, offset: 2)

        then:
        regimenAlimentoList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        regimenAlimentoService.count() == 5
    }

    void "test delete"() {
        Long regimenAlimentoId = setupData()

        expect:
        regimenAlimentoService.count() == 5

        when:
        regimenAlimentoService.delete(regimenAlimentoId)
        sessionFactory.currentSession.flush()

        then:
        regimenAlimentoService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        RegimenAlimento regimenAlimento = new RegimenAlimento()
        regimenAlimentoService.save(regimenAlimento)

        then:
        regimenAlimento.id != null
    }
}
