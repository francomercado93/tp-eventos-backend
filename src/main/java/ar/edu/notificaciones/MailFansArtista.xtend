package ar.edu.notificaciones

import ar.edu.eventos.Evento
import ar.edu.usuarios.Usuario
import java.util.List

class MailFansArtista extends Notificacion{
	
	override enviar(Usuario organizador){
		val nuevoEvento = organizador.ultimoEventoOrganizado
		nuevoEvento.artistas.forEach(artista | notificarFans(artista, nuevoEvento))
	}
	
	def notificarFans(String artista, Evento nuevoEvento) {
		usuariosQueSonFansDeArtista(artista).forEach(usr | usr.recibirNotificacionArtista(artista, nuevoEvento))
	}
	
	def List<Usuario> usuariosQueSonFansDeArtista(String artista){
		repoUsuarios.lista.filter(usr | usr.esFanDe(artista)).toList
	}
}