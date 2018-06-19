package ar.edu.usuarios

import java.util.Set

interface TipoPersonalidad {
	
	def void rechazarPendientes(Set<Invitacion> invitaciones)
	
}

class Antisocial implements TipoPersonalidad{
	
	RechazoMasivoAntisocial procesoRechazoMasivo = new RechazoMasivoAntisocial
	
	override rechazarPendientes(Set<Invitacion> invitaciones){
		procesoRechazoMasivo.procesarInvitacionesPendientes(invitaciones)
	}
}

class Sociable implements TipoPersonalidad{
	
	RechazoMasivoSociable procesoRechazoMasivo = new RechazoMasivoSociable
	
	override rechazarPendientes(Set<Invitacion> invitaciones){
		procesoRechazoMasivo.procesarInvitacionesPendientes(invitaciones)
	}
}