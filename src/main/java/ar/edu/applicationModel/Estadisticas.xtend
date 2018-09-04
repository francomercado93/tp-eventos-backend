package ar.edu.applicationModel

import ar.edu.eventos.Evento
import ar.edu.eventos.Locacion
import ar.edu.repositorios.RepositorioUsuarios
import ar.edu.usuarios.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Estadisticas {
	
	List<Usuario> usuarios 
	
	def RepositorioUsuarios getRepoUsuarios(){
		ApplicationContext.instance.getSingleton(typeof(Usuario))	
	}
	
	def getUsuarios(){
		usuarios = repoUsuarios.lista
	}	
	
	def getCantidadTotalEventosOrganizados() {
		usuarios.fold(0d, [acum, usr|acum + usr.cantidadTotalEventosOrganizados()])
	}

	def getCantidadEventosUltimoMes() {
		usuarios.fold(0d, [acum, usr|acum + usr.cantidadEventosOrganizadosMes()])
	}

	def getCantidadEventosExitosos() {
		usuarios.fold(0d, [acum, usr|acum + usr.cantidadEventosExitosos()])
	}

	def getCantidadEventosFracasados() {
		usuarios.fold(0d, [acum, usr|acum + usr.cantidadEventosFracasados()])
	}
	
	def getCantidadEntradasVendidas(){
		usuarios.fold(0d, [acum, usr|acum + usr.getCantidadEntradasCompradas()])
	}
	
	def getCantidadInvitacionesEnviadas(){
		usuarios.fold(0d, [acum, usr|acum + usr.cantidadInvitaciones()])
	}
	
	def List<Usuario> getUsuariosMasActivos(){
		usuarios.sortBy[usr | usr.cantidadActividad].take(5).toList	
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
