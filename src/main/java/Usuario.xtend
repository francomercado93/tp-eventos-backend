import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
//import java.util.List

@Accessors
class Usuario {			//clase usuario y clase organizador con una interface?
	String nombre
	LocalDateTime fechaActual
	int edad
	// TipoUsuario tipo;
	double saldoAFavor
	//List<Usuario> acompaniantes = newArrayList // Son necesarios?
	//List<EventoCerrado> invitaciones = newArrayList // Son necesarios?
	double acompaniantes = 0
	def comprarEntradas(EventoAbierto unEvento) {
		unEvento.usuarioCompraEntrada(this)

	}

	def devolverEntrada(EventoAbierto unEvento) {
		unEvento.devolverDinero(this)
		unEvento.removerUsuario(this)
	}


	def recibirInvitacion(EventoCerrado unEvento) {
		unEvento.usuarioRecibeInvitacion(this)		
		//invitaciones.add(unEvento)
	}

	def confirmarInvitacion(EventoCerrado unEvento) {
		unEvento.confirmarUsuario(this)
	}
	
	def rechazarInvitacion(EventoCerrado unEvento){
		unEvento.usuarioRechazaInvitacion(this)
	}
	
	def cantidadAcompaniantes() {
		acompaniantes
	}
	//Organizador
 	def invitarUsuario(Usuario invitado, EventoCerrado unEvento) {
		unEvento.usuarioRecibeInvitacion(invitado)
		invitado.recibirInvitacion(unEvento)

	}	
}
