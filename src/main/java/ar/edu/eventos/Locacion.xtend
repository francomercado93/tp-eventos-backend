package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional
import org.uqbar.geodds.Point
import com.fasterxml.jackson.annotation.JsonIgnore

@Transactional
@Observable
@Accessors
class Locacion {

	int id = -1
	String descripcion
	@JsonIgnore Point puntoGeografico
	@JsonIgnore double superficie
	@JsonIgnore double capacidad

	new() {
	}

	new(String desc) {
		descripcion = desc
	}

	def double distancia(Point unPunto) {
		puntoGeografico.distance(unPunto)
	}

	@Dependencies("superficie")
	def calcularCapacidad(double espacionNecesarioPorPersona) {
		capacidad = Math.round(superficie / espacionNecesarioPorPersona)
	}

}
