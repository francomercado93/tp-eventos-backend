package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.geodds.Point

@Accessors
@Observable
class Locacion {

	int id = -1
	String descripcion
	Point puntoGeografico
	double superficie
	double capacidad

	def double distancia(Point unPunto) {
		puntoGeografico.distance(unPunto)
	}
	@Dependencies("superficie")
	def calcularCapacidad(double espacionNecesarioPorPersona) {
		capacidad = Math.round(superficie / espacionNecesarioPorPersona) 
	}
	
}
