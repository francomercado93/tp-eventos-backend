package ar.edu.notificaciones

import ar.edu.usuarios.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class NotificacionYMailContactosCercaEvento extends Notificacion {

	List<Usuario> contactos = newArrayList
	override enviar(Usuario organizador) {
		obtenerContactosOrganizador(organizador)
		enviarNotificaciones(organizador)
		enviarMails(organizador)
	}

	def obtenerContactosOrganizador(Usuario organizador) {
		contactos.addAll(organizador.amigos)
		contactos.addAll(usuariosQueTienenDeAmigoAOrganizador(organizador))
	}

	def void enviarNotificaciones(Usuario organizador) {
		contactosQueVivenCerca(organizador).forEach(usuario|usuario.recibirNotificacion(organizador))
	}

	def void enviarMails(Usuario organizador) {
		contactosQueVivenCerca(organizador).forEach(usuario|organizador.enviarMailA(usuario))
	}

	def List<Usuario> contactosQueVivenCerca(Usuario organizador) {
		usuariosQueVivenCerca(organizador.ultimoEventoOrganizado, contactos)
	}

}
