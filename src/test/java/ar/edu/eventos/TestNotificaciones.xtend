package ar.edu.eventos

import ar.edu.notificaciones.NotificacionAmigos
import ar.edu.notificaciones.NotificacionUsuarioQueVivenCerca
import ar.edu.notificaciones.NotificacionUsuariosAmigosOrganizador
import ar.edu.notificaciones.NotificacionYMailContactosCercaEvento
import org.junit.Test
import org.uqbar.mailService.MailService

class TestNotificaciones extends JuegoDatosTest {

	@Test
	def void pruebaNotificacionesAmigos(){
		carla.agregarTipoNotificacion(new NotificacionAmigos)
		carla.crearEvento(lollapalooza)
		
	}
	
	@Test
	def void pruebaNotificacionUsuariosAmigosOrganizador(){
		var notificacion = new NotificacionUsuariosAmigosOrganizador
		notificacion.repoUsuarios = repoUsuariosTest
		carla.agregarTipoNotificacion(notificacion)
		carla.crearEvento(lollapalooza)
	}
	
	@Test
	def void pruebaNotificacionYMailContactosCercaEvento(){
		carla.servicioMail = new MailService		//Falta envio y recepcion del mail mock?
		var notificacion = new NotificacionYMailContactosCercaEvento
		notificacion.repoUsuarios = repoUsuariosTest
		carla.agregarTipoNotificacion(notificacion)
		carla.crearEvento(lollapalooza)

	}
	
	@Test
	def void pruebaNotificacionUsuarioQueVivenCerca(){
		var notificacion = new NotificacionUsuarioQueVivenCerca
		notificacion.repoUsuarios = repoUsuariosTest
		carla.agregarTipoNotificacion(notificacion)
		carla.crearEvento(lollapalooza)
		
	}
	
}