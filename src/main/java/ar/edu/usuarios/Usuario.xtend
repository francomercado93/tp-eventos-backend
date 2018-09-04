

package ar.edu.usuarios

import ar.edu.eventos.Artista
import ar.edu.eventos.Evento
import ar.edu.eventos.EventoAbierto
import ar.edu.eventos.EventoCerrado
import ar.edu.eventos.exceptions.BusinessException
import ar.edu.invitaciones.AceptacionMasiva
import ar.edu.invitaciones.Invitacion
import ar.edu.main.ServicioInvitacionesAsincronico
import ar.edu.notificaciones.Notificacion
import java.time.Duration
import java.time.LocalDate
import java.time.LocalDateTime
import java.util.ArrayList
import java.util.Date
import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.ccService.CCResponse
import org.uqbar.ccService.CreditCard
import org.uqbar.ccService.CreditCardService
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional
import org.uqbar.geodds.Point
import org.uqbar.mailService.Mail
import org.uqbar.mailService.MailServiceimport org.uqbar.commons.model.exceptions.UserException

@Accessors
@Transactional
@Observable
class Usuario /*extends Entity*/ implements Cloneable { 
	int id 
	 
	String nombreUsuario
	String nombreApellido
	String mail
	LocalDate fechaNacimiento
	Date nacimiento
	Direccion direccion
	TipoPersonalidad tipoPersonalidad
	double radioCercania
	Set<Usuario> amigos = new HashSet<Usuario>()
	LocalDateTime fechaHoraActual
	TipoUsuario tipoUsuario;
	double saldoAFavor = 0
	List<Evento> eventosOrganizados = new ArrayList<Evento>()
	Set<Invitacion> invitaciones = new HashSet<Invitacion>()
	CreditCard miTarjeta
	CreditCardService servicioTarjeta
	List<Notificacion> tiposNotificaciones = new ArrayList<Notificacion>()
	MailService servicioMail
	List<Artista> artistasFavoritos = new ArrayList<Artista>()
	Set<Usuario> invAceptado = new HashSet<Usuario>()
	Set<Usuario> invRechazado = new HashSet<Usuario>()
	EventoCerrado auxEvento
	int auxInvitados
	Usuario clon
	int cantidadEntradasCompradas
	int cantidadInvitacionesConfirmadas
	
	new(){
		id = -1
	}
	def void setNombreUsuario(String unNombreUsuario){
		if( nombreUsuario !== null)	{
			throw new UserException("Nombre no valido")
		}
		nombreUsuario = unNombreUsuario
	
	}

	
	AceptacionMasiva aceptacionMasiva = new AceptacionMasiva
	
	def setDireccion(String calle, int numero, String localidad, String provincia, Point punto){
		direccion = new Direccion(calle, numero, localidad, provincia, punto)
	}
	
	def getEdad(){		
		Duration.between(LocalDateTime.of(fechaNacimiento, fechaHoraActual.toLocalTime), fechaHoraActual).getSeconds() / 31536000
	}
	
	// Organizador
	def cambiarTipoUsuario(TipoUsuario unTipoUsuario){
		tipoUsuario = unTipoUsuario
	}
	
