package ar.edu.eventos.controller

import ar.edu.repositorios.RepoUsuariosAngular
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.api.annotation.Body
import ar.edu.invitaciones.Invitacion
import org.uqbar.xtrest.api.annotation.Post

@Controller
class InvitacionesController {

	extension JSONUtils = new JSONUtils

	@Get('/usuarios/:id/invitaciones')
	def Result invitaciones() {
		val iId = Integer.valueOf(id)
		try {
		val invitacionesPendientes = RepoUsuariosAngular.instance.searchById(iId).invitaciones.filter(inv | inv.estaPendiente).toList
			ok(invitacionesPendientes.toJson)
		} catch (UserException e) {
			notFound("No existe el usuario con id " + id + "")
		}
	}
	
	@Post('/usuarios/:idUsr/invitacion')
	def Result rechazarInvitacion(@Body String body) {
		try {
//			if (true) throw new RuntimeException("ACHALAY")
//			println(body)
			println(body.getPropertyValue("evento"))
//			val invitacionActualizada = body.fromJson(Invitacion)
////			println(invitacionActualizada)
//			val usr = RepoUsuariosAngular.instance.searchById(Integer.parseInt(idUsr))
//			invitacionActualizada.invitado = usr
//			val nuevoEvento = body.getPropertyValue("evento")
//			println(nuevoEvento)
//			nuevoEvento.locacion = RepoLocacionesAngular.instance.search(body.getPropertyValue("locacion")).get(0)
//		nuevoEvento.asignarFechas(body.getPropertyValue("inicioEvento"), body.getPropertyValue("finEvento"),
//			body.getPropertyValue("fechaMaximaConfirmacion"), body.getPropertyValue("fechaCreacion"))
//			usr.rechazarInvitacion(invitacionActualizada.evento)

			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}
}
