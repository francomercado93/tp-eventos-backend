package ar.edu.servicios

import ar.edu.eventos.Evento
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class TarifaPersona extends TipoTarifa {

	double porcentaje // en decimal

	new(double costoPorPersona, double unPorcentaje) {
		super(costoPorPersona) // costoFijo
		porcentaje = unPorcentaje
	}

	override costo(Evento unevento) {
		this.tarifaMinima(unevento) + this.costoExtra(unevento)
	}

	override tarifaMinima(Evento unevento) {
		(porcentajePersonas(unevento)) * costoFijo
	}

	def double porcentajePersonas(Evento unevento) { // double o int ? 
		unevento.capacidadMaxima() * porcentaje
	}

	def double costoExtra(Evento evento) {
		if (evento.cantidadAsistentesPosibles() > porcentajePersonas(evento))
			(evento.cantidadAsistentesPosibles() - porcentajePersonas(evento)) * costoFijo
		else
			0
	}
}
