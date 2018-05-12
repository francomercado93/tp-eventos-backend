package ar.edu.repositorios

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.servicios.Servicios

class RepositorioServicios extends Repositorio<Servicios> {

	override create(Servicios servicio) {
		if (this.validarCampos(servicio))
			throw new BusinessException("Servicio no valido")
		lista.add(servicio)
	}

	def boolean validarCampos(Servicios servicio) {
		servicio.descripcion === null || servicio.ubicacionServicio === null || servicio.tipoTarifa === null
	}

	override delete(Servicios servicio) {
		lista.remove(servicio)
	}

	override update(Servicios servicio) {
		if (search(servicio.descripcion).isEmpty)
			throw new BusinessException("No se encontro servicio")
		this.delete(search(servicio.descripcion).get(0))
		this.create(servicio)
	}

	override search(String nombre) {
		lista.filter(servicio|this.busquedaPorNombre(servicio, nombre)).toSet
	}

	def boolean busquedaPorNombre(Servicios servicio, String nombre) {
		servicio.descripcion.startsWith(nombre)
	}

}
