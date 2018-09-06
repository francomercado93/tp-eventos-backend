package ar.edu.applicationModel

import ar.edu.eventos.Evento
import ar.edu.repositorios.RepositorioUsuarios
import ar.edu.usuarios.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@Accessors
@TransactionalAndObservable
class Estadisticas {
	
	//List<Usuario> usuarios
	
	def RepositorioUsuarios getRepoUsuarios(){
		ApplicationContext.instance.getSingleton(typeof(Usuario))	
	}
	
	def getUsuarios(){
		repoUsuarios.lista
	}	
	
	def getCantidadTotalEventosOrganizados() {
		this.eventosOrganizados.size
	}

	def getCantidadEventosUltimoMes() {
		usuarios.fold(0d, [acum, usr|acum + usr.cantidadEventosOrganizadosMes()])
	}

	def getCantidadEventosExitosos() {
		this.eventosOrganizados.filter[esExitoso].size
	}

	def getCantidadEventosFracasados() {
		this.eventosOrganizados.filter[esFracaso].size
	}
	
	def getCantidadEntradasVendidas(){
		usuarios.fold(0d, [acum, usr|acum + usr.getCantidadEntradasCompradas()])
	}
	
	def getCantidadInvitacionesEnviadas(){
		usuarios.fold(0d, [acum, usr|acum + usr.cantidadInvitaciones()])
	}
	@Dependencies("usuarios")
	def getUsuariosMasActivos(){
		usuarios.sortBy[usr | usr.cantidadActividad].take(5).toList	
		//ObservableUtils.firePropertyChanged(typeof(Estadisticas), "usuarios")
	
	}
	
	def getLocacionesMasPopulares() {
		this.eventosOrganizados.map[locacion]
	}
	
	def List<Evento> getEventosOrganizados() {
		usuarios.map[eventosOrganizados].flatten().toList
	}
	
	def getUltimosServiciosDadosDeAlta(){
		this.eventosOrganizados.map[serviciosContratados].flatten().toSet
	}
}
