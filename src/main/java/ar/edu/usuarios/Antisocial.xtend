package ar.edu.usuarios

import ar.edu.invitaciones.Invitacion
import ar.edu.invitaciones.RechazoMasivoAntisocial
import java.util.Set

class Antisocial implements TipoPersonalidad{
	
	RechazoMasivoAntisocial procesoRechazoMasivo = new RechazoMasivoAntisocial
	
	override rechazarPendientes(Set<Invitacion> invitaciones){
		procesoRechazoMasivo.procesarInvitacionesPendientes(invitaciones)
	}
}