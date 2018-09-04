package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional
import org.uqbar.geodds.Point

@Transactional
@Observable
@Accessors
class Locacion {

	int id = -1
	String descripcion
	Point puntoGeografico
	double superficie

	def double distancia(Point unPunto) {
		puntoGeografico.distance(unPunto)
	}
	
//	def actualizarCoordenadas(Double x,Double y){
//		puntoGeografico=new Point(x,y)
//	}
	
}
