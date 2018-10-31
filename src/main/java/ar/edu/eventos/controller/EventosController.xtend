package ar.edu.eventos.controller

import ar.edu.repositorios.RepoUsuariosAngular
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.api.annotation.Body
import ar.edu.eventos.Evento
import ar.edu.eventos.EventoCerrado

@Controller
class EventosController {
	extension JSONUtils = new JSONUtils

	@Get('/usuarios/:id/organizadosPorMi')
	def Result eventosOrganizadosPorMi() {
		val iId = Integer.valueOf(id)
		try {
			ok(RepoUsuariosAngular.instance.searchById(iId).eventosOrganizados.toJson)
		} catch (UserException e) {
			notFound("No existe el usuario con id " + id + "")
		}
	}

	@Get('/usuarios/:id/agenda')
	def Result agenda() {
		val iId = Integer.valueOf(id)
		try {
			ok(RepoUsuariosAngular.instance.searchById(iId).eventosOrganizados.toJson)
		} catch (UserException e) {
			notFound("No existe el usuario con id " + id + "")
		}
	}

	@Put('/usuarios/:idUsr/nuevoevento')
	def Result actualizar(@Body String body) {
		try {
			println(body)
			val nuevoEvento = body.fromJson(EventoCerrado)
			println(nuevoEvento)
			val usrActualizado = RepoUsuariosAngular.instance.searchById(Integer.parseInt(idUsr))
//			usrActualizado.crearEvento(nuevoEvento)
//			RepoUsuariosAngular.instance.update(usrActualizado)

			if (Integer.parseInt(idUsr) != usrActualizado.id) {
				return badRequest('{ "error" : "Id en URL distinto del cuerpo" }')
			}

			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			println(e.message)
			badRequest(e.message)
		}
	}
}
