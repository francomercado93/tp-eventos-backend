package ar.edu.repositorios

import ar.edu.eventos.Locacion
import ar.edu.eventos.exceptions.BusinessException

class RepositorioLocacion extends Repositorio<Locacion> {

	override create(Locacion locacion) {
		locacion.validarCampos()
		lista.add(locacion)
	}

	override delete(Locacion locacion) {
		lista.remove(locacion)
	}

	override update(Locacion locacion) {
		var Locacion aux = search(locacion.descripcion).get(0)
		if (aux === null)
			throw new BusinessException("No se encontro usuario")
		else
			// aux.editar()
			// aux.validarCampos
			this.delete(aux)
		locacion.validarCampos()
		lista.add(locacion)
	}

	override search(String string) { // ???
		lista.filter(locacion|busquedaPorNombre(locacion, string)).toSet
	}

	def boolean busquedaPorNombre(Locacion locacion, String string) {
		locacion.descripcion.indexOf(string) != -1
	}

}
