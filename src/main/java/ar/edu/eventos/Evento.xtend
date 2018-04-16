package ar.edu.eventos

import java.time.Duration
import java.time.LocalDateTime
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
abstract class Evento {

	Usuario organizador
	String nombreEvento
	LocalDateTime inicioEvento
	LocalDateTime finEvento
	Locacion lugar
	LocalDateTime fechaMaximaConfirmacion
	LocalDateTime fechaCreacion
	double capacidadMaxima
	double porcentajeExito = 0.9
	double porcentajeFracaso = 0.5
	List<Usuario> asistentes = newArrayList
	boolean estaCancelado = false
	boolean estaPostergado = false

	def duracion() {
		Duration.between(inicioEvento, finEvento).getSeconds() / 3600d
	}

	def double distancia(Point unPunto) {
		lugar.distancia(unPunto)
	}

	def double capacidadMaxima() {
		capacidadMaxima
	}

	def boolean esExitoso()

	def double cantidadExito()

	def boolean esFracaso()

	def double cantidadFracaso()

	def double diasfechaMaximaConfirmacion(Usuario unUsuario) {
		Math.rint(Duration.between(unUsuario.fechaActual, this.fechaMaximaConfirmacion).getSeconds() / 86400d) // obtener dias
	}

	def cantidadDisponibles() { // Eventos abiertos => entradas, cerrados => invitaciones
		Math.round(this.capacidadMaxima() - this.cantidadAsistentes)
	}

	def cantidadAsistentes() {
		asistentes.size
	}

	def void agregarUsuarioListaAsistentes(Usuario unUsuario) {
		asistentes.add(unUsuario)
	}

	def removerUsuario(Usuario unUsuario) {
		asistentes.remove(unUsuario)
	}

	def boolean cumpleCondiciones(Usuario unUsuario)

	def boolean usuarioEstaATiempo(Usuario unUsuario) {
		unUsuario.fechaActual.isBefore(this.fechaMaximaConfirmacion)
	}
		
	def void cancelarEvento(){
		estaCancelado = true
	}
	
	def void postergarEvento(LocalDateTime nuevaInicioEvento){
		estaPostergado = true
		this.reprogramarEvento(nuevaInicioEvento)
		this.notificarInvitados
	}
	
	def void reprogramarEvento(LocalDateTime nuevaInicioEvento){
		finEvento = nuevaInicioEvento.plusSeconds(Duration.between(inicioEvento, finEvento).getSeconds)
		fechaMaximaConfirmacion = nuevaInicioEvento.plusSeconds(Duration.between(inicioEvento, fechaMaximaConfirmacion).getSeconds)
		inicioEvento = nuevaInicioEvento
	}
	def void notificarInvitados() {			//En evento abierto se notifica a los que compraron 
		this.notificarPendientes			//entradas(asistentes)
	}
	
	def void notificarPendientes() {
		asistentes.forEach[usuario | this.notificarUsuario(usuario)]
	}
	def void notificarUsuario(Usuario usuario) {
		usuario.eventoCancelado
	}
	
	def void settearVariables(Usuario unUsuario){
		fechaCreacion = unUsuario.fechaActual
		organizador = unUsuario 
	}
	
}



