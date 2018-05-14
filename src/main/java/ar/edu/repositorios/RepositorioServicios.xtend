package ar.edu.repositorios

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.servicios.Servicios

class RepositorioServicios extends Repositorio<Servicios> {

	override create(Servicios servicio) {
		if (this.validarCampos(servicio))
			throw new BusinessException("Servicio no valido")
		this.asignarId(servicio)
		lista.add(servicio)
	}
	
	override asignarId(Servicios servicio) {
		if(servicio.id == -1){
			servicio.id = id
			id = id + 1
		}	
	}

	override Servicios searchById(int id){
		lista.findFirst(servicio | servicio.id == id)
	}
	
	override validarCampos(Servicios servicio) {
		servicio.descripcion === null || servicio.ubicacionServicio === null || servicio.tipoTarifa === null
	}

	override delete(Servicios servicio) {
		lista.remove(servicio)
	}

	override update(Servicios servicio) {
		if (this.search(servicio.descripcion).isEmpty)
			throw new BusinessException("No se encontro servicio")
		servicio.id = this.search(servicio.descripcion).get(0).id
		this.delete(search(servicio.descripcion).get(0))
		this.create(servicio)
	}

	override search(String nombre) {
		lista.filter(servicio|this.busquedaPorNombre(servicio, nombre)).toList
	}

	def boolean busquedaPorNombre(Servicios servicio, String nombre) {
		servicio.descripcion.startsWith(nombre)
	}
	

}
