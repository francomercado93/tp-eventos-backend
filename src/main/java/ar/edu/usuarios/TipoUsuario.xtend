package ar.edu.usuarios

import ar.edu.eventos.Evento
import ar.edu.eventos.EventoCerrado
import java.time.LocalDateTime

interface TipoUsuario {

	def Integer maximaCantidadEventosPorMes()
	
	def Integer maximaCantidadEventosSimultaneos()
	
	def boolean puedoOrganizarEvento(Usuario unUsuario, Evento evento)

	def void cancelarEvento(Evento unEvento)

	def void postergarEvento(Evento unEvento, LocalDateTime nuevaFechaInicio)
	
	def boolean puedeInvitarUsuario(EventoCerrado unEvento,Integer cantidadAcompaniantesMaxima)
		

	
}
