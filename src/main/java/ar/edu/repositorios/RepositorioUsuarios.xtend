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

		this.actualizarElemento(usrActualizado)
	}
	
	override actualizarElemento(Usuario usuario) {
		var usrRepo = search(usuario.nombreUsuario).get(0)
		if(!usuario.nombreApellido.equals(usrRepo.nombreApellido))
			usrRepo.nombreApellido = usuario.nombreApellido
		if(!usuario.mail.equals(usrRepo.mail))
			usrRepo.mail = usuario.mail
		if(!usuario.fechaNacimiento.equals(usrRepo.fechaNacimiento))
			usrRepo.fechaNacimiento = usuario.fechaNacimiento
		if(!usuario.direccion.calle.equals(usrRepo.direccion.calle))
			usrRepo.direccion.calle = usuario.direccion.calle
		if(!(usuario.direccion.numero == (usrRepo.direccion.numero)))
			usrRepo.direccion.numero = usuario.direccion.numero
		if(!usuario.direccion.localidad.equals(usrRepo.direccion.localidad))
			usrRepo.direccion.localidad = usuario.direccion.localidad
		if(!usuario.direccion.provincia.equals(usrRepo.direccion.provincia))
			usrRepo.direccion.provincia = usuario.direccion.provincia
		if(!usuario.direccion.coordenadas.equals(usrRepo.direccion.coordenadas))
			usrRepo.direccion.coordenadas = usuario.direccion.coordenadas
	
	}

	override busquedaPorNombre(Usuario usuario, String nombre) {
		usuario.nombreUsuario.equals(nombre) || usuario.nombreApellido.indexOf(nombre) != -1
	}

	override validarCampos(Usuario usuario) {
		if(usuario.nombreUsuario === null || usuario.nombreApellido === null || usuario.mail === null ||
			usuario.fechaNacimiento === null || usuario.direccion === null)
			throw new BusinessException("Usuario no valido")
	}
	/*override updateAll(ConversionJson json){
		
	}*/

}
