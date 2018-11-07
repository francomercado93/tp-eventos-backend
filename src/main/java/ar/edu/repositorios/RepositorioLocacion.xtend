package ar.edu.repositorios

import ar.edu.eventos.Locacion
import ar.edu.eventos.exceptions.BusinessException

class RepositorioLocacion extends Repositorio<Locacion> {

	override create(Locacion locacion) {
		if (!lista.exists[loc|loc.descripcion.equals(locacion.descripcion)]) {
			this.validarCampos(locacion)
			this.asignarId(locacion)
			super.create(locacion)
		}
	}

	override validarCampos(Locacion locacion) {
		if (locacion.descripcion === null || locacion.puntoGeografico === null)
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
		this.actualizarElemento(locacion)
	}

	override busquedaPorNombre(Locacion locacion, String string) {
		locacion.descripcion.indexOf(string) != -1
	}

	override actualizarElemento(Locacion locacion) {
		var locacionRepo = search(locacion.descripcion).get(0)
		if (!locacion.descripcion.equals(locacionRepo.descripcion))
			locacionRepo.descripcion = locacion.descripcion
		if (!locacion.puntoGeografico.equals(locacionRepo.puntoGeografico))
			locacionRepo.puntoGeografico = locacion.puntoGeografico
	}

	override updateAll() {
		getDatosACtualizados()
		conversion.locaciones.forEach(locacion|create(locacion))
		conversion.locaciones.forEach(locacion|update(locacion))
	}

	override getDatosACtualizados() {
		conversion.conversionJsonLocaciones(updateService.getLocationUpdates)
	}
}
