/*package ar.edu.servicios

import ar.edu.eventos.Evento
import java.util.List

class ServicioMultiple extends Servicios{
	List<Servicios> subservicios
	
	override costo(Evento evento) {
		costoTotalSubserviciosConDescuento(evento) + costoTraslado(evento)
	}
	
	def costoTotalSubserviciosConDescuento(Evento evento) {
		subservicios.fold(0d, [acum, servicio|acum + servicio.costo(evento)])
	}
	
	override costoTraslado(Evento evento){
		subservicios.maxBy[servicio | servicio.costoTraslado(evento)].costoTraslado(evento)
	}

}*/