package ar.edu.servicios

import ar.edu.eventos.Evento
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class TarifaFija extends TipoTarifa {

	new(double unCostoFijo) {
		super(unCostoFijo)
	}

	override costo(Evento evento) {
		this.tarifaMinima(evento)
	}

}
