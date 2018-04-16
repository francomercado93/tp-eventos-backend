//import java.awt.List
package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import java.time.LocalDateTime
import java.util.ArrayList
import java.util.Collection
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Usuario {
	String nombreUsuario
	Integer edad
	boolean esAntisocial
	double radioCercania
	Set<Usuario> amigos = newHashSet
	LocalDateTime fechaActual
	TipoUsuario tipoUsuario;
	double saldoAFavor = 0
	double acompaniantes = 0
	Point puntoDireccionUsuario
	Collection<Evento> eventosOrganizados = new ArrayList<Evento>
	Set<Invitacion> invitaciones = newHashSet
	Integer cantidadAcompaniantesInvitado = 0
	
	// Organizador
	
	def invitarUsuario(Usuario invitado, EventoCerrado unEvento, Integer cantidadAcompaniantes) {		
		tipoUsuario.invitarUsuario(invitado, this, unEvento, cantidadAcompaniantes)	//Se chequea las condiciones de cada tipoUsuario
	}
	def realizarInvitacion(Usuario invitado, EventoCerrado unEvento, Integer cantidadAcompaniantes) {
		if(unEvento.chequearCapacidad()){
			var unaInvitacion = new Invitacion(invitado, cantidadAcompaniantes, unEvento)				
			invitado.recibirInvitacion(unaInvitacion)
		}
		else
			throw new BusinessException("No se puede realizar invitacion, el evento llego a su maxima capacidad.")
	
	}
	
	def crearEvento(Evento unEvento){		//En test creo el evento primero(para inicializar
		if(this.puedoCrearEvento()){		//variables y luego se lo paso como parametro a
			unEvento.settearVariables(this)	//usuario organizador que es el que cuando lo "crea"
			this.agregarEventoLista(unEvento)	//se setean la fecha de creacio y organizador
		}
	}
	def boolean puedoCrearEvento(){
		tipoUsuario.puedoOrganizarEvento(this)
	}
	def void agregarEventoLista(Evento unEvento){
		eventosOrganizados.add(unEvento)
	}
	
	def cancelarEvento(Evento unEvento){
		tipoUsuario.cancelarEvento(unEvento)
	}
	
	def postergarEvento(Evento unEvento, LocalDateTime nuevaFechaInicio){
		tipoUsuario.postergarEvento(unEvento, nuevaFechaInicio)
	}
	
	def cantidadEventosSimultaneos() {
		this.eventosOrganizados.filter[evento | this.fechaActual.isBefore(evento.finEvento) ].size //fecha creacion evento = fecha actual del usuario	
	}
	
	def cantidadEventosOrganizadosMes() {
		this.eventosOrganizados.filter[evento | evento.fechaCreacion.month == this.fechaActual.month 
			|| evento.finEvento.month == this.fechaActual.month].size
	}
//Usuario evento cerrado
	def recibirInvitacion(Invitacion unaInvitacion) {
		unaInvitacion.usuarioRecibeInvitacion()
	}
	def agregarInvitacionLista(Invitacion unaInvitacion){
		invitaciones.add(unaInvitacion)
	}
	//Se recibe unEvento que funciona como una clave y luego se obtiene la invitacion
	def confirmarInvitacion(EventoCerrado unEvento, Integer cantidadAcompaniantes) {	//la cantidad de acompaniantes
		var unaInvitacion = this.eventoInvitacion(unEvento)			//se la define cuando esta por confirmar
		cantidadAcompaniantesInvitado = cantidadAcompaniantes
		if(unaInvitacion !== null)
			unaInvitacion.confirmar(cantidadAcompaniantes)
	}
	
	def rechazarInvitacion(EventoCerrado unEvento) {
		var unaInvitacion = this.eventoInvitacion(unEvento)		
		if(unaInvitacion !== null)
			unaInvitacion.rechazar()
	}
	
	def eventoInvitacion(EventoCerrado unEvento ){
		invitaciones.filter(invitacion | invitacion.evento == unEvento).get(0)	//obtengo la invitacion con el evento
	}
	
	//Usuario Evento Abierto
	def comprarEntrada(EventoAbierto unEvento) {
		unEvento.usuarioCompraEntrada(this)
	}

	def devolverEntrada(EventoAbierto unEvento) {
		unEvento.devolverDinero(this)
		unEvento.removerUsuario(this)
	}
	
	def devolverEntradaSiEventoEstaPostergado(EventoAbierto unEvento){
		if(unEvento.estaPostergado)
			this.devolverEntrada(unEvento)
	}
	
	def aceptarPendientes() {
		this.filtrarInvitacionesCumplenCondicionesPendientes.forEach [ invitacion |
			this.confirmarInvitacion(invitacion.evento, invitacion.cantidadAcompaniantesMaxima)]
	}

	def filtrarInvitacionesCumplenCondicionesPendientes() {
		invitaciones.filter[invitacion|this.cumpleCondicionPendientes(invitacion.evento)]
	}

	def boolean cumpleCondicionPendientes(EventoCerrado unEvento) {
		
		(this.organizadorEsAmigo(unEvento.organizador)) || this.asistenMasDeCuatroAmigos(unEvento) ||
			this.eventoEstaCerca(unEvento)
	}

	def boolean eventoEstaCerca(EventoCerrado evento) {
		evento.distancia(puntoDireccionUsuario) <= radioCercania
	}

	def boolean asistenMasDeCuatroAmigos(EventoCerrado invitacion) {
		this.cantidadAmigosConfirmadosEvento(invitacion) >= 4
	}

	def cantidadAmigosConfirmadosEvento(EventoCerrado invitacion) {
		amigos.filter(amigo|invitacion.estaConfirmado(amigo)).size
	}

	def boolean organizadorEsAmigo(Usuario organizador) {
		amigos.contains(organizador)
	}

	def agregarAmigo(Usuario unAmigo) {
		amigos.add(unAmigo)
	}
	
	def rechazarPendientes() {
		if(esAntisocial)
			this.antisocialRechazarPendientes
		else
			this.noAntisocialRechazarPendientes
	}
	
	def noAntisocialRechazarPendientes() {
		this.pendientesParaRechazarQueCumplenCondicionNoAntisocial.forEach[invitacion | this.rechazarInvitacion(invitacion.evento)]
	}
	
	def pendientesParaRechazarQueCumplenCondicionNoAntisocial() {
		invitaciones.filter[invitacion| this.cumpleCondicionesNoAntisocial(invitacion.evento)]
	}
	
	def boolean cumpleCondicionesNoAntisocial(EventoCerrado unEvento){
		!this.eventoEstaCerca(unEvento) || this.noAsistenAmigos(unEvento)
	}
	
	def boolean noAsistenAmigos(EventoCerrado invitacion) {
		this.cantidadAmigosConfirmadosEvento(invitacion) == 0
	}
	
	def antisocialRechazarPendientes() {
		this.pendientesParaRechazarQueCumplenCondicionAntisocial.forEach[invitacion | this.rechazarInvitacion(invitacion.evento)]
	}
	
	def pendientesParaRechazarQueCumplenCondicionAntisocial() {
		invitaciones.filter[invitacion| this.cumpleCondicionesAntisocial(invitacion.evento)]
	}
	
	def boolean cumpleCondicionesAntisocial(EventoCerrado unEvento) {
		!this.eventoEstaCerca(unEvento) || this.asistenAlMenosDosAmigos(unEvento)
	}

	def boolean asistenAlMenosDosAmigos(EventoCerrado invitacion) {
		this.cantidadAmigosConfirmadosEvento(invitacion) <= 2
	}
	
	def eventoCancelado() {
		println("El evento fue cancelado/postergado")
	}
	
	
	
	
	
}
