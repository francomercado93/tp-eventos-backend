package ar.edu.eventos.controller

import ar.edu.repositorios.RepoUsuariosAngular
import ar.edu.usuarios.Usuario
import java.util.List
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils
import ar.edu.eventos.exceptions.BusinessException

@Controller
class UsuariosController {

	extension JSONUtils = new JSONUtils

	@Get("/usuarios")
	def Result usuarios() {
		try {
			val usuarios = RepoUsuariosAngular.instance.usrsRepo
			ok(usuarios.toJson)
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

//	@Get('/usuario/:nombre')
//	def Result buscar( /*String descripcion*/ ) {
//		ok(RepoUsuariosAngular.instance.search(nombre).toJson)
//	}
	@Get('/usuarios/:id')
	def Result usuario() {
		val iId = Integer.valueOf(id)
		try {
//			if(true) throw new RuntimeException	("No se encontro usuario")
			ok(RepoUsuariosAngular.instance.searchById(iId).toJson)
		} catch (UserException e) {
			notFound("No existe el usuario con id " + id + "")
		}
	}

	@Get('/usuarios/:id/amigos')
	def Result searchAmigos() {
		val iId = Integer.valueOf(id)
		try {
			val repo = RepoUsuariosAngular.instance
			val usr = repo.searchById(iId)
			ok(usr.amigos.toJson)
		} catch (UserException e) {
			notFound("No existe el usuario con id " + id + "")
		}
	}
//	@Get('/usuario/:id/amigos/:idAmigo')
//	def Result searchAmigos() {
//		val iId = Integer.valueOf(id)
//		val iIdAmigo = Integer.valueOf(idAmigo)
//		try {
//			val repo = RepoUsuariosAngular.instance
//			val usr = repo.searchById(iId)
//			val amigo = usr.buscarAmigo(repo.searchById(iIdAmigo))
//			ok(amigo.toJson)
//		} catch (UserException e) {
//			notFound("No existe el usuario con id " + id + "")
//		}
//	}

	@Put('/usuarios/:idUsr/amigos/:idAmigo')
	def Result actualizar() {
		try {
			val usrActualizado = RepoUsuariosAngular.instance.searchById(Integer.parseInt(idUsr))
			val amigoEliminar = RepoUsuariosAngular.instance.searchById(Integer.parseInt(idAmigo))
			usrActualizado.eliminarAmigo(amigoEliminar)

			if (Integer.parseInt(idUsr) != usrActualizado.id) {
				return badRequest('{ "error" : "Id en URL distinto del cuerpo" }')
			}

			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	def actualizarAmigos(Usuario usuario, List<Usuario> amigos) {
		amigos.filter(amigo|!usuario.esAmigo(amigo)).forEach(amigo|usuario.eliminarAmigo(amigo))
	}
}
