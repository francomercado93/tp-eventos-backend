package ar.edu.usuarios

import ar.edu.eventos.EventoCerrado

class Sociable implements TipoPersonalidad{
	
	override rechazarPendientes(Usuario usuario){	
		this.invitacionesPendientesParaRechazarQueCumplenCondiciones(usuario).forEach[invitacion | usuario.rechazarInvitacion(invitacion.evento)]
	}
	
	override invitacionesPendientesParaRechazarQueCumplenCondiciones(Usuario usuario) {
		usuario.invitaciones.filter[invitacion| this.cumpleCondiciones(invitacion.evento, usuario)].toSet
	}
	
	override cumpleCondiciones(EventoCerrado unEvento, Usuario usuario){
		!usuario.eventoEstaCerca(unEvento) || this.noAsistenAmigos(unEvento, usuario)
	}
	
	def boolean noAsistenAmigos(EventoCerrado evento, Usuario usuario) {
		usuario.cantidadAmigosConfirmadosEvento(evento) == 0
	}
	
}