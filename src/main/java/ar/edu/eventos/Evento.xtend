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
	LocalDateTime fechaInicio
	LocalDateTime fechaHasta
	Locacion lugar
	LocalDateTime fechaMaxima
	LocalDateTime fechaCreacion
	double capacidadMaxima
	double porcentajeExito = 0.9
	double porcentajeFracaso = 0.5
	List<Usuario> asistentes = newArrayList
	boolean estaCancelado = false
	boolean estaPostergado = false

	def duracion() {
		Duration.between(fechaInicio, fechaHasta).getSeconds() / 3600d
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

	def double diasFechaMaxima(Usuario unUsuario) {
		Math.rint(Duration.between(unUsuario.fechaActual, this.fechaMaxima).getSeconds() / 86400d) // obtener dias
	}

	def cantidadDisponibles() { // Eventos abiertos => entradas, cerrados => invitaciones
		Math.round(this.capacidadMaxima() - this.cantidadAsistentes)
	}

	def cantidadAsistentes() {
		asistentes.size
	}

	def void agregarUsuarioLista(Usuario unUsuario) {
		asistentes.add(unUsuario)
	}

	def removerUsuario(Usuario unUsuario) {
		asistentes.remove(unUsuario)
	}

	def boolean cumpleCondiciones(Usuario unUsuario)

	def boolean usuarioEstaATiempo(Usuario unUsuario) {
		unUsuario.fechaActual.isBefore(this.fechaMaxima)
	}
		
	def void cancelarEvento(){
		estaCancelado = true
	}
	
	def void postergarEvento(LocalDateTime nuevaFechaInicio){
		estaPostergado = true
		this.reprogramarEvento(nuevaFechaInicio)
		this.notificarInvitados
	}
	
	def void reprogramarEvento(LocalDateTime nuevaFechaInicio){
		fechaHasta = nuevaFechaInicio.plusSeconds(Duration.between(fechaInicio, fechaHasta).getSeconds)
		fechaMaxima = nuevaFechaInicio.plusSeconds(Duration.between(fechaInicio, fechaMaxima).getSeconds)
		fechaInicio = nuevaFechaInicio
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
		capacidadMaxima = unUsuario.tipo.capacidadMaxima
	}
	
}

@Accessors
class EventoAbierto extends Evento {

	double espacioNecesarioPorPersona = 0.8
	int edadMinima // organizador crea evento setear edadMinima y valor entrada
	double valorEntrada
	

	override capacidadMaxima() {
		Math.round(lugar.superficie / this.espacioNecesarioPorPersona) // mostraba 5.99 y no 6
	}

	def void usuarioCompraEntrada(Usuario unUsuario) {
		if (this.cumpleCondiciones(unUsuario))
			this.agregarUsuarioLista(unUsuario) // Si no cumple Requisitos no se muestra ninguna mensaje(prguntar excepciones)
	}

	override boolean cumpleCondiciones(Usuario unUsuario) { // muevo metodos de usuario que le corresponden al evento
		(this.superaEdadMin(unUsuario) && this.cantidadDisponibles > 0 && this.usuarioEstaATiempo(unUsuario))
	}

	def boolean superaEdadMin(Usuario unUsuario) {
		unUsuario.edad >= this.edadMinima
	}

	def devolverDinero(Usuario unUsuario) {
		unUsuario.saldoAFavor = valorEntrada * this.porcentajeADevolver(unUsuario)
	}

	def double porcentajeADevolver(Usuario unUsuario) {
		if(this.estaCancelado || this.estaPostergado)
			1
		else if (this.diasFechaMaxima(unUsuario) < 7d && this.diasFechaMaxima(unUsuario) > 0) // falta el caso en el que quedan 0 dias 
			(this.diasFechaMaxima(unUsuario) + 1) * 0.1
		else
			0.8
	}

	override boolean esExitoso() { // Es un exito si quedan menos del 10% de entradas
		this.cantidadDisponibles <= this.cantidadExito
	}

	override double cantidadExito() {
		this.capacidadMaxima() * porcentajeExito
	}

	override esFracaso() {
		this.cantidadDisponibles > this.cantidadFracaso // es un fracaso si quedan mas del 50% de las entradas
	}

