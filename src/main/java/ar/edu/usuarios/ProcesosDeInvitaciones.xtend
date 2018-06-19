package ar.edu.usuarios

import ar.edu.eventos.EventoCerrado
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class ProcesosDeInvitaciones {

	Usuario usr
	EventoCerrado evento

	def void procesarInvitacionesPendientes(Set<Invitacion> invitaciones)

	def Set<Invitacion> getInvitacionesCumplenCondicionesPendientes(Set<Invitacion> invitaciones) {
		invitaciones.filter[invitacion|this.cumpleCondiciones(invitacion)].toSet
	}

	def obtenerDatosInvitado(Invitacion invitacion) {
		usr = invitacion.getInvitado()
		evento = invitacion.getEvento()
	}

	def boolean cumpleCondiciones(Invitacion invitacion)

	def boolean asistenCantidadMinimaAmigos()

}
