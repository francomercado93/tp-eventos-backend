package ar.edu.usuarios

import ar.edu.invitaciones.Invitacion
import ar.edu.invitaciones.RechazoMasivoSociable
import java.util.Set

class Sociable implements TipoPersonalidad {

	RechazoMasivoSociable procesoRechazoMasivo = new RechazoMasivoSociable

	override rechazarPendientes(Set<Invitacion> invitaciones) {
		procesoRechazoMasivo.procesarInvitacionesPendientes(invitaciones)
	}
	
}
