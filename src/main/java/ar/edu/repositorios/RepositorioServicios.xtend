package ar.edu.repositorios

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.servicios.Servicios

class RepositorioServicios extends Repositorio<Servicios> {

	override create(Servicios servicio) {
		servicio.validarCampos()
		lista.add(servicio)
	}

	override delete(Servicios servicio) {
		lista.remove(servicio)
	}

	override update(Servicios servicio) {
		var Servicios aux = search(servicio.descripcion).get(0)
		if (aux === null)
			throw new BusinessException("No se encontro usuario")
		else
			// aux.editar()
			// aux.validarCampos
			this.delete(aux)
		servicio.validarCampos()
		lista.add(servicio)
	}

	override search(String string) { // ???
		lista.filter(servicio|busquedaPorNombre(servicio, string)).toSet
	}

	def boolean busquedaPorNombre(Servicios servicio, String string) {
		servicio.descripcion.startsWith(string)
	}

}
