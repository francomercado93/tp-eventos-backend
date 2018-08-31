package ar.edu.applicationModel

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
	
//	def getUsuariosMasActivos(){
//		usuarios.sortBy[usr | usr.cantidadActividad]
//	}
//	
//	def getTopUsuariosMasActivos(){
//		val topUsuariosMasActivos = newArrayList
//		topUsuariosMasActivos.add(this.getUsuariosMasActivos.get(0))
//		topUsuariosMasActivos.add(this.getUsuariosMasActivos.get(1))
//		topUsuariosMasActivos.add(this.getUsuariosMasActivos.get(2))
//		topUsuariosMasActivos.add(this.getUsuariosMasActivos.get(3))
//		topUsuariosMasActivos.add(this.getUsuariosMasActivos.get(4))
//		topUsuariosMasActivos
//	}
}
