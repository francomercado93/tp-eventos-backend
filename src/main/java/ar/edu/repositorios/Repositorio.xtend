package ar.edu.repositorios

import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Repositorio<T> {
	
	var int id = 0
	Set<T> lista = newHashSet

	def void create(T elemento){
		lista.add(elemento)
	}

	def void delete(T elemento){
		lista.remove(elemento)
	}

	def void update(T elemento)

	def T searchById(int id)

	def List<T> search(String value){
		lista.filter(elemento|this.busquedaPorNombre(elemento, value)).toList
	}
	
	def boolean busquedaPorNombre(T elemento, String value)
	
	def void asignarId(T elemento)
	
	def void validarCampos(T elemento)
}
