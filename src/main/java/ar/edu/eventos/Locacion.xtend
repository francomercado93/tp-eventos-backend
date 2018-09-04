package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.geodds.Point

@Observable
@Accessors
class Locacion {

	int id = -1
	String descripcion
	Point puntoGeografico
	Double coordenadaX
	Double coordenadaY
	double superficie

	def double distancia(Point unPunto) {
		puntoGeografico.distance(unPunto)
	}
	
	@Dependencies("CoordenadaY","coordenadaX")
	def getPuntoGeograficos(){
		coordenadaX +""+ coordenadaY
	}
	
	def actualizarCoordenadas(Double x,Double y){
		puntoGeografico=new Point(x,y)
	}
	
}
