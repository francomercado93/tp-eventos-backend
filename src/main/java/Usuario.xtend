//import java.awt.List
import java.time.LocalDateTime
import java.util.ArrayList
import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Usuario {
	String nombre
	LocalDateTime fechaActual
	int edad
	TipoUsuario tipo;
	double saldoAFavor = 0
	Collection<EventoCerrado> invitaciones = new ArrayList<EventoCerrado>
	Collection<Usuario> amigos = new ArrayList<Usuario>
	double radioCercania 
	// EventoCerrado invitaciones
	double acompaniantes = 0
	
	Point puntoDireccionUsuario

	def comprarEntradas(EventoAbierto unEvento) {
		unEvento.usuarioCompraEntrada(this)

	}

	def devolverEntrada(EventoAbierto unEvento) {
		unEvento.devolverDinero(this)
		unEvento.removerUsuario(this)
	}

	def recibirInvitacion(EventoCerrado unEvento) {
		unEvento.usuarioRecibeInvitacion(this)
		invitaciones.add(unEvento)
	// invitaciones = unEvento
	}

	def confirmarInvitacion(EventoCerrado unEvento) {
		unEvento.confirmarUsuario(this)
	}

	def rechazarInvitacion(EventoCerrado unEvento) {
		unEvento.usuarioRechazaInvitacion(this)
	}

	def cantidadAcompaniantes() {
		acompaniantes
	}

	// Organizador
	def invitarUsuario(Usuario invitado, EventoCerrado unEvento) {
		// unEvento.usuarioRecibeInvitacion(invitado)
		invitado.recibirInvitacion(unEvento)

	}

	def aceptarPendientes() {
		this.filtrarInvitacionesCumplenCondicionesPendientes.forEach[invitacion | 
			this.confirmarInvitacion(invitacion)
		]
	}

	def filtrarInvitacionesCumplenCondicionesPendientes() {
		invitaciones.filter[invitacion|this.cumpleCondicionPendientes(invitacion)]
	}

	def boolean cumpleCondicionPendientes(EventoCerrado invitacion) {

		(this.organizadorEsAmigo(invitacion.organizador)) ||
			this.asistenMasDeCuatroAmigos(invitacion) ||
				this.eventoEstaCerca(invitacion)
	}
	
	def boolean eventoEstaCerca(EventoCerrado evento) {
		evento.distancia(puntoDireccionUsuario) <= radioCercania
	}
	
	def boolean asistenMasDeCuatroAmigos(EventoCerrado invitacion) {
		this.cantidadAmigosConfirmadosEvento(invitacion) >= 4
	}
	
	def cantidadAmigosConfirmadosEvento(EventoCerrado invitacion) {
		amigos.filter(amigo | invitacion.estaConfirmado(amigo)).size
	}
	

	def boolean organizadorEsAmigo(Usuario organizador) {

		amigos.contains(organizador)
	}

	def agregarAmigo(Usuario unAmigo) {

		amigos.add(unAmigo)
	}

}
