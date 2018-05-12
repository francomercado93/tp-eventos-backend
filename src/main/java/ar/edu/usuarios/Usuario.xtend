package ar.edu.usuarios

import ar.edu.eventos.Evento
import ar.edu.eventos.EventoAbierto
import ar.edu.eventos.EventoCerrado
import ar.edu.eventos.exceptions.BusinessException
import java.time.Duration
import java.time.LocalDate
import java.time.LocalDateTime
import java.util.ArrayList
import java.util.Collection
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Usuario {
	int id
	String nombreUsuario
	String nombreApellido
	String mail
	LocalDate fechaNacimiento
	Direccion direccion
	boolean esAntisocial
	double radioCercania
	Set<Usuario> amigos = newHashSet
	LocalDateTime fechaHoraActual
	TipoUsuario tipoUsuario;
	double saldoAFavor = 0
	Collection<Evento> eventosOrganizados = new ArrayList<Evento>
	Set<Invitacion> invitaciones = newHashSet
	
	def setDireccion(String calle, int numero, String localidad, String provincia, Point punto){
		direccion = new Direccion(calle, numero, localidad, provincia, punto)
	}
	
	def edad(){		//cambiar variable edad por metodo edad en tests
		Duration.between(LocalDateTime.of(fechaNacimiento, fechaHoraActual.toLocalTime), fechaHoraActual).getSeconds() / 31536000
	}
	
	// Organizador
	def cambiarTipo(TipoUsuario unTipoUsuario){
		tipoUsuario = unTipoUsuario
	}
	
	//Solo puede realizar invitaciones si la cantidad acompaniantes de la nueva invitacion + la cantidad de posibles asistentes no supera 
	//capacidad maxima, de esta forma el usuario puede confirmar siempre y cuando este a tiempo
	def invitarUsuario(Usuario invitado, EventoCerrado unEvento, Integer cantidadAcompaniantesMaxima) {		
		if(unEvento.chequearCapacidad(cantidadAcompaniantesMaxima) && tipoUsuario.puedeInvitarUsuario(unEvento, cantidadAcompaniantesMaxima))	//Se chequea las condiciones de cada tipoUsuario
			this.realizarInvitacion(invitado, unEvento, cantidadAcompaniantesMaxima)
		else
			throw new BusinessException("No se puede realizar invitacion, el evento llego a su maxima capacidad o alcanzo 
				la cantidad maxima de invitaciones/invitados")
	}
	
	def realizarInvitacion(Usuario invitado, EventoCerrado unEvento, Integer cantidadAcompaniantesMaxima) {
		var unaInvitacion = new Invitacion(invitado, unEvento, cantidadAcompaniantesMaxima)				
		unaInvitacion.usuarioRecibeInvitacion()
	}
	// EN tipo free => !unEvento.class.toString.equals("ar.edu.eventos.EventoAbierto") && !tipoUsuario.toString.equals("ar.edu.usuarios.Free@707f7052")
	def crearEvento(Evento unEvento){		//En test creo el evento primero(para inicializar
		if( this.puedoCrearEvento()){		//variables y luego se lo paso como parametro a
			unEvento.settearVariables(this)	//usuario organizador que es el que cuando lo "crea"
			this.agregarEventoLista(unEvento)	//se setean la fecha de creacio y organizador
		}
		else
			throw new BusinessException("Error no se puede crear evento")
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
		this.eventosOrganizados.filter[evento | this.fechaHoraActual.isBefore(evento.finEvento) ].size //fecha creacion evento = fecha actual del usuario	
	}
	
	def cantidadEventosOrganizadosMes() {
		this.eventosOrganizados.filter[evento | evento.fechaCreacion.month == this.fechaHoraActual.month 
			|| evento.finEvento.month == this.fechaHoraActual.month].size
	}
//Usuario evento cerrado

	def agregarInvitacionLista(Invitacion unaInvitacion){
		invitaciones.add(unaInvitacion)
		println(this.nombreUsuario + " tiene una nueva invitacion para el evento " + unaInvitacion.evento.nombreEvento)
	}
	
	//Se recibe unEvento que funciona como una clave y luego se obtiene la invitacion
	def confirmarInvitacion(EventoCerrado unEvento, Integer cantidadAcompaniantesConfirmados) {	//la cantidad de acompaniantes
		var unaInvitacion = this.eventoInvitacion(unEvento)			//se la define cuando esta por confirmar
		if(unaInvitacion !== null)
			unaInvitacion.confirmar(cantidadAcompaniantesConfirmados)
	}
	
	def rechazarInvitacion(EventoCerrado unEvento) {
		var unaInvitacion = this.eventoInvitacion(unEvento)		
		if(unaInvitacion !== null)
			unaInvitacion.rechazar()
	}
	
	def eventoInvitacion(EventoCerrado unEvento ){
		invitaciones.findFirst(invitacion | invitacion.evento == unEvento)//obtengo la invitacion con el evento
	}
	
	//Usuario Evento Abierto
	def comprarEntrada(EventoAbierto unEvento) {
		unEvento.usuarioCompraEntrada(this)
	}

	def devolverEntrada(EventoAbierto unEvento) {
		if(unEvento.estaInvitado(this) && unEvento.diasfechaMaximaConfirmacion(this) > 0){
			unEvento.devolverDinero(this)
			unEvento.removerUsuario(this)
		}
		else
			throw new BusinessException("Error: usuario no puede devolver entrada")
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
		evento.distancia(direccion.coordenadas) <= radioCercania
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
	
	def notificacionEventoCancelado() {
		println("El evento fue cancelado.")
	}
	
	def notificacionEventoPostergado(Evento unEvento) {
		println("El evento "+unEvento.nombreEvento+" fue postergado.")
		println("Las nuevas fechas son")
		println("Fecha maxima confirmacion: "+unEvento.fechaMaximaConfirmacion)
		println("Fecha Inicio: "+ unEvento.inicioEvento)
		println("Fecha fin: "+unEvento.finEvento)
	}
		
}
