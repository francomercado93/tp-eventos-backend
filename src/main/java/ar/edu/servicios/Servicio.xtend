package ar.edu.servicios

import ar.edu.eventos.Evento
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.geodds.Point

@TransactionalAndObservable
@Accessors
class Servicio {

	int id = -1
	TipoTarifa tipoTarifa
	double tarifaPorKilometro
	Point ubicacionServicio
	String descripcion
	Double nuevaTarifa
	Double coordX
	Double coordY

	def double costo(Evento evento) {
		tipoTarifa.costo(evento) + this.costoTraslado(evento)
	}

	def costoTraslado(Evento evento) {
		tarifaPorKilometro * evento.distancia(ubicacionServicio)
	}

	def getTiposPosibles() {
		#[new TarifaFija, new TarifaPersona, new TarifaPorHora]
	}
	
	def setNuevaTarifa(Double tarifa){
		nuevaTarifa = tarifa
		this.setNuevaTarifaTipoTarifa
	}
	
	def void setNuevaTarifaTipoTarifa(){
		tipoTarifa.costoFijo = nuevaTarifa
	}
	
	def setUbicacionServicio(){
		ubicacionServicio  = new Point(coordX, ubicacionServicio.y)
	}
	
	def void setCoordX(Double coordenada){
		coordX = coordenada
		this.setUbicacionServicio
	}
	
	def Double getCoordX(){
		coordX = ubicacionServicio.x
		coordX
	}
}	
