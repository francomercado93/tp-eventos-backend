package repo

import ar.edu.usuarios.Usuario
import java.util.HashSet
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Repositorio<T> {
	
	Set<T> lista = new HashSet()
	
	def void create(T elemmento) {
		//Hace algo
	}
	
}

class RepositorioUsuarios extends Repositorio<Usuario> {
	
	
	override void create(Usuario unusuario) {
		lista.add (unusuario)
		
	}
	
}