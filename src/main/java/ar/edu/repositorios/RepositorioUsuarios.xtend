package ar.edu.repositorios

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.usuarios.Usuario

class RepositorioUsuarios extends Repositorio<Usuario> {

	override create(Usuario usuario) {
		this.validarCampos(usuario)
		this.asignarId(usuario)
		super.create(usuario)
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

	override update(Usuario usrActualizado) {
		// BUSCA CON EL NOMBRE USUARIO. ASIGNACION DE ID AL OBJETO ACTUALIZADO SE HACE DESPUES
		if (search(usrActualizado.nombreUsuario).isEmpty)
			throw new BusinessException("No se encontro el usuario " + usrActualizado.nombreUsuario)
		//if(lista.contains(usrActualizado))
			this.actualizar(usrActualizado)
	}
	
	def actualizar(Usuario usuario) {
		//var usrRepo = search(usuario.nombreUsuario).get(0)
		//if(!usuario.nombreApellido.equals(usrRepo.nombreApellido))
			//usrRepo.nombreApellido = usuario.nombreApellido
		usuario.id = search(usuario.nombreUsuario).get(0).id
		this.delete(search(usuario.nombreUsuario).get(0)) // Si lo encuentra elimina el anterior objeto  del repo y agrega el nuevo
		this.create(usuario)
	}

	override busquedaPorNombre(Usuario usuario, String nombre) {
		usuario.nombreUsuario.equals(nombre) || usuario.nombreApellido.indexOf(nombre) != -1
	}

	override validarCampos(Usuario usuario) {
		if(usuario.nombreUsuario === null || usuario.nombreApellido === null || usuario.mail === null ||
			usuario.fechaNacimiento === null || usuario.direccion === null)
			throw new BusinessException("Usuario no valido")
	}

}