	override double cantidadFracaso() {
		this.capacidadMaxima() * porcentajeFracaso
	}
	def devolverValorEntradasAsistentes() {
		asistentes.forEach[usuario | this.devolverDinero(usuario)]
	}
	
	override cancelarEvento() {
		super.cancelarEvento
		this.devolverValorEntradasAsistentes
	}
	

}

@Accessors
class EventoCerrado extends Evento {

	List<Usuario> invitadosConfirmados = newArrayList
	double cantidadDeAcompaniantesMax
	double cantidadAcompaniantes = 0 // Por ahora
	double cantidadAcompaniantesConfirmados = 0 // Por ahora

	override boolean esExitoso() {
		false
	}

	override double cantidadExito() {
		2
	}

	override boolean esFracaso() {
		true
	}

	override double cantidadFracaso() {
		4
	}

	def boolean estaInvitado(Usuario unUsuario) {
		asistentes.contains(unUsuario)
	}
	def boolean estaConfirmado(Usuario unUsuario){
		invitadosConfirmados.contains(unUsuario)
	}

	def void usuarioRecibeInvitacion(Usuario unUsuario) {
		if (this.cumpleCondiciones(unUsuario)) {
			this.agregarUsuarioLista(unUsuario) // Si no cumple Requisitos no se muestra ninguna mensaje(prguntar excepciones)
			this.agregarAcompanientesInvitado(unUsuario)
		}
	}

	def void agregarAcompanientesInvitado(Usuario unUsuario) { // REVISAR
		cantidadAcompaniantes = cantidadAcompaniantes + unUsuario.cantidadAcompaniantes()
	}

	def void usuarioRechazaInvitacion(Usuario unUsuario) {
		this.removerUsuario(unUsuario)
		this.removerAcompaniantesInvitado(unUsuario)
	}

	def void removerAcompaniantesInvitado(Usuario unUsuario) {
		cantidadAcompaniantes = cantidadAcompaniantes - unUsuario.cantidadAcompaniantes()
	}

	override boolean cumpleCondiciones(Usuario unUsuario) {
		(this.usuarioEstaATiempo(unUsuario) && this.cumpleCantidadAcompaniantes(unUsuario) &&
			this.hayCapacidad(unUsuario))
	}

	def boolean hayCapacidad(Usuario unUsuario) { // verifica que no se supere la cantidad maxima
		this.cantidadDisponibles() >= unUsuario.cantidadAcompaniantes() + 1
	}

	def boolean cumpleCantidadAcompaniantes(Usuario unUsuario) {
		unUsuario.cantidadAcompaniantes() <= this.getCantidadDeAcompaniantesMax()
	}

	override cantidadDisponibles() {
		Math.round(this.capacidadMaxima() - this.cantidadAsistentesPosibles())
	}

	def cantidadAsistentesPosibles() { // o Total
		this.cantidadAsistentesPendientes() + this.cantidadAsistentesConfirmados() + cantidadAcompaniantes
	}

	def cantidadAsistentesPendientes() { // cambio el nombre, la lista de asistentes representan
		super.cantidadAsistentes() // a los pendientes
	}

	def cantidadAsistentesConfirmados() {
		invitadosConfirmados.size
	}

	def void confirmarUsuario(Usuario unUsuario) {
		this.agregarListaConfirmado(unUsuario)
		this.agregarAcompaniantesConfirmados(unUsuario)
		this.removerUsuario(unUsuario) // Se lo saca de la lista de pendientes
	}

	def agregarListaConfirmado(Usuario unUsuario) {
		invitadosConfirmados.add(unUsuario)
	}

	def agregarAcompaniantesConfirmados(Usuario unUsuario) {
		cantidadAcompaniantesConfirmados = cantidadAcompaniantesConfirmados + unUsuario.cantidadAcompaniantes
	}
	
	override notificarInvitados() {
		super.notificarPendientes
		this.notificarConfirmados
	}
	
	def notificarConfirmados() {
		invitadosConfirmados.forEach[usuario | this.notificarUsuario(usuario)]
	}
	override cancelarEvento() {
		super.cancelarEvento
		this.notificarInvitados()
	}

}
