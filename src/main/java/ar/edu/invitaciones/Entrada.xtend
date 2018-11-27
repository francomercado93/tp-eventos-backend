package ar.edu.invitaciones

import ar.edu.eventos.EventoAbierto
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity

@Accessors
class Entrada extends Entity {
	EventoAbierto evento
	int cantidad

	new(int cantidad, EventoAbierto unEvento, int id) {
		this.cantidad = cantidad
		this.evento = unEvento
		this.id = id
	}

	new(EventoAbierto unEvento, int id) {
		this.evento = unEvento
		this.id = id
	}
	new() {
		this.evento = new EventoAbierto()
		this.id = 0
	}
}
