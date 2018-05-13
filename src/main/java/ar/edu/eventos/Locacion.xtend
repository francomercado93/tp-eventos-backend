package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Locacion {

	int id = -1
	String descripcion
	Point puntoGeografico
	double superficie

	def double distancia(Point unPunto) {
		puntoGeografico.distance(unPunto)
	}
}
