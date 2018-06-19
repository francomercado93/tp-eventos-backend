package ar.edu.usuarios

import ar.edu.invitaciones.Invitacion
import java.util.Set

interface TipoPersonalidad {
	
	def void rechazarPendientes(Set<Invitacion> invitaciones)
	
}
