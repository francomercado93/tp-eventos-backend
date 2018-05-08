package ar.edu.repositorios

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.usuarios.Usuario

class RepositorioUsuarios extends Repositorio<Usuario> {

	override create(Usuario usuario) {
		
		if (!search(usuario.nombreUsuario).isEmpty)
			throw new BusinessException("No se puede agregar dos veces al mismo usuario")
		usuario.validarCampos()
		lista.add(usuario)
	}

	override delete(Usuario usuario) {
		lista.remove(usuario)
	}

	override update(Usuario usuario) {
		var Usuario aux = search(usuario.nombreUsuario).get(0)
		if (aux === null)
			throw new BusinessException("No se encontro usuario")
		else
			this.delete(aux)
		usuario.validarCampos()
		lista.add(usuario)
	}

	override search(String string) {
		lista.filter(usuario|this.busquedaPorNombre(usuario, string)).toSet
	}

	def boolean busquedaPorNombre(Usuario usuario, String string) {
		usuario.nombreUsuario.equals(string) || usuario.nombreApellido.indexOf(string) != -1
	}

}
