package ar.edu.usuarios

import ar.edu.eventos.Evento
import ar.edu.eventos.EventoCerrado
import ar.edu.eventos.exceptions.BusinessException
import java.time.LocalDateTime

class Amateur implements TipoUsuario {
	Integer cantidadMaximaInvitaciones = 50
	Integer maximaCantidadeventosSimultaneos = 5
	
	override puedoOrganizarEvento(Usuario unUsuario){
		(unUsuario.cantidadEventosSimultaneos() <= maximaCantidadeventosSimultaneos)
			
	}
	override cancelarEvento(Evento unEvento){
		unEvento.cancelarEvento()
	}

	override postergarEvento(Evento unEvento, LocalDateTime nuevaFechaInicio){
		unEvento.postergarEvento(nuevaFechaInicio)
	}
	override invitarUsuario(Usuario invitado,Usuario organizador, EventoCerrado unEvento, Integer cantidadAcompaniantes){
		if(unEvento.cantidadInvitacionesPendientes < cantidadMaximaInvitaciones)		
			organizador.realizarInvitacion(invitado, unEvento, cantidadAcompaniantes)
		else
			throw new BusinessException("Supero cantidad maxima de invitaciones")
	}
}