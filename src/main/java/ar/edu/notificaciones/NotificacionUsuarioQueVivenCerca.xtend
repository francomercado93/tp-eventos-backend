package ar.edu.notificaciones

import ar.edu.usuarios.Usuario
import ar.edu.eventos.exceptions.BusinessException

class NotificacionUsuarioQueVivenCerca extends Notificacion{
	
	override enviar(Usuario organizador){
		var nuevoEvento = organizador.ultimoEventoOrganizado
		if(!nuevoEvento.class.equals(ar.edu.eventos.EventoAbierto))
			throw new BusinessException("Error: no se puede notificar el evento es cerrado")
		usuariosQueVivenCerca(nuevoEvento, repoUsuarios.lista).forEach(usr | usr.recibirNotificacion(organizador))
	}
}