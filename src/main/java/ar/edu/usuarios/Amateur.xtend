package ar.edu.usuarios

import ar.edu.eventos.Evento
import ar.edu.eventos.EventoCerrado
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Amateur implements TipoUsuario {

	override maximaCantidadEventosPorMes() { // no se usa
		0
	}

	override maximaCantidadEventosSimultaneos() {
		5
	}

	def Integer cantidadMaximaInvitaciones() {
		50
	}

	override puedoOrganizarEvento(Usuario unUsuario, Evento evento) {
		unUsuario.cantidadEventosSimultaneos() < this.maximaCantidadEventosSimultaneos
	}

	override cancelarEvento(Evento unEvento) {
		unEvento.cancelarEvento()
	}

	override postergarEvento(Evento unEvento, LocalDateTime nuevaFechaInicio) {
		unEvento.postergarEvento(nuevaFechaInicio)
	}

	override puedeInvitarUsuario(EventoCerrado unEvento, Integer cantidadAcompaniantesMaxima) {
		unEvento.asistentes.size() < this.cantidadMaximaInvitaciones
	}

	override getDescripcion() {
		"Amateur"
	}

}
