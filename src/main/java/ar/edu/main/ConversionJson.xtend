package ar.edu.main

import ar.edu.eventos.Locacion
import ar.edu.servicios.Servicios
import ar.edu.servicios.TarifaFija
import ar.edu.servicios.TarifaPersona
import ar.edu.servicios.TarifaPorHora
import ar.edu.usuarios.Direccion
import ar.edu.usuarios.Usuario
import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonObject
import com.eclipsesource.json.JsonValue
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class ConversionJson {

	Set<Usuario> usuarios = newHashSet // lista actualizada de usuarios recibidos, hacer actualizacion repo recorriendo la lista
	Set<Locacion> locaciones = newHashSet // lista actualizada de locaciones recibidos
	Set<Servicios> servicios = newHashSet

	def conversionJsonAUsuarios(String usuarios) {
		var listUsers = Json.parse(usuarios).asArray()
		for (JsonValue usr : listUsers) {
			this.usuarios.add(this.jsonUser(usr.asObject))
		}
	}

	def jsonUser(JsonObject usr) {
		var usuario = new Usuario() => [
			nombreUsuario = usr.get("nombreUsuario").asString
			nombreApellido = usr.get("nombreApellido").asString
			mail = usr.get("email").asString
			var stringNacimiento = usr.get("fechaNacimiento").asString
			val DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy")
			fechaNacimiento = LocalDate.parse(stringNacimiento, formatter)
			var dir = usr.get("direccion").asObject
			var coord = dir.get("coordenadas").asObject
			var Point punto = new Point(coord.get("x").asDouble, coord.get("y").asDouble)
			direccion = new Direccion(dir.get("calle").asString, dir.get("numero").asInt, dir.get("localidad").asString,
				dir.get("provincia").asString, punto)
		] // ?
		usuario
	}

	def conversionJsonLocaciones(String locacionInput) {
		var listLocaciones = Json.parse(locacionInput).asArray
		for (JsonValue locacion : listLocaciones) {
			locaciones.add(this.jsonLocacion(locacion.asObject))
		}
	}

	def jsonLocacion(JsonObject obj) {
		var locacion = new Locacion() => [
			puntoGeografico = new Point(obj.get("x").asDouble, obj.get("y").asDouble)
			descripcion = obj.get("nombre").asString
		]
		locacion
	}

	def conversionJsonTarifa(JsonObject tarifaObj) {
		// var tarifaObj = Json.parse(tarifaInput).asObject
		var tipo = tarifaObj.get("tipo").asString
		this.conversionTipoTarifa(tipo, tarifaObj)
	}

	def conversionTipoTarifa(String tipo, JsonObject tarifaObj) {
		if (tipo.equals("TF")) {
			var tarifaFija = new TarifaFija(tarifaObj.get("valor").asDouble)
			return tarifaFija
		}
		if (tipo.equals("TPP")) {
			var tarifaPorPersona = new TarifaPersona(tarifaObj.get("valor").asDouble,
				tarifaObj.get("porcebtajeParaMinimo").asDouble)
			return tarifaPorPersona
		}
		if (tipo.equals("TPH")) {
			var tarifaPorHora = new TarifaPorHora(tarifaObj.get("valor").asDouble, tarifaObj.get("minimo").asDouble)
			return tarifaPorHora
		}
	}

	def conversionJsonServicios(String servicioInput) {
		var listServ = Json.parse(servicioInput).asArray
		for (JsonValue servObj : listServ) {
			servicios.add(this.jsonServicio(servObj.asObject))
		}
	}

	def jsonServicio(JsonObject servObj) {
		var servicio = new Servicios() => [
			descripcion = servObj.get("descripcion").asString
			tipoTarifa = this.conversionJsonTarifa(servObj.get("tarifaServicio").asObject)
			tarifaPorKilometro = servObj.get("tarifaTraslado").asDouble
			var coordenadas = servObj.get("ubicacion").asObject
			ubicacionServicio = new Point(coordenadas.get("x").asDouble, coordenadas.get("y").asDouble)
		]
		servicio
	}
}
