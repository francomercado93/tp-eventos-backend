package ar.edu.notificaciones

import ar.edu.eventos.Evento
import ar.edu.repositorios.RepositorioUsuarios
import ar.edu.usuarios.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Notificacion {
	
	RepositorioUsuarios repoUsuarios
	
	def void enviar(Usuario organizador)
	
	def List<Usuario> usuariosQueTienenDeAmigoAOrganizador(Usuario organizador) {
		repoUsuarios.lista.filter( usuario | usuario.organizadorEsAmigo(organizador)).toList
	}
	
	def List<Usuario> usuariosQueVivenCerca(Evento evento, List<Usuario> usuarios) {
		usuarios.filter(usr|usr.eventoEstaCerca(evento)).toList
	}
}

