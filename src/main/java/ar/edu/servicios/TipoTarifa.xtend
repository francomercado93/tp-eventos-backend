package ar.edu.servicios

import ar.edu.eventos.Evento
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class TipoTarifa {

	double costoFijo
	new(){
		
	}

	new(double unCostoFijo) {
		costoFijo = unCostoFijo
	}

	def double costo(Evento evento)

	def double tarifaMinima(Evento evento) {
		costoFijo
	}

	def String getDescripcion()
	
	def String getDescripcionCorta()
}
