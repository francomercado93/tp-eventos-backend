package ar.edu.servicios

import ar.edu.eventos.Evento
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ServicioMultiple extends Servicio {

	List<Servicio> subservicios = newArrayList
	double porcentajeDescuento = 0

	override costo(Evento evento) {
		costoTotalSubserviciosConDescuento(evento) + costoTraslado(evento)
	}

	def double costoTotalSubserviciosConDescuento(Evento evento) {
		subservicios.fold(0d, [acum, servicio|acum + servicio.costo(evento)]) * (1 - porcentajeDescuento)
	}

	override costoTraslado(Evento evento) {
		subservicioConMayorCostoTraslado(evento).costoTraslado(evento)
	}

	def Servicio subservicioConMayorCostoTraslado(Evento evento) {
		subservicios.maxBy[servicio|servicio.costoTraslado(evento)]
	}

	def agregarSubservicio(Servicio servicio) {
		subservicios.add(servicio)
	}
}
