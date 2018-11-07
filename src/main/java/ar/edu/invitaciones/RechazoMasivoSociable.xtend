package ar.edu.invitaciones

import java.util.Set

class RechazoMasivoSociable extends ProcesosDeInvitaciones {

	override procesarInvitacionesPendientes(Set<Invitacion> invitaciones) {
		this.getInvitacionesCumplenCondicionesPendientes(invitaciones).forEach[invitacion|invitacion.rechazar()]
	}

	override cumpleCondiciones(Invitacion invitacion) {
		this.obtenerDatosInvitado(invitacion)
		!usr.eventoEstaCerca(evento) || this.asistenCantidadMinimaAmigos()
	}

	override asistenCantidadMinimaAmigos() {
		usr.cantidadAmigosConfirmadosEvento(evento) == 0
	}

}
