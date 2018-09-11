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
	
//	
//	new(){
//		 coordX = ubicacionServicio.x
//		 coordY= ubicacionServicio.y
//	}
	def double costo(Evento evento) {
		tipoTarifa.costo(evento) + this.costoTraslado(evento)
	}

	def costoTraslado(Evento evento) {
		tarifaPorKilometro * evento.distancia(ubicacionServicio)
	}

	def getTiposPosibles() {
		#[new TarifaFija(0), new TarifaPersona(0, 0), new TarifaPorHora(0, 0)]
	}
	
	def getCoordenadaX(){
		ubicacionServicio.x
	}	
	
	def getCoordenadaY(){
		ubicacionServicio.y
	}
	
//	def cambiarUbicacion(double x, double y){
//		ubicacionServicio.(x, y)
//	}
	
}	
