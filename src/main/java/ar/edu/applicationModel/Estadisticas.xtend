package ar.edu.applicationModel

import ar.edu.eventos.Evento
import ar.edu.repositorios.RepositorioUsuarios
import ar.edu.usuarios.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Estadisticas {

	def RepositorioUsuarios getRepoUsuarios() {
		ApplicationContext.instance.getSingleton(typeof(Usuario))
	}

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
		usrActivos
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
