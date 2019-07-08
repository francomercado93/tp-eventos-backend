package ar.edu.eventos.controller

import ar.edu.eventos.Evento
import ar.edu.invitaciones.Entrada
import ar.edu.repositorios.RepoUsuariosAngular
import java.time.LocalDateTime
import java.util.List
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils

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

	// ????
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

	@Put('/usuarios/:id')
	def Result actualizarUsuario(@Body String body) {
		try {
			val usrActualizado = RepoUsuariosAngular.instance.searchById(Integer.parseInt(id))
			val entradaActualizar = body.fromJson(Entrada)
			usrActualizado.devolverCantidadEntradas(entradaActualizar)
			if (Integer.parseInt(id) != usrActualizado.id) {
				return badRequest('{ "error" : "Id en URL distinto del cuerpo" }')
			}
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put('/usuarios/:id/compra-entradas')
	def Result usuarioCompraEntrada(@Body String body) {
		try {
			val usrActualizado = RepoUsuariosAngular.instance.searchById(Integer.parseInt(id))
			val nuevaEntrada = body.fromJson(Entrada)
			val eventos = eventosOrganizadosUsrsRepo()
			val eventoEntrada = eventos.findFirst(evento|evento.nombreEvento == nuevaEntrada.evento.nombreEvento)
			nuevaEntrada.evento.locacion = eventoEntrada.locacion
			nuevaEntrada.evento.organizador= eventoEntrada.organizador
			usrActualizado.fechaHoraActual = LocalDateTime.of(2018, 2, 2, 13, 30)
			usrActualizado.comprarCantidadEntradas(nuevaEntrada.evento, nuevaEntrada.cantidad)
			if (Integer.parseInt(id) != usrActualizado.id) {
				return badRequest('{ "error" : "Id en URL distinto del cuerpo" }')
			}
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	def List<Evento> eventosOrganizadosUsrsRepo() {
		return RepoUsuariosAngular.instance.usrsRepo.map(usuario|usuario.eventosOrganizados).flatten().toList()
	}
}
