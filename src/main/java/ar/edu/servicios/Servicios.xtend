package ar.edu.servicios

import ar.edu.eventos.Evento
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import ar.edu.eventos.exceptions.BusinessException

@Accessors
class Servicios {

	TipoTarifa tipoTarifa
	double tarifaPorKilometro
	Point ubicacionServicio
	String descripcion
	
	def validarCampos(){
		if(descripcion === null)
			throw new BusinessException("Falta nombre/descripcion del servicio")
		if(ubicacionServicio === null)
			throw new BusinessException("Falta ubicacion del servicio")
		if(tipoTarifa === null)
			throw new BusinessException("Error el servicio debe tener un tipo de tarifa")
	}
	def double costo(Evento evento) {
		tipoTarifa.costo(evento) + this.costoTraslado(evento)
	}

	def costoTraslado(Evento evento) {
		tarifaPorKilometro * evento.distancia(ubicacionServicio)
	}

}