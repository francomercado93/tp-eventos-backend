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
	double acompaniantes = 0
	Point puntoDireccionUsuario
	Collection<EventoCerrado> invitaciones = new ArrayList<EventoCerrado>
	Collection<Usuario> amigos = new ArrayList<Usuario>
	double radioCercania
	boolean esAntisocial
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

	def aceptarPendientes() {
		this.filtrarInvitacionesCumplenCondicionesPendientes.forEach [ invitacion |
			this.confirmarInvitacion(invitacion)
		]
	}

	def filtrarInvitacionesCumplenCondicionesPendientes() {
		invitaciones.filter[invitacion|this.cumpleCondicionPendientes(invitacion)]
	}

	def boolean cumpleCondicionPendientes(EventoCerrado invitacion) {
		(this.organizadorEsAmigo(invitacion.organizador)) || this.asistenMasDeCuatroAmigos(invitacion) ||
			this.eventoEstaCerca(invitacion)
	}

	def boolean eventoEstaCerca(EventoCerrado evento) {
		evento.distancia(puntoDireccionUsuario) <= radioCercania
	}

	def boolean asistenMasDeCuatroAmigos(EventoCerrado invitacion) {
		this.cantidadAmigosConfirmadosEvento(invitacion) >= 4
	}

	def cantidadAmigosConfirmadosEvento(EventoCerrado invitacion) {
		amigos.filter(amigo|invitacion.estaConfirmado(amigo)).size
	}

	def boolean organizadorEsAmigo(Usuario organizador) {
		amigos.contains(organizador)
	}

	def agregarAmigo(Usuario unAmigo) {
		amigos.add(unAmigo)
	}

	// Organizador
	def invitarUsuario(Usuario invitado, EventoCerrado unEvento) {
		invitado.recibirInvitacion(unEvento)
	}

	def organizarEventoAbierto(EventoAbierto abierto) {
		abierto.organizador = this
		tipo.organizarEventoAbierto(abierto)
	}
	def organizarEventoCerrado(EventoCerrado cerrado){
		cerrado.organizador = this
		tipo.organizarEventoCerrado(cerrado)
	}
	
	def rechazarPendientes() {
		if(esAntisocial)
			this.antisocialRechazarPendientes
		else
			this.noAntisocialRechazarPendientes
	}
	
	def noAntisocialRechazarPendientes() {
		this.pendientesParaRechazarQueCumplenCondicionNoAntisocial.forEach[invitacion | this.rechazarInvitacion(invitacion)]
	}
	
	def pendientesParaRechazarQueCumplenCondicionNoAntisocial() {
		invitaciones.filter[invitacion| this.cumpleCondicionesNoAntisocial(invitacion)]
	}
	def boolean cumpleCondicionesNoAntisocial(EventoCerrado invitacion){
		!this.eventoEstaCerca(invitacion) || this.noAsistenAmigos(invitacion)
	}
	def boolean noAsistenAmigos(EventoCerrado invitacion) {
		this.cantidadAmigosConfirmadosEvento(invitacion) == 0
	}
	
	def antisocialRechazarPendientes() {
		this.pendientesParaRechazarQueCumplenCondicionAntisocial.forEach[invitacion | this.rechazarInvitacion(invitacion)]
	}
	
	def pendientesParaRechazarQueCumplenCondicionAntisocial() {
		invitaciones.filter[invitacion| this.cumpleCondicionesAntisocial(invitacion)]
	}
	
	def boolean cumpleCondicionesAntisocial(EventoCerrado invitacion) {
		!this.eventoEstaCerca(invitacion) || this.asistenAlMenosDosAmigos(invitacion)
	}

	def boolean asistenAlMenosDosAmigos(EventoCerrado invitacion) {
		this.cantidadAmigosConfirmadosEvento(invitacion) <= 2
	}
}
