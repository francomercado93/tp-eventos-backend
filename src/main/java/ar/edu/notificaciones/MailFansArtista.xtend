package ar.edu.notificaciones

import ar.edu.eventos.Artista
import ar.edu.usuarios.Usuario
import java.util.List

class MailFansArtista extends Notificacion{
	
	override enviar(Usuario organizador){
		val nuevoEvento = organizador.ultimoEventoOrganizado
		nuevoEvento.artistas.forEach(artista | this.notificarFans(artista, organizador))
	}
	
	def notificarFans(Artista artista, Usuario organizador) {
		usuariosQueSonFansDeArtista(artista).forEach(usr | organizador.enviarMailA(usr, this.mensajeArtista(artista)))
	}
	
	def String mensajeArtista(Artista artista){
		"El artista " + artista.toString + "se presentara en este evento"
	}
	
	def List<Usuario> usuariosQueSonFansDeArtista(Artista artista){
		repoUsuarios.lista.filter(usr | usr.esFanDe(artista)).toList
	}
}