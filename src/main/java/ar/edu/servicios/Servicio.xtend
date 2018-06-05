package ar.edu.servicios

import ar.edu.eventos.Evento
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

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
}