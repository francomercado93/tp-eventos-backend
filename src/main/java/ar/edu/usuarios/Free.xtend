package ar.edu.usuarios

import ar.edu.eventos.Evento
import ar.edu.eventos.EventoCerrado
import ar.edu.eventos.exceptions.BusinessException
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Free implements TipoUsuario {

String descripcion="Free"

	override maximaCantidadEventosPorMes() {
		3
	}

	override maximaCantidadEventosSimultaneos() {
		0
	}

	def Integer cantidadMaximaPersonasEvento() {
		50
	}

	override puedoOrganizarEvento(Usuario unUsuario, Evento evento) {
		evento.tipoUsuarioPuedeOrganizar() && (unUsuario.cantidadEventosOrganizadosMes() < this.maximaCantidadEventosPorMes) &&
			(unUsuario.cantidadEventosSimultaneos() == this.maximaCantidadEventosSimultaneos)
	}

	override cancelarEvento(Evento unEvento) {
		throw new BusinessException("Error: usuario free no puede cancelar eventos.")
	}

	override postergarEvento(Evento unEvento, LocalDateTime nuevaFechaInicio) {
		throw new BusinessException("Error: usuario free no puede postergar eventos.")
	}

	override puedeInvitarUsuario(EventoCerrado unEvento, Integer cantidadAcompaniantesMaxima) {
		(unEvento.cantidadAsistentesPosibles + cantidadAcompaniantesMaxima + 1 <= this.cantidadMaximaPersonasEvento) // Hasta 50 personas en total
	}
	
	override mostrarDescripcion() {
		descripcion
	}
	
}
