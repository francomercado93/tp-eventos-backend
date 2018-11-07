package ar.edu.eventos.app

import org.uqbar.xtrest.api.XTRest
import ar.edu.eventos.controller.UsuariosController
import ar.edu.eventos.controller.InvitacionesController
import ar.edu.eventos.controller.EventosController
import ar.edu.eventos.controller.LocacionesController

class EventosApp {
	def static void main(String[] args) {
		XTRest.start(9000 , UsuariosController, InvitacionesController, EventosController, LocacionesController)
	}
}
