package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Locacion {

	int id
	String descripcion
	Point puntoGeografico
	double superficie

	def double distancia(Point unPunto) {
		puntoGeografico.distance(unPunto)
	}

	def validarCampos() {
		if (descripcion === null)
			throw new BusinessException("Error, falta nombre de la locacion")

		if (puntoGeografico === null)
			throw new BusinessException("Error")
	}
}
