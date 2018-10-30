package ar.edu.eventos.controller

import ar.edu.repositorios.RepoUsuariosAngular
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils

@Controller
class InvitacionesController {

	extension JSONUtils = new JSONUtils

	@Get('/usuarios/:id/invitaciones')
	def Result invitaciones() {
		val iId = Integer.valueOf(id)
		try {
			ok(RepoUsuariosAngular.instance.searchById(iId).invitaciones.toJson)
		} catch (UserException e) {
			notFound("No existe el usuario con id " + id + "")
		}
	}
}
