package ar.edu.eventos

import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class TipoUsuario {
	
	def boolean puedoOrganizarEvento(Usuario unUsuario)
	
	def cantidadEventosSimultaneos(Usuario unUsuario) {
		unUsuario.eventosOrganizados.filter[evento | unUsuario.fechaActual.isBefore(evento.fechaHasta) ].size //fecha creacion evento = fecha actual del usuario	
	}
	
	def cantidadEventosOrganizadosMes(Usuario unUsuario) {
		unUsuario.eventosOrganizados.filter[evento | evento.fechaCreacion.month == unUsuario.fechaActual.month 
			|| evento.fechaHasta.month == unUsuario.fechaActual.month].size
	}
	
	def void cancelarEvento(Evento unEvento) {
		unEvento.cancelarEvento
	}
	
	def void postergarEvento(Evento unEvento, LocalDateTime nuevaFechaInicio){
 	 	unEvento.postergarEvento(nuevaFechaInicio)
 	}
 	def double  capacidadMaxima() 
		
}
