package ar.edu.usuarios

import ar.edu.eventos.EventoCerrado
import ar.edu.eventos.exceptions.BusinessException
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Invitacion {
	EventoCerrado evento
	Usuario invitado
	Integer cantidadAcompaniantesMaxima
	new (Usuario invitado, Integer cantidadAcompaniantesMaxima, EventoCerrado evento){
		this.invitado = invitado
		this.cantidadAcompaniantesMaxima = cantidadAcompaniantesMaxima
		this.evento = evento
	}
	def void usuarioRecibeInvitacion(){
		invitado.agregarInvitacionLista(this)
		evento.agregarUsuarioListaAsistentes(invitado)
	}
	
	def void confirmar(Integer cantidadAcompaniantesInvitado){
		if(cantidadAcompaniantesInvitado <= cantidadAcompaniantesMaxima)
			evento.confirmarUsuario(invitado)
		else
			throw new BusinessException("La cantidad de acompaniantes supera la maxima permitida en la invitacion")
	}
	
	def void rechazar(){
		evento.usuarioRechazaInvitacion(invitado)
	}
}