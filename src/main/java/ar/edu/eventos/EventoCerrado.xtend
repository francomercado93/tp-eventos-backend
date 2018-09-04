package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.main.ServicioInvitacionesAsincronico
import ar.edu.usuarios.Usuario
import java.util.HashSet
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class EventoCerrado extends Evento {

	Set<Usuario> invitadosConfirmados = new HashSet<Usuario>
	Integer capacidadMaxima
	
	override porcentajeExito(){
		0.8
	}
	
	override capacidadMaxima() {
		capacidadMaxima
	}

	override boolean esExitoso() {
		(estaCancelado == false) && ( this.cantidadInvitacionesConfirmadas >= this.cantidadExito)
	}

	override double cantidadExito() {
		this.cantidadTotalInvitaciones  * this.porcentajeExito
	}
	
	override cantidadTotalInvitaciones(){
		asistentes.size() + this.cantidadInvitacionesConfirmadas
	}
	
	
	def cantidadAcompaniantesPendientes(){	//Obtiene la cantidad maxima de acompaniantes de las invitaciones para este evento
		asistentes.fold(0, [ acum, usuario | acum + usuario.getEventoDeInvitacion(this).cantidadAcompaniantesMaxima ])
	}
	
	override cantidadAsistentesPosibles() { // o Total
		this.cantidadInvitacionesPendientes() +  this.cantidadAcompaniantesPendientes + this.cantidadAsistentesConfirmados()
	}
	
	def cantidadInvitacionesPendientes() {
		asistentes.size()
	}
	
	def cantidadAsistentesConfirmados() {
		this.cantidadInvitacionesConfirmadas + this.cantidadAcompaniantesConfirmados
	}
	
	def cantidadAcompaniantesConfirmados(){
		invitadosConfirmados.fold(0, [ acum, usuario | acum + usuario.getEventoDeInvitacion(this).cantidadAcompaniantesConfirmados ])
	}
	
	def cantidadInvitacionesConfirmadas(){
		invitadosConfirmados.size
	}

	override boolean esFracaso() {
		(this.cantidadInvitacionesConfirmadas <= this.cantidadFracaso)
	}

	override double cantidadFracaso() {
		this.cantidadTotalInvitaciones  * this.porcentajeFracaso
	}

	def boolean estaConfirmado(Usuario unUsuario) {
		invitadosConfirmados.contains(unUsuario)
	}

	def boolean chequearCapacidad(Integer cantidadAcompaniantesMaximaNuevaInvitacion) {
		this.capacidadMaxima() >= this.cantidadAsistentesPosibles + cantidadAcompaniantesMaximaNuevaInvitacion + 1
	}

	def void usuarioRechazaInvitacion(Usuario unUsuario) {
		this.removerUsuario(unUsuario)
	}

	def void confirmarUsuario(Usuario invitado) {
		if (this.cumpleCondiciones(invitado)) {
			this.agregarListaConfirmado(invitado)
		} else
			throw new BusinessException("Usuario paso la fecha maxima de confirmacion ") 
	}										

	override cumpleCondiciones(Usuario invitado){
		super.usuarioEstaATiempo(invitado)
	}
	
	override cantidadDisponibles() {
		Math.round(this.capacidadMaxima() - this.cantidadAsistentesPosibles())
	}


	def agregarListaConfirmado(Usuario unUsuario) {
		invitadosConfirmados.add(unUsuario) // Se lo agrega a una lista que no puede estar en otra
		super.removerUsuario(unUsuario) // Se lo saca de la lista de pendientes
	}

	def notificarConfirmados() {
		invitadosConfirmados.forEach[usuario|this.notificarUsuario(usuario)]
	}

	override cancelarEvento() {
		super.cancelarEvento
		this.notificarConfirmados()
	}
   def ejecucionesDeInvitacionesAsincronicas(ServicioInvitacionesAsincronico unServicio){
   	unServicio.ejecucionInvitacionesAsincronicas
   }
   
}