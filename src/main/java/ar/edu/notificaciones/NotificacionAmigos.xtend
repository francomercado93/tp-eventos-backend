package ar.edu.notificaciones

import ar.edu.usuarios.Usuario

class NotificacionAmigos extends Notificacion{
	
	override enviar(Usuario organizador){
		organizador.amigos.forEach(amigo | amigo.recibirNotificacion(organizador))
	}
}