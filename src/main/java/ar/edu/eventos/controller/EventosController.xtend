package ar.edu.eventos.controller

import ar.edu.eventos.Evento
import ar.edu.eventos.EventoAbierto
import ar.edu.eventos.EventoCerrado
import ar.edu.repositorios.RepoLocacionesAngular
import ar.edu.repositorios.RepoUsuariosAngular
import ar.edu.usuarios.Usuario
import java.time.LocalDateTime
import java.util.ArrayList
import java.util.List
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils

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
			val usr = RepoUsuariosAngular.instance.searchById(iId)
			val eventosOrganizados = usr.eventosOrganizados
			val eventosInvitaciones = usr.invitaciones.map(invitacion|invitacion.evento)
			val eventosEntradas = usr.entradasCompradas.map(entrada|entrada.evento)
			val invitacionesAceptadas = usr.eventosAsistir
			val agenda = new ArrayList<Evento>
			agenda.addAll(invitacionesAceptadas)
			agenda.addAll(eventosOrganizados)
			agenda.addAll(eventosInvitaciones)
			agenda.addAll(eventosEntradas)
			ok(agenda.toJson)
		} catch (UserException e) {
			notFound("No existe el usuario con id " + id + "")
		}
	}

	@Get('/usuarios/:id/eventosdeinvitaciones')
	def Result eventosDeInvitaciones() {
		val iId = Integer.valueOf(id)
		try {
			val usr = RepoUsuariosAngular.instance.searchById(iId)
			val eventosInvitaciones = new ArrayList<Evento>
			eventosInvitaciones.addAll(usr.invitaciones.map(invitacion|invitacion.evento))
			ok(eventosInvitaciones.toJson) // .map(invitacion|invitacion.evento)
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
			println(body)
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

	@Put('/usuarios/:idUsr/confirmarEvento')
	def Result AnadirEvento(@Body String body) {
		try {

			println(body)
			val usr = RepoUsuariosAngular.instance.searchById(Integer.parseInt(idUsr))
			val invitacionEvento = usr.invitaciones.findFirst(invit|invit.evento.nombreEvento == body)
			val evento = invitacionEvento.evento
//			usr.invitaciones
			usr.eventosAsistir.add(evento)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			println(e.message)
			badRequest(e.message)
		}
	}

	def Usuario actualizarEvento(Evento nuevoEvento, String body, String idusr) {
		nuevoEvento.locacion = RepoLocacionesAngular.instance.search(body.getPropertyValue("locacion")).get(0)
		nuevoEvento.asignarFechas(body.getPropertyValue("inicioEvento"), body.getPropertyValue("finEvento"),
			body.getPropertyValue("fechaMaximaConfirmacion"), body.getPropertyValue("fechaCreacion"))
		val usrActualizado = RepoUsuariosAngular.instance.searchById(Integer.parseInt(idusr))
		usrActualizado.fechaHoraActual = LocalDateTime.of(2018, 06, 05, 12, 35) // Obtiene fecha "actual"
		usrActualizado.crearEvento(nuevoEvento)
		usrActualizado
	}

	@Get('/usuarios/:id/eventos-interesantes')
	def Result eventosInteresantes() {
		val iId = Integer.valueOf(id)
		try {
			val usr = RepoUsuariosAngular.instance.searchById(iId)
			val eventos = eventosOrganizadosUsrsRepo()
			val eventosInteresantes = new ArrayList<Evento>
			eventosInteresantes.addAll(this.eventosConArtistasFavoritoUsr(eventos, usr))
			eventosInteresantes.addAll(this.eventosConAmigosUsr(eventos, usr))
			eventosInteresantes.addAll(this.eventosRadioCercaniaUsr(eventos, usr))
			ok(eventosInteresantes.toSet().toJson)
		} catch (UserException e) {
			notFound("No existe el usuario con id " + id + "")
		}
	}

	def List<Evento> eventosOrganizadosUsrsRepo() {
		return RepoUsuariosAngular.instance.usrsRepo.map(usuario|usuario.eventosOrganizados).flatten().toList()
	}

	def eventosConArtistasFavoritoUsr(List<Evento> eventos, Usuario usr) {
		eventos.filter(evento|evento.artistas.exists(artista|usr.artistasFavoritos.contains(artista))).toSet()
	}

	def eventosConAmigosUsr(List<Evento> eventos, Usuario usr) {
		eventos.filter(evento|evento.asistentes.exists(asistente|asistente.esAmigo(usr))).toSet()
	}

	def eventosRadioCercaniaUsr(List<Evento> eventos, Usuario usr) {
		eventos.filter(evento|usr.eventoEstaCerca(evento)).toSet()
	}
}
