package ar.edu.notificaciones

import ar.edu.usuarios.Usuario

class NotificacionUsuariosAmigosOrganizador extends Notificacion{
	
	override enviar(Usuario organizador){
		this.usuariosQueTienenDeAmigoAOrganizador(organizador).forEach(usuario | usuario.recibirNotificacion(organizador))
	}

}