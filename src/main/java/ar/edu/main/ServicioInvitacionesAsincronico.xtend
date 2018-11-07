package ar.edu.main

import ar.edu.eventos.EventoCerrado
import ar.edu.eventos.exceptions.BusinessException
import ar.edu.usuarios.Usuario
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ServicioInvitacionesAsincronico {

	Set<Usuario> usuariosAProcesar = newHashSet

	def ejecucionInvitacionesAsincronicas() {
		usuariosAProcesar.forEach[usr|usr.procesarAceptados()]
		usuariosAProcesar.forEach[usr|usr.procesarRechazados()]
	}

	def cambiarDesicionAceptado(Usuario unUsuario, EventoCerrado unEvento) {

		var usrAcambiar = usuariosAProcesar.findFirst(usr|usr === unUsuario)
		var invAcambiar = usrAcambiar.invAceptado.findFirst(usr|usr.auxEvento === unEvento)

		if (usrAcambiar === null) {
			throw new BusinessException("Usuario no uso el servicio asincronico")
		}
		if (invAcambiar === null) {
			throw new BusinessException("Invitacion no encontrada")
		}
		usrAcambiar.invAceptado.remove(invAcambiar)
		usrAcambiar.invRechazado.add(invAcambiar)

	}

	def cambiarDesicionRechazado(Usuario unUsuario, EventoCerrado unEvento) {
		
		var usrAcambiar = usuariosAProcesar.findFirst(usr|usr === unUsuario)
		var invAcambiar = usrAcambiar.invRechazado.findFirst(usr|usr.auxEvento === unEvento)

		if (usrAcambiar === null) {
			throw new BusinessException("Usuario no uso el servicio asincronico")
		}
		if (invAcambiar === null) {
			throw new BusinessException("Invitacion no encontrada")
		}

		usrAcambiar.invRechazado.remove(invAcambiar)
		usrAcambiar.invAceptado.add(invAcambiar)

	}

}