package ar.edu.usuarios

import ar.edu.eventos.Evento
import ar.edu.eventos.EventoCerrado

import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Free implements TipoUsuario {

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
		!evento.class.equals(ar.edu.eventos.EventoAbierto) && 
			(unUsuario.cantidadEventosOrganizadosMes() < this.maximaCantidadEventosPorMes) &&
				(unUsuario.cantidadEventosSimultaneos() == this.maximaCantidadEventosSimultaneos)
	}

	override cancelarEvento(Evento unEvento) {
		println("Error: usuario free no puede cancelar eventos.")
	}

	override postergarEvento(Evento unEvento, LocalDateTime nuevaFechaInicio) {
		println("Error: usuario free no puede postergar eventos.")
	}

	override puedeInvitarUsuario(EventoCerrado unEvento, Integer cantidadAcompaniantesMaxima) {
		(unEvento.cantidadAsistentesPosibles + cantidadAcompaniantesMaxima + 1 <= this.cantidadMaximaPersonasEvento) // Hasta 50 personas en total
	}
	
	override aceptarInvitacion(Usuario unUsuario,EventoCerrado unEvento,Integer invitados){
		
	}
	
	override rechazarInvitacion(Usuario unUsuario,EventoCerrado unEvento){
		
	}

/*override organizarEventoAbierto(EventoAbierto abierto){
 * 	println("Usuario free no puede organizar evento abierto")
 * }
 */
}
