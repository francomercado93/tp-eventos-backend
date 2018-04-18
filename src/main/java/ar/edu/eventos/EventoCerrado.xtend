package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.usuarios.Usuario
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class EventoCerrado extends Evento {

	Set<Usuario> invitadosConfirmados = newHashSet
	double cantidadAcompaniantesConfirmados = 0
	double capacidadMaxima

	override capacidadMaxima() {
		capacidadMaxima
	}

	override boolean esExitoso() {
		(estaCancelado == false) && ( this.cantidadInvitacionesConfirmadas >= this.cantidadExito)
	}

	override double cantidadExito() {
		this.cantidadTotalInvitaciones  * 0.8
	}
	
	def cantidadTotalInvitaciones(){
		this.cantidadInvitacionesPendientes + this.cantidadInvitacionesConfirmadas
	}
	
	def cantidadInvitacionesPendientes() { // la lista de asistentes representan a los pendientes
		super.cantidadAsistentes()
	}
	
	def cantidadAsistentesPosibles() { // o Total
		this.cantidadInvitacionesPendientes() + this.cantidadAsistentesConfirmados()
	}


	def cantidadAsistentesConfirmados() {
		invitadosConfirmados.size + cantidadAcompaniantesConfirmados
	}
	def cantidadInvitacionesConfirmadas(){
		invitadosConfirmados.size
	}

	override boolean esFracaso() {
		(this.cantidadInvitacionesConfirmadas <= this.cantidadFracaso)
	}

	override double cantidadFracaso() {
		this.cantidadTotalInvitaciones  * 0.5
	}

	def boolean estaConfirmado(Usuario unUsuario) {
		invitadosConfirmados.contains(unUsuario)
	}

	def boolean chequearCapacidad() {
		this.capacidadMaxima() >= this.cantidadAsistentesPosibles
	}

	def void usuarioRechazaInvitacion(Usuario unUsuario) {
		this.removerUsuario(unUsuario)
	}

	def void confirmarUsuario(Usuario unUsuario) {
		if (this.cumpleCondiciones(unUsuario)) {
			this.agregarListaConfirmado(unUsuario)
		} else
			throw new BusinessException("Usuario paso la fecha maxima de confirmacion y/o no hay capacidad.") // Puede suceder que no haya capacidad porque
	}

	// el organizador invita a mucha gente pero el invitado
	override boolean cumpleCondiciones(Usuario unUsuario) { // confirma la cantidad de asistentes despues
		super.usuarioEstaATiempo(unUsuario) && this.hayCapacidad(unUsuario)
	}

	def boolean hayCapacidad(Usuario unUsuario) { // verifica que no se supere la cantidad maxima
		this.cantidadDisponibles() >= unUsuario.cantidadAcompaniantesInvitado + 1
	}

	override cantidadDisponibles() {
		Math.round(this.capacidadMaxima() - this.cantidadAsistentesPosibles())
	}


	def agregarListaConfirmado(Usuario unUsuario) {
		invitadosConfirmados.add(unUsuario) // Se lo agrega a una lista que no puede estar en otra
		this.agregarAcompaniantesConfirmados(unUsuario)
		this.removerUsuario(unUsuario) // Se lo saca de la lista de pendientes
	}

	def agregarAcompaniantesConfirmados(Usuario unUsuario) {
		cantidadAcompaniantesConfirmados = cantidadAcompaniantesConfirmados + unUsuario.cantidadAcompaniantesInvitado
	}


	def notificarConfirmados() {
		invitadosConfirmados.forEach[usuario|this.notificarUsuario(usuario)]
	}

	override cancelarEvento() {
		super.cancelarEvento
		this.notificarConfirmados()
	}

}
