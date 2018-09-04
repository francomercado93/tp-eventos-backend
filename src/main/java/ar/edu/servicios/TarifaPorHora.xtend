package ar.edu.servicios

import ar.edu.eventos.Evento
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class TarifaPorHora extends TipoTarifa {
	
	double tarifaPorHora
	
	new (double unCostoFijo, double unaTarifaPorHora){
		super(unCostoFijo)
		tarifaPorHora = unaTarifaPorHora
	}
	
	override costo (Evento evento){
		this.tarifaMinima(evento) + this.costoTotalPorHora(evento) 
	}
	
	def costoTotalPorHora(Evento evento) {
		evento.duracion * tarifaPorHora
	}
	
	override getDescripcion() {
		"Tarifa por hora"
	}
	

	
}
