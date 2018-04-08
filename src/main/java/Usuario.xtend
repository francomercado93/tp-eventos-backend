import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class Usuario {
	String nombre
	LocalDateTime fechaActual
	int edad
	// TipoUsuario tipo;
	double saldoAFavor
	List<Usuario> acompaniantes = newArrayList // Son necesarios?
	List<EventoCerrado> invitaciones = newArrayList // Son necesarios?

	def comprarEntradas(EventoAbierto unEvento) {
		unEvento.usuarioCompraEntrada(this)

	}

	def devolverEntrada(EventoAbierto unEvento) {
		unEvento.devolverDinero(this)
		unEvento.asistentes.remove(this)
	}

	def invitarUsuario(Usuario invitado, EventoCerrado Unevento) {
		Unevento.usuarioRecibeInvitacion(invitado)
		invitado.recibirInvitacion(Unevento)

	}

	def recibirInvitacion(EventoCerrado unEvento) {
		invitaciones.add(unEvento)
	}

	def cantidadAcompaniantes() {
		acompaniantes.size()
	}

	def confirmarInvitacion(EventoCerrado unEvento) {
		unEvento.agregarConfirmado(this)
	}
}
