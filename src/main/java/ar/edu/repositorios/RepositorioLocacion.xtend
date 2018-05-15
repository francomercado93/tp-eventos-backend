package ar.edu.repositorios

import ar.edu.eventos.Locacion
import ar.edu.eventos.exceptions.BusinessException

class RepositorioLocacion extends Repositorio<Locacion> {

	override create(Locacion locacion) {
		this.validarCampos(locacion)
		this.asignarId(locacion)
		super.create(locacion)
	}

	override validarCampos(Locacion locacion) {
		if(locacion.descripcion === null || locacion.puntoGeografico === null)
			throw new BusinessException("Locacion no valido")
	}

	override asignarId(Locacion locacion) {
		if (locacion.id == -1) {
			locacion.id = id
			id = id + 1
		}
	}

	override Locacion searchById(int id) {
		lista.findFirst(locacion|locacion.id == id)
	}

	override update(Locacion locacion) {
		if (search(locacion.descripcion).isEmpty)
			throw new BusinessException("No se encontro locacion " + locacion.descripcion)
		locacion.id = search(locacion.descripcion).get(0).id
		this.delete(search(locacion.descripcion).get(0)) // Si lo encuentra elimina el anterior objeto  del repo y agrega el nuevo
		this.create(locacion)
	}

	override busquedaPorNombre(Locacion locacion, String string) {
		locacion.descripcion.indexOf(string) != -1
	}

}
