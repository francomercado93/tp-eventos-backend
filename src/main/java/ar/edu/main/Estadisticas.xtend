package ar.edu.main

import ar.edu.usuarios.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors

class Estadisticas {
	
	//RepositorioUsuarios repoUsuarios
	
//	new(){
//		repoUsuarios = RepositorioUsuarios.instance
//		repoUsuarios.updateService = new StubUpdateService
//		usuarios = repoUsuarios.lista
//	}
	
	List<Usuario> usuarios
	
	def String cantidadTotalEventosOrganizados(){
		"pepe"
		//usuarios.fold(0d, [acum, usr|acum + usr.cantidadTotalEventosOrganizados()])
	}
}