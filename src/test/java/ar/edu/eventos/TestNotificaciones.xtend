package ar.edu.eventos

import ar.edu.notificaciones.NotificacionAmigos
import ar.edu.notificaciones.NotificacionUsuarioQueVivenCerca
import ar.edu.notificaciones.NotificacionUsuariosAmigosOrganizador
//import ar.edu.notificaciones.NotificacionYMailContactosCercaEvento
import org.junit.Test
import org.uqbar.mailService.Mail

import static org.mockito.ArgumentMatchers.*
import static org.mockito.Mockito.*
import ar.edu.notificaciones.MailFansArtista

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
	
//	@Test
//	def void pruebaNotificacionYMailContactosCercaEvento(){
//		carla.servicioMail = mockedServicioMail		
//		var notificacion = new NotificacionYMailContactosCercaEvento
//		notificacion.repoUsuarios = repoUsuariosTest
//		carla.agregarTipoNotificacion(notificacion)
//		carla.crearEvento(lollapalooza) 
//		verify(mockedServicioMail, times(3)).sendMail(any(Mail))
//
//	}
	
	@Test
	def void pruebaNotificacionUsuarioQueVivenCerca(){
		var notificacion = new NotificacionUsuarioQueVivenCerca
		notificacion.repoUsuarios = repoUsuariosTest
		carla.agregarTipoNotificacion(notificacion)
		carla.crearEvento(lollapalooza)	
	}
	
	@Test
	def void pruebaMailUsuariosFanDeArtistasDeUnEvento(){
		carla.servicioMail = mockedServicioMail		
		var notificacion = new MailFansArtista
		notificacion.repoUsuarios = repoUsuariosTest
		carla.agregarTipoNotificacion(notificacion)
		carla.crearEvento(lollapalooza) 
		verify(mockedServicioMail, times(4)).sendMail(any(Mail))
	}	
}