package ar.edu.eventos.controller

import ar.edu.eventos.Evento
import ar.edu.eventos.EventoCerrado
import ar.edu.repositorios.RepoLocacionesAngular
import ar.edu.repositorios.RepoUsuariosAngular
import ar.edu.usuarios.Usuario
import java.time.LocalDateTime
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils
import ar.edu.eventos.EventoAbierto

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

	@Put('/usuarios/:idusr/nuevoeventocerrado')
	def Result nuevoEventoCerrado(@Body String body) {
		try {
			val nuevoEvento = body.fromJson(EventoCerrado)
			val usrActualizado = actualizarEvento(nuevoEvento, body, idusr)
			if (Integer.parseInt(idusr) != usrActualizado.id) {
				return badRequest('{ "error" : "Id en URL distinto del cuerpo" }')
			}
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			println(e.message)
			badRequest(e.message)
		}
	}

	@Put('/usuarios/:idusr/nuevoeventoabierto')
	def Result nuevoEventoAbierto(@Body String body) {
		try {
			val nuevoEvento = body.fromJson(EventoAbierto)
			val usrActualizado = actualizarEvento(nuevoEvento, body, idusr)
			if (Integer.parseInt(idusr) != usrActualizado.id) {
				return badRequest('{ "error" : "Id en URL distinto del cuerpo" }')
			}
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			println(e.message)
			badRequest(e.message)
		}
	}

	def Usuario actualizarEvento(Evento nuevoEvento, String body, String idusr) {
		nuevoEvento.locacion = RepoLocacionesAngular.instance.search(body.getPropertyValue("locacion")).get(0)
		nuevoEvento.asignarFechas(body.getPropertyValue("inicioEvento"), body.getPropertyValue("finEvento"),
			body.getPropertyValue("fechaMaximaConfirmacion"))
		val usrActualizado = RepoUsuariosAngular.instance.searchById(Integer.parseInt(idusr))
		usrActualizado.fechaHoraActual = LocalDateTime.of(2018, 06, 05, 12, 00) // Obtiene fecha "actual"
		usrActualizado.crearEvento(nuevoEvento)
		usrActualizado
	}
}
