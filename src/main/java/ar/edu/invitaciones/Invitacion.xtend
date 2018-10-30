package ar.edu.invitaciones

import ar.edu.eventos.EventoCerrado
import ar.edu.eventos.exceptions.BusinessException
import ar.edu.usuarios.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty

@Accessors
class Invitacion {
	EventoCerrado evento
	@JsonIgnore Usuario invitado
	Integer cantidadAcompaniantesMaxima = 0
	@JsonIgnore Integer cantidadAcompaniantesConfirmados = 0
	boolean estaConfirmado 
	boolean estaRechazado 
//	
	new (Usuario invitado, EventoCerrado unEvento, Integer unaCantidadAcompaniantesMaxima){
		this.invitado = invitado
		this.cantidadAcompaniantesMaxima = unaCantidadAcompaniantesMaxima
		this.evento = unEvento
		this.estaConfirmado = false
		this.estaRechazado = false
	}
	@JsonProperty("invitado")
	def getNombreUsuarioInvitado(){
		invitado.nombreUsuario
	}
	
	def void confirmar(Integer cantidadAcompaniantesInvitado){
			cantidadAcompaniantesConfirmados = cantidadAcompaniantesInvitado	//guardo la cantidad en una variable de invitacion
		if(cantidadAcompaniantesConfirmados <= cantidadAcompaniantesMaxima){
			estaConfirmado = true
			evento.confirmarUsuario(invitado)
		}
		else
			throw new BusinessException("La cantidad de acompaniantes supera la maxima permitida en la invitacion")
	}
	
	def void rechazar(){
		estaRechazado = true
		evento.usuarioRechazaInvitacion(invitado)
	}
	
	def String recibirNotificacionNuevaInvitacion() {
		evento.agregarUsuarioListaAsistentes(invitado)
		println(invitado.nombreUsuario + " tiene una nueva invitacion para el evento " + evento.nombreEvento)
	}
}