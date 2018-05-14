package ar.edu.main

import ar.edu.eventos.Locacion
import ar.edu.repositorios.RepositorioLocacion
import ar.edu.repositorios.RepositorioServicios
import ar.edu.repositorios.RepositorioUsuarios
import ar.edu.servicios.Servicios
import ar.edu.usuarios.Usuario
import java.util.Set

class Actualizaciones {
	
	def actualizarRepositorioUsuarios(Set<Usuario> usuarios, RepositorioUsuarios repo){
		usuarios.forEach(usuario | repo.create(usuario))
		usuarios.forEach(usuario | repo.update(usuario))
	}
	
	def actualizarRepositorioServicios(Set<Servicios> servicios, RepositorioServicios repo){
		servicios.forEach( servicio | repo.create(servicio))
		servicios.forEach( servicio | repo.update(servicio))
	}
	
	def actualizarRepositorioLocaciones(Set<Locacion> locaciones, RepositorioLocacion repo){
		locaciones.forEach( locacion | repo.create(locacion))
		locaciones.forEach( locacion | repo.update(locacion))
	}
}