package ar.edu.main

import ar.edu.conversionActualizacion.StubUpdateService
import ar.edu.repositorios.RepositorioUsuarios
import ar.edu.usuarios.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Estadisticas {
	
		//RepositorioUsuarios repoUsuarios
	
//	new(){
//		repoUsuarios = RepositorioUsuarios.instance
//		repoUsuarios.updateService = new StubUpdateService
//		repoUsuarios.getDatosACtualizados()
//		usuarios = repoUsuarios.lista
//	}
	
	//List<Usuario> usuarios
	
	def cantidadTotalEventosOrganizados(){
		"test"
		//usuarios.fold(0d, [acum, usr|acum + usr.cantidadTotalEventosOrganizados()])
	}
}