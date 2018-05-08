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
import java.io.FileReader
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class TraductorJson {
	
	Set<Usuario> usuarios = newHashSet	//lista actualizada de usuarios recibidos, hacer actualizacion repo recorriendo la lista
	Set<Locacion> locaciones = newHashSet //lista actualizada de locaciones recibidos
	Set<Servicios> servicios = newHashSet
	
	def conversionJsonAUsuarios(FileReader usuarios){
 		var listUsers = Json.parse(usuarios).asArray()
 		for (JsonValue i : listUsers){
 			var usuario = new Usuario()	//?
 			var usr = i.asObject
 			this.jsonUser(usuario, usr)
	 		this.usuarios.add(usuario)
 		}
 	}
 	
 	def jsonUser(Usuario usuario, JsonObject usr){
 		usuario.nombreUsuario = usr.get("nombreUsuario").asString
		usuario.nombreApellido = usr.get("nombreApellido").asString
	 	usuario.mail = usr.get("email").asString
	 	var stringNacimiento = usr.get("fechaNacimiento").asString
	 	val DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy")
	 	usuario.fechaNacimiento = LocalDate.parse(stringNacimiento, formatter)
	 	var dir = usr.get("direccion").asObject
	 	var coord = dir.get("coordenadas").asObject
	 	var Point punto = new Point(coord.get("x").asDouble, coord.get("y").asDouble)
	 	usuario.direccion = new Direccion(dir.get("calle").asString, dir.get("numero").asInt, dir.get("localidad").asString,
	 	dir.get("provincia").asString, punto)
 	}
 	
 	def conversionJsonLocaciones(String locacionInput){
 		var listLocaciones = Json.parse(locacionInput).asArray
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
 	
 	def conversionJsonTarifa(String tarifaInput){
 		var tarifa = Json.parse(tarifaInput).asObject
 		var tipo = tarifa.get("tipo").asString
 		if(tipo.equals("TF")){
 			var tarifaFija = new TarifaFija(tarifa.get("valor").asDouble)
 			return tarifaFija
 		}
 		if (tipo.equals("TPP")){
 			var tarifaPorPersona= new TarifaPersona(tarifa.get("valor").asDouble,tarifa.get("porcebtajeParaMinimo").asDouble)
 			return tarifaPorPersona
 		}
 		if(tipo.equals("TPH")){
 			var tarifaPorHora = new TarifaPorHora(tarifa.get("valor").asDouble, tarifa.get("minimo").asDouble)
 			return tarifaPorHora
 		}
 	}
 	
 	/*def conversionJsonServicio(String servicioInput){
 		var listServ = Json.parse(servicioInput).asArray
 		for (JsonValue i : listServ){
 			var serv = new Servicios()
 			serv.descripcion = 
 		}
 	}*/
 	
 	/*def void actualizarRepoUsuarios(){
 		var repoUsuario = new RepositorioUsuarios()
 		usuarios.forEach(usuario | repoUsuario.create(usuario))
 	}*/
}