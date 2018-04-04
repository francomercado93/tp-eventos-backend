import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
@Accessors
class Usuario {
	String nombre
	LocalDateTime fechaActual
	int edad
	TipoUsuario tipo;
	double saldoAFavor
    List<String> acompaniantes = newArrayList
	List<EventoCerrado> invitaciones = newArrayList

    
	def comprarEntradas(EventoAbierto unEvento) {
		unEvento.usuarioCompraEntrada(this)

	}

	def boolean superaEdadMin(EventoAbierto unEvento) {
		this.edad >= unEvento.edadMinima
	}

	def devolverEntrada(EventoAbierto unEvento) {
		unEvento.devolverDinero(this)
		unEvento.invitados.remove(this)
	}

	def cumpleCondiciones(EventoAbierto unEvento) {
		(this.superaEdadMin(unEvento) && unEvento.cantidadEntradasDisponibles > 0 &&
			this.fechaActual.isBefore(unEvento.fechaMaxima))
	}

	def InvitarUsuario(Usuario invitado, EventoCerrado Unevento) {
		Unevento.usuarioRecibeInvitacion(invitado)
		invitado.recibirInvitacion(Unevento)

	}

	def recibirInvitacion(EventoCerrado unEvento) {
			invitaciones.add(unEvento)
	}

	def cumpleCondicionesEventoCerrado(EventoCerrado unEvento) {
		 (this.cumpleFecha(unEvento) && this.cumpleCantidadAcompaniantes(unEvento)&& this.hayCapacidad(unEvento))
	}
	
	def boolean hayCapacidad(EventoCerrado unEvento) {
		unEvento.cantidadDeInvitacionesDisp()>= this.cantidadAcompaniantes()+1
	}
	
	def boolean cumpleCantidadAcompaniantes(EventoCerrado unEvento) {
		this.cantidadAcompaniantes() <= unEvento.getCantidadDeAcompaniantesMax() 
	}
	
	def cantidadAcompaniantes() {
		acompaniantes.size() 
	}
	def confirmarInvitacion(EventoCerrado unEvento){
		unEvento.agregarConfirmado(this)
	}
	def boolean cumpleFecha(EventoCerrado unEvento){
		this.fechaActual.isBefore(unEvento.fechaMaxima)
	}
}


