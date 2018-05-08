package ar.edu.main

import ar.edu.eventos.Locacion
import ar.edu.usuarios.Direccion
import ar.edu.usuarios.Usuario
import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonObject
import com.eclipsesource.json.JsonValue
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Main {
	
	Set<Usuario> usuarios = newHashSet	//lista actualizada de usuarios recibidos, hacer actualizacion repo recorriendo la lista
	Set<Locacion> locaciones = newHashSet //lista actualizada de locaciones recibidos
	
	def conversionJsonAUsuarios(String string){
 		var listUsers = Json.parse(string).asArray()
 		for (JsonValue i : listUsers){
 			var usuario = new Usuario()	//?
 			var usr = i.asObject
 			this.jsonUser(usuario, usr)
	 		usuarios.add(usuario)
 		}
 	}
 	
 	def jsonUser(Usuario usuario, JsonObject usr){
 		usuario.nombreUsuario = usr.get("nombreUsuario").asString
		usuario.nombreApellido = usr.get("nombreApellido").asString
	 	usuario.mail = usr.get("email").asString
	 	var stringNacimiento = usr.get("fechaNacimiento").asString
	 	val DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
	 	usuario.fechaNacimiento = LocalDateTime.parse(stringNacimiento, formatter)
	 	var dir = usr.get("direccion").asObject
	 	var coord = dir.get("coordenadas").asObject
	 	var punto = new Point(coord.get("x").asInt, coord.get("y").asInt)
	 	usuario.direccion = new Direccion(dir.get("calle").asString, dir.get("numero").asInt, dir.get("localidad").asString,
	 	dir.get("provincia").asString, punto)
 	}
 	
 	def conversionJsonLocaciones(String string){
 		var listLocaciones = Json.parse(string).asArray
 		for(JsonValue i : listLocaciones){
 			var locacion = new Locacion()
 			var obj = i.asObject
 			this.jsonLocacion(locacion, obj)
 			locaciones.add(locacion)
 		}
 	}
 	
 	def jsonLocacion(Locacion locacion, JsonObject obj){
 		var punto = new Point(obj.get("x").asInt, obj.get("y").asInt)
 		locacion.puntoGeografico = punto
 		locacion.descripcion = obj.get("nombre").asString
 	}
}