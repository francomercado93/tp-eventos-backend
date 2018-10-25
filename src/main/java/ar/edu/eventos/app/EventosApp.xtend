package ar.edu.eventos.app

import org.uqbar.xtrest.api.XTRest
import ar.edu.eventos.controller.UsuariosController

class EventosApp {
	def static void main(String[] args) {
		XTRest.start(9000 , UsuariosController/*, TareasController*/)
	}
}
