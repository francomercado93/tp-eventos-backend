package ar.edu.eventos.controller

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty

@Controller
class UsuariosController {

	extension JSONUtils = new JSONUtils

	@Get("/usuarios")
	def Result usuarios() {
		try {
			ok(getUsuarios.toJson)
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}
	def getUsuarios() {
		#[
			new UsrTest() => [
				nombre = "Jorge"
				apellido = "PEP"
			],
			new UsrTest() => [
				nombre = "Pedro"
				apellido = "Picapiedra"
			]
		]
	}
}
@Accessors
class UsrTest extends Entity {
	String nombre
	@JsonIgnore String apellido

//	new(String nombre, String apellido) {
//		this.nombre = nombre
//	}
	@JsonProperty("test")
	def getTester(){
		"Test de json property"
	}
}
