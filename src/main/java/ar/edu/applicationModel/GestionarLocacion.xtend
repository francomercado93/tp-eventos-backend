package ar.edu.applicationModel

import ar.edu.conversionActualizacion.ConversionJson
import ar.edu.eventos.Locacion
import ar.edu.main.StubUpdateService
import ar.edu.repositorios.RepositorioLocacion
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class GestionarLocacion {
	
	Locacion locacionSeleccionada

	def crear(Locacion unaLocacion) {
		repositorio.create(unaLocacion)
	}

	def eliminar() {
		repositorio.delete(locacionSeleccionada)
	}

	def actualizar() {
		repositorio.update(locacionSeleccionada)
	}

	def updateMasivo() {
		val repoLocaciones = repositorio
		repoLocaciones.updateService = new StubUpdateService
		repoLocaciones.conversion = new ConversionJson
		repoLocaciones.updateAll
	}

	def RepositorioLocacion getRepositorio() {
		ApplicationContext.instance.getSingleton(typeof(Locacion)) as RepositorioLocacion
	}
}
