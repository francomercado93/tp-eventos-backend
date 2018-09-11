package ar.edu.applicationModel

import ar.edu.eventos.Evento
import ar.edu.repositorios.RepositorioUsuarios
import ar.edu.usuarios.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.utils.ObservableUtils

@Accessors
@Observable
class Estadisticas {

//	List<Usuario> usuarios
	
	def RepositorioUsuarios getRepoUsuarios() {
		ApplicationContext.instance.getSingleton(typeof(Usuario))
	}

//	def getUsuarios() {
//		repoUsuarios.lista
//	}

	def getCantidadTotalEventosOrganizados() {
		this.eventosOrganizados.size
	}

	def getCantidadEventosUltimoMes() {
		repoUsuarios.lista.fold(0d, [acum, usr|acum + usr.cantidadEventosOrganizadosMes()])
	}

	def getCantidadEventosExitosos() {
		this.eventosOrganizados.filter[esExitoso].size
	}

	def getCantidadEventosFracasados() {
		this.eventosOrganizados.filter[esFracaso].size
	}

	def getCantidadEntradasVendidas() {
		repoUsuarios.lista.fold(0d, [acum, usr|acum + usr.getCantidadEntradasCompradas()])
	}

	def getCantidadInvitacionesEnviadas() {
		repoUsuarios.lista.fold(0d, [acum, usr|acum + usr.cantidadInvitaciones()])
	}

	
	def getUsuariosMasActivos() {
		val usrActivos = repoUsuarios.lista
	//	ObservableUtils.firePropertyChanged(this, "repoUsuarios")
		usrActivos
//		usuarios.sortBy[usr|usr.cantidadActividad].take(5).toList
		//repoUsuarios.lista.take(2).toList
	}

	def getLocacionesMasPopulares() {
		this.eventosOrganizados.map[locacion]
	}

	def List<Evento> getEventosOrganizados() {
		repoUsuarios.lista.map[eventosOrganizados].flatten().toList
	}

	def getUltimosServiciosDadosDeAlta() {
		this.eventosOrganizados.map[serviciosContratados].flatten().toSet
	}
}
