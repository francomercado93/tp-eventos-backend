package ar.edu.eventos.controller

import ar.edu.repositorios.RepoUsuariosAngular
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils

@Controller
class InvitacionesController {

	extension JSONUtils = new JSONUtils
	
	@Get('/usuarios/:id/invitaciones')
	def Result invitaciones() {
		val iId = Integer.valueOf(id)
		try {
		val invitacionesPendientes = RepoUsuariosAngular.instance.searchById(iId).invitaciones
			ok(invitacionesPendientes.toJson)
		} catch (UserException e) {
			notFound("No existe el usuario con id " + id + "")
		}
	}
	
	@Put('/invitacion/:idUsr')
	def Result removerInvitacion(@Body String body) {
		try {
			val usr = RepoUsuariosAngular.instance.searchById(Integer.parseInt(idUsr))
			val	aBorrar=usr.invitaciones.findFirst(invit|invit.evento.nombreEvento==body)
		    usr.invitaciones.remove(aBorrar)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}
}
