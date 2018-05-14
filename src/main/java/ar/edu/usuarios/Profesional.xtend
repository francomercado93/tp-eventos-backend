package ar.edu.usuarios

import ar.edu.eventos.Evento
import ar.edu.eventos.EventoCerrado
import java.time.LocalDateTime

class Profesional implements TipoUsuario{
	
	
	override maximaCantidadEventosPorMes(){
		20
	}
	
	override maximaCantidadEventosSimultaneos(){
		20
	}
	
	override puedoOrganizarEvento(Usuario unUsuario, Evento evento){
		unUsuario.cantidadEventosOrganizadosMes() < this.maximaCantidadEventosPorMes &&
			(unUsuario.cantidadEventosSimultaneos() < this.maximaCantidadEventosSimultaneos)
	}
	
	override cancelarEvento(Evento unEvento){
		unEvento.cancelarEvento()
	}

	override postergarEvento(Evento unEvento, LocalDateTime nuevaFechaInicio){
		unEvento.postergarEvento(nuevaFechaInicio)
	}
	override puedeInvitarUsuario(EventoCerrado unEvento, Integer cantidadAcompaniantesMaxima){
		true
	}
}