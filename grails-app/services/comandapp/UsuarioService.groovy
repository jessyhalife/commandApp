package comandapp

import grails.transaction.Transactional

@Transactional
class UsuarioService {

    def serviceMethod() {

    }

    def validateUser(String login, String password)
    {
        if (Usuario.findByLoginAndPassword(login,password) != null)
          true
        else
          false

    }
}
