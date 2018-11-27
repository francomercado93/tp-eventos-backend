package ar.edu.eventos.controller

import ar.edu.repositorios.RepoUsuariosAngular
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.commons.model.exceptions.UserException

@Controller
class EntradasController {
	extension JSONUtils = new JSONUtils

	@Get('/usuarios/:id/entradas')
	def Result entradasUsr() {
		val iId = Integer.valueOf(id)
		try {
			ok(RepoUsuariosAngular.instance.searchById(iId).entradasCompradas.toJson)
		} catch (UserException e) {
			notFound("No existe el usuario con id " + id + "")
		}
	}
}
