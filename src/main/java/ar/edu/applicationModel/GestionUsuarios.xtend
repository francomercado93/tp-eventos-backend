package ar.edu.applicationModel

import ar.edu.conversionActualizacion.ConversionJson
import ar.edu.main.StubUpdateService
import ar.edu.repositorios.RepositorioUsuarios
import ar.edu.usuarios.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@Accessors
@TransactionalAndObservable
class GestionUsuarios {

	Usuario usuarioSeleccionado //= new Usuario
	
	def getUsuarios(){
		repositorio.lista
	}
	
	def crear(Usuario unUsuario) {
		repositorio.create(unUsuario)
	}
	@Dependencies("usuarioSeleccionado")
	def eliminar() {
		repositorio.delete(usuarioSeleccionado)
		
	}

	def actualizar() {
		println(usuarioSeleccionado.tipoUsuario.descripcion)
		repositorio.update(usuarioSeleccionado)
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
