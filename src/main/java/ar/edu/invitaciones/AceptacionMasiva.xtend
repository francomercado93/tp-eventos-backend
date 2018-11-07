package ar.edu.invitaciones

import java.util.Set

class AceptacionMasiva extends ProcesosDeInvitaciones {

	override procesarInvitacionesPendientes(Set<Invitacion> invitaciones) {
		this.getInvitacionesCumplenCondicionesPendientes(invitaciones).forEach [ invitacion |
			invitacion.confirmar(invitacion.cantidadAcompaniantesMaxima)
		]
	}

	override cumpleCondiciones(Invitacion invitacion) {
		this.obtenerDatosInvitado(invitacion)
		(usr.organizadorEsAmigo(evento.organizador)) || this.asistenCantidadMinimaAmigos() ||
			usr.eventoEstaCerca(evento)
	}

	override asistenCantidadMinimaAmigos() {
		usr.cantidadAmigosConfirmadosEvento(evento) >= 4
	}

}
