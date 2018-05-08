package ar.edu.main

import ar.edu.usuarios.Direccion
import ar.edu.usuarios.Usuario
import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonObject.Member
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Main {
	
	Set<Usuario> usuarios = newHashSet
	
	def conversionJsonUsuarios(String string){
 		var obj = Json.parse(string).asObject()
 		for (Member member : obj){
 			var usuario = new Usuario()
	 		usuario.nombreUsuario = obj.get("nombreUsuario").asString
			usuario.nombreApellido = obj.get("nombreApellido").asString
	 		usuario.mail = obj.get("email").asString
	 		var stringNacimiento = obj.get("fechaNacimiento").asString
	 		val DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
	 		usuario.fechaNacimiento = LocalDateTime.parse(stringNacimiento, formatter)
	 		var dir = obj.get("direccion").asObject
	 		var coord = dir.get("coordenadas").asObject
	 		var punto = new Point(coord.get("x").asInt, coord.get("y").asInt)
	 		usuario.direccion = new Direccion(dir.get("calle").asString, dir.get("numero").asInt, dir.get("localidad").asString,
	 			dir.get("provincia").asString, punto)
	 		usuarios.add(usuario)
 		}
 	}
}