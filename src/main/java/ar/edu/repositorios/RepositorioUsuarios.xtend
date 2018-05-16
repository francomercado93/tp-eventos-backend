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
		if (search(usrActualizado.nombreUsuario).isEmpty)
			throw new BusinessException("No se encontro el usuario " + usrActualizado.nombreUsuario)

		this.actualizarElemento(usrActualizado)
	}
	
	override actualizarElemento(Usuario usrActualizado) {
		var usrRepo = search(usrActualizado.nombreUsuario).get(0)
		if(!usrActualizado.nombreApellido.equals(usrRepo.nombreApellido))
			usrRepo.nombreApellido = usrActualizado.nombreApellido
		if(!usrActualizado.mail.equals(usrRepo.mail))
			usrRepo.mail = usrActualizado.mail
		if(!usrActualizado.fechaNacimiento.equals(usrRepo.fechaNacimiento))
			usrRepo.fechaNacimiento = usrActualizado.fechaNacimiento
		if(!usrActualizado.direccion.calle.equals(usrRepo.direccion.calle))
			usrRepo.direccion.calle = usrActualizado.direccion.calle
		if(!(usrActualizado.direccion.numero == (usrRepo.direccion.numero)))
			usrRepo.direccion.numero = usrActualizado.direccion.numero
		if(!usrActualizado.direccion.localidad.equals(usrRepo.direccion.localidad))
			usrRepo.direccion.localidad = usrActualizado.direccion.localidad
		if(!usrActualizado.direccion.provincia.equals(usrRepo.direccion.provincia))
			usrRepo.direccion.provincia = usrActualizado.direccion.provincia
		if(!usrActualizado.direccion.coordenadas.equals(usrRepo.direccion.coordenadas))
			usrRepo.direccion.coordenadas = usrActualizado.direccion.coordenadas
	
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
