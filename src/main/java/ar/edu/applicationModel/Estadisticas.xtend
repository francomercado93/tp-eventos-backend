package ar.edu.applicationModel

import ar.edu.repositorios.RepositorioUsuarios
import ar.edu.usuarios.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Estadisticas {
//	RepositorioUsuarios repoUsuarios 
	
	List<Usuario> usuarios 
	
//	new (){
//		repoUsuarios = new RepositorioUsuarios
//	}
	
	def getCantidadTotalEventosOrganizados() {
		21
		//usuarios.fold(0d, [acum, usr|acum + usr.cantidadTotalEventosOrganizados()])
	}

	def getCantidadEventosUltimoMes() {
		5
		//usuarios.fold(0d, [acum, usr|acum + usr.cantidadEventosOrganizadosMes()])
	}

	def getCantidadEventosExitosos() {
		56
		//usuarios.fold(0d, [acum, usr|acum + usr.cantidadEventosExitosos()])
	}

	def getCantidadEventosFracasados() {
		9
		//usuarios.fold(0d, [acum, usr|acum + usr.cantidadEventosFracasados()])
	}
	
	def getCantidadEntradasVendidas(){
		4
		//usuarios.fold(0d, [acum, usr|acum + usr.cantidadEntradasVendidas()])
	}
	
	def getCantidadInvitacionesEnviadas(){
		6
		//usuarios.fold(0d, [acum, usr|acum + usr.cantidadInvitacionesEnviadas()])
	}
	
	def getUsuariosMasActivos(){
		usuarios.sortBy[usr | usr.cantidadActividad]
	}
	
	def getTopUsuariosMasActivos(){
		val topUsuariosMasActivos = newArrayList
		topUsuariosMasActivos.add(this.getUsuariosMasActivos.get(0))
		topUsuariosMasActivos.add(this.getUsuariosMasActivos.get(1))
		topUsuariosMasActivos.add(this.getUsuariosMasActivos.get(2))
		topUsuariosMasActivos.add(this.getUsuariosMasActivos.get(3))
		topUsuariosMasActivos.add(this.getUsuariosMasActivos.get(4))
		topUsuariosMasActivos
	}
}
