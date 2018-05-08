package ar.edu.repositorios

import ar.edu.eventos.Locacion
import ar.edu.eventos.exceptions.BusinessException
import ar.edu.servicios.Servicios
import ar.edu.usuarios.Usuario
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Repositorio<T> {
	
	Set<T> lista = newHashSet
	
	def void create(T elemento)
		
	def void delete(T elemento)
	
	def void update(T elemento)
	
	def T searchById(int id){
		lista.get(id)
	}
	
	def Set<T> search(String value)
}

class RepositorioUsuarios extends Repositorio<Usuario> {
	

	override create(Usuario usuario) {		
		/*var Usuario aux = search(usuario.nombreUsuario).get(0)
		if(aux !== null)
			throw new BusinessException("No se puede agregar dos veces al mismo usuario")*/
		usuario.validarCampos()
		lista.add(usuario)
	}
	
	override delete(Usuario usuario){
		lista.remove(usuario)
	}
	
	override update(Usuario usuario){
		var Usuario aux = search(usuario.nombreUsuario).get(0)
		if(aux === null)
			throw new BusinessException("No se encontro usuario")
		else
			this.delete(aux)
			usuario.validarCampos()
			lista.add(usuario)
	}
	
	override search(String string){	
		lista.filter(usuario | this.busquedaPorNombre(usuario, string)).toSet
	}
	
	def boolean busquedaPorNombre(Usuario usuario, String string){
		usuario.nombreUsuario.equals(string) || usuario.nombreApellido.indexOf(string) != -1
	}
	
}

class RepositorioLocacion extends Repositorio<Locacion>{
	
	override create(Locacion locacion) {
		locacion.validarCampos()
		lista.add(locacion)
	}
	
	override delete(Locacion locacion){
		lista.remove(locacion)
	}
	
	override update(Locacion locacion){
		var Locacion aux = search(locacion.descripcion).get(0)
		if(aux === null)
			throw new BusinessException("No se encontro usuario")
		else
			//aux.editar()
			//aux.validarCampos
			this.delete(aux)
			locacion.validarCampos()
			lista.add(locacion)
	}
	
	override search(String string){		//???
		lista.filter(locacion | busquedaPorNombre(locacion, string)).toSet
	}
	
	def boolean busquedaPorNombre(Locacion locacion, String string){
		locacion.descripcion.indexOf(string) != -1
	}

}


class RepositorioServicio extends Repositorio <Servicios> {
	
	override create(Servicios servicio) {
		servicio.validarCampos()
		lista.add(servicio)
	}
	
	override delete(Servicios servicio){
		lista.remove(servicio)
	}
	
	override update(Servicios servicio){
		var Servicios aux = search(servicio.descripcion).get(0)
		if(aux === null)
			throw new BusinessException("No se encontro usuario")
		else
			//aux.editar()
			//aux.validarCampos
			this.delete(aux)
			servicio.validarCampos()
			lista.add(servicio)
	}
	
	override search(String string){		//???
		lista.filter(servicio | busquedaPorNombre(servicio, string)).toSet
	}
	
	def boolean busquedaPorNombre(Servicios servicio, String string){
		servicio.descripcion.startsWith(string)
	}

	
}
