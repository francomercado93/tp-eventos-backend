package ar.edu.usuarios

import ar.edu.eventos.EventoCerrado
import java.util.Set

interface TipoPersonalidad {
	
	def void rechazarPendientes(Usuario usuario)
	
	def Set<Invitacion> invitacionesPendientesParaRechazarQueCumplenCondiciones(Usuario usuario)
	
	def boolean cumpleCondiciones(EventoCerrado unEvento, Usuario usuario)
	
}