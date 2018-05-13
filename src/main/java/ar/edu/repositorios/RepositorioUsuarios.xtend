package ar.edu.repositorios

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.usuarios.Usuario

class RepositorioUsuarios extends Repositorio<Usuario> {

	override create(Usuario usuario) {
		if (validarCampos(usuario))
			throw new BusinessException("Usuario no valido")
		this.asignarId(usuario)
		lista.add(usuario)
	}

	override Usuario searchById(int id) {
		lista.findFirst(usuario|usuario.id == id)
	}

	override asignarId(Usuario usuario) {
		if (usuario.id == -1) {
			usuario.id = id
			id = id + 1
		}
	}

	override delete(Usuario usuario) {
		lista.remove(usuario)
	}

	override update(Usuario usuario) {
		// BUSCA CON EL NOMBRE USUARIO, ASIGNACION DE ID AL OBJETO ACTUALIZADO SE HACE DESPUES
		if (search(usuario.nombreUsuario).isEmpty)
			throw new BusinessException("No se encontro el usuario " + usuario.nombreUsuario)
		usuario.id = search(usuario.nombreUsuario).get(0).id
		this.delete(search(usuario.nombreUsuario).get(0)) // Si lo encuentra elimina el anterior objeto  del repo y agrega el nuevo
		this.create(usuario)
	}

	override search(String nombre) {
		lista.filter(usuario|this.busquedaPorNombre(usuario, nombre)).toSet
	}

	def boolean busquedaPorNombre(Usuario usuario, String nombre) {
		usuario.nombreUsuario.equals(nombre) || usuario.nombreApellido.indexOf(nombre) != -1
	}

	def boolean validarCampos(Usuario usuario) {
		usuario.nombreUsuario === null || usuario.nombreApellido === null || usuario.mail === null ||
			usuario.fechaNacimiento === null || usuario.direccion === null
	}

}
