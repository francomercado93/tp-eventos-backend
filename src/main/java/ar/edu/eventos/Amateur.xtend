package ar.edu.eventos

import java.time.LocalDateTime
import ar.edu.eventos.exceptions.BusinessException

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
		if(unEvento.cantidadAsistentesPendientes < cantidadMaximaInvitaciones)		//cada asistente tiene UNA invitacion
			organizador.realizarInvitacion(invitado, unEvento, cantidadAcompaniantes)
		else
			throw new BusinessException("Supero cantidad maxima de invitaciones")
	}
}