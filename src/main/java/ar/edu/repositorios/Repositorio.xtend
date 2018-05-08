package ar.edu.repositorios

import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Repositorio<T> {

	Set<T> lista = newHashSet

	def void create(T elemento)

	def void delete(T elemento)

	def void update(T elemento)

	def T searchById(int id) {
		lista.get(id)
	}

	def Set<T> search(String value)
}
