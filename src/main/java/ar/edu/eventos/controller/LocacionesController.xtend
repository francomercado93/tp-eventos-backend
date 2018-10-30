package ar.edu.eventos.controller

import ar.edu.repositorios.RepoLocacionesAngular
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils

@Controller
class LocacionesController {

	extension JSONUtils = new JSONUtils

	@Get('/locaciones')
	def Result locaciones() {
		try {
			ok(RepoLocacionesAngular.instance.locaciones.toJson)
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}
}
