package ar.edu.eventos.app

import ar.edu.eventos.controller.EntradasController
import ar.edu.eventos.controller.EventosController
import ar.edu.eventos.controller.InvitacionesController
import ar.edu.eventos.controller.LocacionesController
import ar.edu.eventos.controller.UsuariosController
import org.uqbar.xtrest.api.XTRest

class EventosApp {
	def static void main(String[] args) {
		XTRest.start(9000, UsuariosController, InvitacionesController, EventosController, LocacionesController,
			EntradasController)
	}
}
//React     