	/*Solo puede realizar invitaciones si la cantidad de acompaniantes de la nueva invitacion + la cantidad de posibles asistentes no supera 
	capacidad maxima, de esta forma EL USUARIO PUEDE CONFIRMAR SIEMPRE y cuando este a tiempo*/
	def invitarUsuario(Usuario invitado, EventoCerrado unEvento, Integer cantidadAcompaniantesMaxima) {		
		if(puedeInvitarUsuario(unEvento, cantidadAcompaniantesMaxima))	//Se chequea las condiciones de cada tipoUsuario
			this.realizarInvitacion(invitado, unEvento, cantidadAcompaniantesMaxima)
		else
			throw new BusinessException("No se puede realizar invitacion, el evento llego a su maxima capacidad o alcanzo 
				la cantidad maxima de invitaciones/invitados")
	}
	
	def boolean puedeInvitarUsuario(EventoCerrado unEvento, Integer cantidadAcompaniantesMaxima) {
		this.esOrganizadorEvento(unEvento) && unEvento.chequearCapacidad(cantidadAcompaniantesMaxima) 
		&& tipoUsuario.puedeInvitarUsuario(unEvento, cantidadAcompaniantesMaxima)
	}
	
	def boolean esOrganizadorEvento(EventoCerrado unEvento) {
		eventosOrganizados.contains(unEvento)
	}
	
	def realizarInvitacion(Usuario invitado, EventoCerrado unEvento, Integer cantidadAcompaniantesMaxima) {
		var unaInvitacion = new Invitacion(invitado, unEvento, cantidadAcompaniantesMaxima)				
		invitado.recibirInvitacion(unaInvitacion)
	}
	
	//Usuario evento cerrado

	def recibirInvitacion(Invitacion unaInvitacion){
		invitaciones.add(unaInvitacion)
		unaInvitacion.recibirNotificacionNuevaInvitacion()
	}
	
	//Se recibe unEvento que funciona como una clave y luego se obtiene la invitacion
	def confirmarInvitacion(EventoCerrado unEvento, Integer cantidadAcompaniantesConfirmados) {	//la cantidad de acompaniantes
		var unaInvitacion = this.getEventoDeInvitacion(unEvento)		
		if(unaInvitacion === null){
			throw new BusinessException("No estas invitado a este evento")
		}
		unaInvitacion.confirmar(cantidadAcompaniantesConfirmados)
	}
	
	def rechazarInvitacion(EventoCerrado unEvento) {
		var unaInvitacion = this.getEventoDeInvitacion(unEvento)		
		if(unaInvitacion === null){
			throw new BusinessException("No estas invitado a este evento")
		}
		unaInvitacion.rechazar()
	}
	
	def getEventoDeInvitacion(EventoCerrado unEvento ){
		invitaciones.findFirst(invitacion | invitacion.evento == unEvento)//obtengo la invitacion con el evento
	}
	
	def crearEvento(Evento unEvento){		
		if(!this.puedoCrearEvento(unEvento)){		
			throw new BusinessException("Error no se puede crear evento")
		}
		this.agregarEventoLista(unEvento)	
		this.enviarNotificaciones()
	}
	
	def enviarNotificaciones() {
		tiposNotificaciones.forEach(notificacion |  notificacion.enviar(this))
	}
	
	def agregarTipoNotificacion(Notificacion nuevaNotifiacion){
		tiposNotificaciones.add(nuevaNotifiacion)
	}
	
	def boolean puedoCrearEvento(Evento evento){
		tipoUsuario.puedoOrganizarEvento(this, evento)
	}
	
	def void agregarEventoLista(Evento unEvento){
		unEvento.setFechaCreacionyOrganizador(this)
		eventosOrganizados.add(unEvento)
	}
	
	def cancelarEvento(Evento unEvento){
		tipoUsuario.cancelarEvento(unEvento)
	}
	
	def postergarEvento(Evento unEvento, LocalDateTime nuevaFechaInicio){
		tipoUsuario.postergarEvento(unEvento, nuevaFechaInicio)
	}
	
	def cantidadEventosSimultaneos() {
		eventosOrganizados.filter[evento | this.fechaHoraActual.isBefore(evento.finEvento) ].size //fecha creacion evento = fecha actual del usuario	
	}
	
	def cantidadEventosOrganizadosMes() {
		eventosOrganizados.filter[evento | evento.fechaCreacion.month == this.fechaHoraActual.month 
			|| evento.finEvento.month == this.fechaHoraActual.month].size
	}
	
	def cantidadTotalEventosOrganizados() {
		eventosOrganizados.size
	}
	
//EVENTOS ABIERTOS
	
	def comprarEntrada(EventoAbierto unEvento) {	
		if(!unEvento.cumpleCondiciones(this)){
			throw new BusinessException("Error: no se puede comprar entrada")
		}
		this.pagarConTarjeta(unEvento)
		unEvento.agregarUsuarioListaAsistentes(this)
		
	}
	
	def String pagarConTarjeta(EventoAbierto unEvento) {
		val CCResponse response = servicioTarjeta.pay(miTarjeta, unEvento.valorEntrada)
		if(response.statusCode != 0) {
			throw new BusinessException(response.statusMessage)
		}
		println(response.statusMessage)
	}
	
	def devolverEntrada(EventoAbierto unEvento) {
		unEvento.usuarioDevuelveEntrada(this)
	}
	
	def aceptarInvitacionesPendientes() {
		aceptacionMasiva.procesarInvitacionesPendientes(invitaciones)	
	}

	def agregarAmigo(Usuario unAmigo) {
		amigos.add(unAmigo)
	}
	
	def rechazarPendientes() {
		tipoPersonalidad.rechazarPendientes(invitaciones)
	}
	
	def boolean eventoEstaCerca(Evento evento) {
		evento.distancia(direccion.coordenadas) <= radioCercania
	}
	
	def boolean organizadorEsAmigo(Usuario organizador) {
		amigos.contains(organizador)
	}
	
	def cantidadAmigosConfirmadosEvento(EventoCerrado evento) {
		this.amigos.filter(amigo|evento.estaConfirmado(amigo)).size
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
	
	def recibirNotificacion(Usuario organizador) {
		println(nombreUsuario+": El usuario "+organizador.nombreUsuario+" creo el evento "+organizador.ultimoEventoOrganizado.nombreEvento)
	}
	
	def ultimoEventoOrganizado() {
		eventosOrganizados.last 
	}
	
	def enviarMailA(Usuario contacto, String mensaje){
		servicioMail.sendMail(new Mail =>[
			to = contacto.mail
			from = this.mail
			subject = "Nuevo evento cerca"
			text = "El usuario "+ contacto.nombreUsuario +"creo el evento " 
			+ this.ultimoEventoOrganizado() + mensaje
		])
	}
	
	def esFanDe(Artista artista) {
		artistasFavoritos.contains(artista)
	}
	
	def agregarArtistaFavorito(Artista artista){
		artistasFavoritos.add(artista)
	}
	
	def borrarArtistaFavorito(Artista artista){
		artistasFavoritos.remove(artista)
	}
	
	def confirmacionAsincronica (ServicioInvitacionesAsincronico unServicio,EventoCerrado unEvento, Integer invitados){
		auxEvento=unEvento
		auxInvitados=invitados
		clon=this.clone as Usuario
		invAceptado.add(clon)
		unServicio.usuariosAProcesar.add(this) 
	}
	
	def rechazoAsincronica (ServicioInvitacionesAsincronico unServicio,EventoCerrado unEvento){
		auxEvento=unEvento
		clon=this.clone as Usuario
		invRechazado.add(clon)
		unServicio.usuariosAProcesar.add(this) 
	}
	
	def procesarAceptados(){
		invAceptado.forEach[usr|usr.confirmarInvitacion(usr.auxEvento,usr.auxInvitados)]
	}
	
	def procesarRechazados(){
		invRechazado.forEach[usr|usr.rechazarInvitacion(usr.auxEvento)]
	}
	
	def cambiarDesicionAceptado(ServicioInvitacionesAsincronico unServicio,EventoCerrado unEvento){
		unServicio.cambiarDesicionAceptado(this,unEvento)
	}
	
	def cambiarDesicionRechazado(ServicioInvitacionesAsincronico unServicio,EventoCerrado unEvento){
		unServicio.cambiarDesicionRechazado(this,unEvento)
	}
	
	def sumarSaldoAFavor(EventoAbierto evento) {
		saldoAFavor +=  evento.valorEntrada * evento.porcentajeADevolver(this)
	}
	
	def getTiposPosibles(){
		#[new Free, new Amateur,new Profesional]
	}
		def cantidadActividad() {
		this.cantidadTotalEventosOrganizados + cantidadEntradasCompradas +cantidadInvitacionesConfirmadas
	}
	
	def cantidadInvitaciones() {
		invitaciones.size
	}
}