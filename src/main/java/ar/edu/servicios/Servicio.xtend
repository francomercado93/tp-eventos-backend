package ar.edu.servicios

import ar.edu.eventos.Evento
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional
import org.uqbar.geodds.Point

@Transactional
@Observable
@Accessors
class Servicio {

	int id = -1
	TipoTarifa tipoTarifa
	double tarifaPorKilometro
	Point ubicacionServicio
	String descripcion

	def double costo(Evento evento) {
		tipoTarifa.costo(evento) + this.costoTraslado(evento)
	}

	def costoTraslado(Evento evento) {
		tarifaPorKilometro * evento.distancia(ubicacionServicio)
	}
	
	def getTiposPosibles(){
		#[new TarifaFija(5), new TarifaPersona(5, 5), new TarifaPorHora(5, 5) ]
	}	
}