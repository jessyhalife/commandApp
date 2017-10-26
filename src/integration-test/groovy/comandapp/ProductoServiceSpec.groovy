package comandapp

import grails.test.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ProductoServiceSpec extends Specification {

    ProductoService productoService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Producto(...).save(flush: true, failOnError: true)
        //new Producto(...).save(flush: true, failOnError: true)
        //Producto producto = new Producto(...).save(flush: true, failOnError: true)
        //new Producto(...).save(flush: true, failOnError: true)
        //new Producto(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //producto.id
    }

    void "test get"() {
        setupData()

        expect:
        productoService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Producto> productoList = productoService.list(max: 2, offset: 2)

        then:
        productoList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        productoService.count() == 5
    }

    void "test delete"() {
        Long productoId = setupData()

        expect:
        productoService.count() == 5

        when:
        productoService.delete(productoId)
        sessionFactory.currentSession.flush()

        then:
        productoService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Producto producto = new Producto()
        productoService.save(producto)

        then:
        producto.id != null
    }
}
