package ar.edu.main

import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonArray
import org.uqbar.updateService.UpdateService

class StubUpdateService extends UpdateService {

	override String getUserUpdates() {
		var JsonArray usuarios = new JsonArray
		usuarios.add(
			Json.object().add("nombreUsuario", "lucas_capo").add("nombre", "Lucas").add("apellido", "Lopez").add("email",
				"lucas_93@hotmail.com").add("fechaNacimiento", "15/01/1993").add("direccion",
				Json.object().add("calle", "25 de Mayo").add("numero", 3918).add("localidad", "San Martin").add(
					"provincia", "Buenos Aires").add("coordenadas",
					Json.object().add("x", -34.572224).add("y", 58.535651))))
		usuarios.add(
			Json.object().add("nombreUsuario", "martin1990").add("nombre", "Martín").add("apellido", "Varela").add("email",
				"martinvarela90@yahoo.com").add("fechaNacimiento", "18/11/1990").add("direccion",
				Json.object().add("calle", "Av. Triunvirato").add("numero", 4065).add("localidad", "CABA").add(
					"provincia", "").add("coordenadas", Json.object().add("x", -33.582360).add("y", 60.516598))))
		usuarios.add(
			Json.object().add("nombreUsuario", "agustin").add("nombre", "Agustin").add("apellido", "Gonzalez").add("email",
				"agustinGonz@gmail.com").add("fechaNacimiento", "02/01/2000").add("direccion",
				Json.object().add("calle", "Quintana").add("numero", 2551).add("localidad", "San Martin").add(
					"provincia", "Buenos Aires").add("coordenadas",
					Json.object().add("x", -34.578651).add("y", -58.549614))))
		usuarios.toString
	}

	override String getLocationUpdates() {
		var JsonArray locaciones = new JsonArray
		locaciones.add(Json.object().add("x", -34.603759).add("y", -58.381586).add("nombre", "Salón El Abierto"))
		locaciones.add(Json.object().add("x", -34.572224).add("y", -58.535651).add("nombre", "Estadio Obras"))
		locaciones.add(Json.object().add("x", -34.588769).add("y", -58.572230).add("nombre", "Salon de Fiesta"))
		locaciones.toString
	}

	override String getServiceUpdates() {
		var JsonArray servicios = new JsonArray
		servicios.add(
			Json.object().add("descripcion", "Catering Food Party").add("tarifaServicio",
				Json.object().add("tipo", "TF").add("valor", 5000)).add("tarifaTraslado", 30).add("ubicacion",
				Json.object().add("x", -34.572224).add("y", 58.535651)))
		servicios.add(
			Json.object().add("descripcion", "Animacion mago sin dientes").add("tarifaServicio",
				Json.object().add("tipo", "TPH").add("valor", 250).add("minimo", 800)).add("tarifaTraslado", 15).add(
				"ubicacion", Json.object().add("x", -34.1000004).add("y", 57.1755)))
		servicios.toString
	}

}
