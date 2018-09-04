package ar.edu.applicationModel

import ar.edu.conversionActualizacion.ConversionJson
import ar.edu.main.StubUpdateService
import ar.edu.repositorios.RepositorioServicios
import ar.edu.servicios.Servicio
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class GestionServicios {

	Servicio servicioSeleccionado
	
	def crear(Servicio unServicio) {
		repositorio.create(unServicio)
	}

	def eliminar() {
		repositorio.delete(servicioSeleccionado)
	}

	def actualizar() {
		repositorio.update(servicioSeleccionado)
	}

	def updateMasivo() {
		val repoServicios = repositorio
		repoServicios.updateService = new StubUpdateService
		repoServicios.conversion = new ConversionJson
		repoServicios.updateAll
	}

	def RepositorioServicios getRepositorio() {
		ApplicationContext.instance.getSingleton(typeof(Servicio)) as RepositorioServicios
	}

}
