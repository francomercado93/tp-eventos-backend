package ar.edu.repositorios

import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Repositorio<T> {
	
	var int id = 0
	Set<T> lista = newHashSet

	def void create(T elemento)

	def void delete(T elemento)

	def void update(T elemento)

	def T searchById(int id)

	def Set<T> search(String value)
	
	def void asignarId(T elemento)
}
