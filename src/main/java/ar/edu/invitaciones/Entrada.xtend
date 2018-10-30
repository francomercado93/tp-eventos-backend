package ar.edu.invitaciones

import ar.edu.eventos.EventoAbierto
import ar.edu.usuarios.Usuario
import com.fasterxml.jackson.annotation.JsonIgnore

class Entrada {
	EventoAbierto evento
	@JsonIgnore Usuario asistente

	new(Usuario asistente, EventoAbierto unEvento) {
		this.asistente = asistente
		this.evento = unEvento
	}
}
