package ar.edu.main

import ar.edu.repositorios.RepositorioUsuarios
import ar.edu.usuarios.Usuario
import java.util.Set

class Actualizaciones {
	
	def actualizarUsuarios(Set<Usuario> usuarios, RepositorioUsuarios repo){
		usuarios.forEach(usuario | repo.create(usuario))
	}
}