package ar.edu.usuarios

import ar.edu.eventos.Evento
import ar.edu.eventos.EventoCerrado
import java.time.LocalDateTime
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
@Accessors
class Profesional implements TipoUsuario,Cloneable{
	//NUEVO////
	Profesional clonado
	Usuario auxUsr
	EventoCerrado auxEvento
	Integer auxInvitados
	//////////
	
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
	
	//NUEVO
	override aceptarInvitacion(Usuario unUsuario,EventoCerrado unEvento,Integer invitados){
		auxUsr=unUsuario
		auxEvento=unEvento
		auxInvitados=invitados
		clonado=this.clone as Profesional
		unUsuario.agregarInvitacionAceptada(clonado)
		unEvento.agregarUsuarioAconfirmar(clonado)
	}
	
	override rechazarInvitacion(Usuario unUsuario,EventoCerrado unEvento){
		auxUsr=unUsuario
		auxEvento=unEvento
	    clonado = this.clone as Profesional
		unUsuario.agregarInvitacionRechazada(clonado)
		unEvento.agregarUsuariosArechazar(clonado)
		}
		
	def procesarInvitacionAceptada(){
		var unaInvitacion = auxUsr.eventoInvitacion(auxEvento)			
		if(unaInvitacion !== null)
		unaInvitacion.confirmar(auxInvitados)
		}	
	
	def procesarInvitacionRechazada(){
		var unaInvitacion = auxUsr.eventoInvitacion(auxEvento)		
		if(unaInvitacion !== null)
			unaInvitacion.rechazar()
	}}