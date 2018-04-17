package ar.edu.eventos

import java.time.LocalDateTime

class Profesional implements TipoUsuario{
	Integer maximaCantidadEventosPorMes = 20
	
	override puedoOrganizarEvento(Usuario unUsuario){
		unUsuario.cantidadEventosOrganizadosMes() < maximaCantidadEventosPorMes
	}
	override cancelarEvento(Evento unEvento){
		unEvento.cancelarEvento()
	}

	override postergarEvento(Evento unEvento, LocalDateTime nuevaFechaInicio){
		unEvento.postergarEvento(nuevaFechaInicio)
	}
	override invitarUsuario(Usuario invitado,Usuario organizador, EventoCerrado unEvento, Integer cantidadAcompaniantes){
		organizador.realizarInvitacion(invitado, unEvento, cantidadAcompaniantes)
	}
}