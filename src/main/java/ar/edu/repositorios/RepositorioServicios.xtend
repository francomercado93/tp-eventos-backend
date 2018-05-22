package ar.edu.repositorios

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.servicios.Servicios

class RepositorioServicios extends Repositorio<Servicios> {

	override create(Servicios servicio) {
		if (!lista.exists[serv|serv.descripcion.equals(servicio.descripcion)]) {
			this.validarCampos(servicio)
			this.asignarId(servicio)
			super.create(servicio)
		}
	}

	override asignarId(Servicios servicio) {
		if (servicio.id == -1) {
			servicio.id = id
			id = id + 1
		}
	}

	override Servicios searchById(int id) {
		lista.findFirst(servicio|servicio.id == id)
	}

	override validarCampos(Servicios servicio) {
		if (servicio.descripcion === null || servicio.ubicacionServicio === null || servicio.tipoTarifa === null)
			throw new BusinessException("Servicio no valido")
	}

	override update(Servicios servicio) {
		if (this.search(servicio.descripcion).isEmpty)
			throw new BusinessException("No se encontro servicio")
		this.actualizarElemento(servicio)

	}

	override busquedaPorNombre(Servicios servicio, String nombre) {
		servicio.descripcion.startsWith(nombre)
	}

	override actualizarElemento(Servicios servicio) {
		var servRepo = search(servicio.descripcion).get(0)
		if (!servicio.descripcion.equals(servRepo.descripcion))
			servRepo.descripcion = servicio.descripcion
		if (!servicio.tipoTarifa.equals(servRepo.tipoTarifa))
			servRepo.tipoTarifa = servicio.tipoTarifa
		if (!servicio.tarifaPorKilometro.equals(servRepo.tarifaPorKilometro))
			servRepo.tarifaPorKilometro = servicio.tarifaPorKilometro
		if (!servicio.ubicacionServicio.equals(servRepo.ubicacionServicio))
			servRepo.ubicacionServicio = servicio.ubicacionServicio
	}

	override updateAll() {
		getDatosACtualizados()
		conversion.servicios.forEach(servicio|create(servicio))
		conversion.servicios.forEach(servicio|update(servicio))
	}

	override getDatosACtualizados() {
		conversion.conversionJsonServicios(updateService.getServiceUpdates)
	}
}
