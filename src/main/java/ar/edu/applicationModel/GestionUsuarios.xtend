package ar.edu.applicationModel

import ar.edu.conversionActualizacion.ConversionJson
import ar.edu.main.StubUpdateService
import ar.edu.repositorios.RepositorioUsuarios
import ar.edu.usuarios.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class GestionUsuarios  {

	Usuario usuarioSeleccionado

	def crear(Usuario unUsuario) {
		repositorio.create(unUsuario)
	}

	@Dependencies("usuarioSeleccionado")
	def eliminar() {
		repositorio.delete(usuarioSeleccionado)
	}

	@Dependencies("usuarioSeleccionado")
	def actualizar() {
		repositorio.update(usuarioSeleccionado)
		//ObservableUtils.firePropertyChanged(this, "elementos")

	}

	def updateMasivo() {
		val repoUsuarios = repositorio
		repoUsuarios.updateService = new StubUpdateService
		repoUsuarios.conversion = new ConversionJson
		repoUsuarios.updateAll
	}

	def RepositorioUsuarios getRepositorio() {
		ApplicationContext.instance.getSingleton(typeof(Usuario)) as RepositorioUsuarios
	}
}
