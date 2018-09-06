
package ar.edu.repositorios

import ar.edu.conversionActualizacion.ConversionJson
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.updateService.UpdateService

@TransactionalAndObservable
@Accessors
abstract class Repositorio<T> {

	int id = 0
	List<T> lista = new ArrayList<T>()
	UpdateService updateService 
	ConversionJson conversion = new ConversionJson
	
	def void create(T elemento) {
		lista.add(elemento)
	}

	def void delete(T elemento) {
		lista.remove(elemento)
	}

	def void update(T elemento)

	def T searchById(int id)

	def List<T> search(String value) {
		lista.filter(elemento|this.busquedaPorNombre(elemento, value)).toList
	}

	def boolean busquedaPorNombre(T elemento, String value)

	def void asignarId(T elemento)

	def void validarCampos(T elemento)

	def void actualizarElemento(T elemento)

	def void updateAll()

	def void getDatosACtualizados()

}
