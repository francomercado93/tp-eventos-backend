package ar.edu.usuarios

import ar.edu.eventos.Evento
import ar.edu.eventos.EventoCerrado
import java.time.LocalDateTime

interface TipoUsuario {

	def boolean puedoOrganizarEvento(Usuario unUsuario)

	def void cancelarEvento(Evento unEvento)

	def void postergarEvento(Evento unEvento, LocalDateTime nuevaFechaInicio)
	
	def void invitarUsuario(Usuario invitado, Usuario organizador, EventoCerrado unEvento, Integer cantidadAcompaniantes)
}
