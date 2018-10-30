package ar.edu.repositorios

import ar.edu.eventos.EventoAbierto
import ar.edu.eventos.EventoCerrado
import ar.edu.usuarios.Amateur
import ar.edu.usuarios.Free
import ar.edu.usuarios.Profesional
import ar.edu.usuarios.Usuario
import java.time.LocalDate
import java.time.LocalDateTime

class RepoUsuariosAngular extends RepositorioUsuarios {
	/* Singleton */
	static RepoUsuariosAngular repoUsuariosAngular

	def static RepoUsuariosAngular getInstance() {
		if (repoUsuariosAngular === null) {
			repoUsuariosAngular = new RepoUsuariosAngular
		}
		repoUsuariosAngular
	}

	private new() {

		val agustina = new Usuario() => [
			nombreUsuario = "agustina"
			nombre = "Agustina"
			apellido = "Pastor"
			mail = "agus2000@gmail.com"
			fechaNacimiento = LocalDate.of(2000, 01, 02)
			tipoUsuario = new Free()
		]
		val juan = new Usuario() => [
			nombreUsuario = "juan"
			nombre = "Juan Martin"
			apellido = " Del Potro"
			mail = "juan00@gmail.com"
			fechaNacimiento = LocalDate.of(2000, 01, 02)
			tipoUsuario = new Amateur()
		]
		val martin = new Usuario() => [
			nombreUsuario = "martin"
			nombre = "Martin"
			apellido = "Benitez"
			mail = "martinBntz@gmail.com"
			fechaNacimiento = LocalDate.of(2001, 05, 12)
			tipoUsuario = new Free()
		]

		val maxi = new Usuario() => [
			nombreUsuario = "maxi5"
			nombre = "Maxi"
			apellido = "Coronel"
			mail = "maxigg@gmail.com"
			fechaNacimiento = LocalDate.of(1977, 08, 09)
			tipoUsuario = new Profesional()
		]
		val gaby = new Usuario() => [
			nombreUsuario = "Gaby555"
			nombre = "Gabriel"
			apellido = "Martinez"
			mail = "gaby_44@gmail.com"
			fechaNacimiento = LocalDate.of(1996, 10, 15)
			tipoUsuario = new Free()
		]
		val maria = new Usuario() => [
			nombreUsuario = "MariaSanchez4"
			nombre = "Maria"
			apellido = "Sanchez"
			mail = "sanchezmaria@hotmail.com"
			fechaNacimiento = LocalDate.of(1983, 02, 02)
			tipoUsuario = new Free()
		]
		val lucas = new Usuario() => [
			nombreUsuario = "Lucas41"
			nombre = "Lucas"
			apellido = "Benitez"
			mail = "lucasb@gmail.com"
			fechaNacimiento = LocalDate.of(1991, 11, 11)
			tipoUsuario = new Amateur()
		]
		val beatriz = new Usuario() => [
			nombreUsuario = "Beatriz788"
			nombre = "Beatriz"
			apellido = "Fernandez"
			mail = "bety@gmail.com"
			fechaNacimiento = LocalDate.of(1973, 02, 02)
			tipoUsuario = new Free()
		]
		val marco = new Usuario() => [
			nombreUsuario = "MarcoCD"
			nombre = "Marco"
			apellido = "Sanchez"
			mail = "marquito@gmail.com"
			fechaNacimiento = LocalDate.of(1996, 05, 02)
			tipoUsuario = new Amateur()
		]
		val tomas = new Usuario() => [
			nombreUsuario = "TomasQWE"
			nombre = "Tomas"
			apellido = "Diaz"
			mail = "tommy@hotmail.com"
			fechaNacimiento = LocalDate.of(1988, 12, 02)
			tipoUsuario = new Profesional()
		]
		val miriam = new Usuario() => [
			nombreUsuario = "MiriamP"
			nombre = "Miriam"
			apellido = "Perez"
			mail = "perezmiriam0@gmail.com"
			fechaNacimiento = LocalDate.of(1993, 02, 15)
			tipoUsuario = new Free()
		]
		// Usuario Principal de la app
		val agustin = new Usuario() => [
			nombreUsuario = "agustin"
			nombre = "Agustin"
			apellido = "Gonzalez"
			mail = "agustinKpo@gmail.com"
			tipoUsuario = new Profesional()
			fechaNacimiento = LocalDate.of(2000, 01, 02)

		]

//		val salonFiesta = new Locacion() => [
//			descripcion = "Salon de Fiesta"
//			puntoGeografico = new Point(-34.603695, -58.410973)
//			superficie = 10d
//		]
//
//		val casaMaxi = new Locacion() => [
//			descripcion = "Casa de Maxi"
//			puntoGeografico = new Point(-34.93695, -59.410973)
//			superficie = 10d
//		]
//		val tecnopolis = new Locacion() => [
//			descripcion = "Tecnopolis"
//			puntoGeografico = new Point(-34.559276, -58.505377)
//			superficie = 6d
//		]
//
//		val hipodromo = new Locacion() => [
//			descripcion = "hipodromo San Isidro"
//			puntoGeografico = new Point(-34.480860, -58.518295)
//			superficie = 4.8d
//		]
//
//		val saloncito = new Locacion() => [
//			descripcion = "Saloncito"
//			puntoGeografico = new Point(-34.480860, -58.518295)
//			superficie = 4.8d
//		]
//		
		val salonFiesta = RepoLocacionesAngular.instance.search("Salon de Fiesta").get(0)
		val casaMaxi = RepoLocacionesAngular.instance.search("Casa de Maxi").get(0)
		val tecnopolis = RepoLocacionesAngular.instance.search("Tecnopolis").get(0)
		val hipodromo = RepoLocacionesAngular.instance.search("Hipodromo San Isidro").get(0)
		val saloncito = RepoLocacionesAngular.instance.search("Saloncito").get(0)
		
		val cumpleJulian = new EventoCerrado() => [
			nombreEvento = "Cumple Julian"
			inicioEvento = LocalDateTime.of(2018, 6, 7, 18, 30)
			finEvento = LocalDateTime.of(2018, 6, 7, 23, 00)
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 6, 6, 21, 00)
			locacion = salonFiesta
			capacidadMaxima = 20
		]

		val casamientoMarta = new EventoCerrado() => [
			nombreEvento = "Casamiento Marta "
			inicioEvento = LocalDateTime.of(2018, 11, 11, 22, 30)
			finEvento = LocalDateTime.of(2018, 11, 11, 6, 00)
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 10, 11, 22, 30)
			locacion = salonFiesta
			capacidadMaxima = 10
		]

		val cumpleMaxi = new EventoCerrado() => [
			nombreEvento = "Cumple Maxi "
			inicioEvento = LocalDateTime.of(2018, 06, 5, 19, 30)
			finEvento = LocalDateTime.of(2018, 06, 5, 22, 00)
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 06, 05, 22, 30)
			locacion = casaMaxi
			capacidadMaxima = 15
		]

		this.create(agustin)
		this.create(agustina)
		this.create(beatriz)
		this.create(gaby)
		this.create(juan)
		this.create(lucas)
		this.create(marco)
		this.create(maria)
		this.create(martin)
		this.create(maxi)
		this.create(miriam)
		this.create(tomas)
		agustin.agregarAmigo(marco)
		agustin.agregarAmigo(agustina)
		agustin.agregarAmigo(miriam)
		agustin.agregarAmigo(tomas)
		agustin.agregarAmigo(lucas)
		agustin.agregarAmigo(maxi)
		maxi.fechaHoraActual = LocalDateTime.of(2018, 05, 3, 19, 00)
		agustin.fechaHoraActual = LocalDateTime.of(2018, 05, 3, 19, 00)
		juan.fechaHoraActual = LocalDateTime.of(2018, 05, 3, 19, 00)
		maria.fechaHoraActual = LocalDateTime.of(2018, 05, 3, 19, 00)
		beatriz.fechaHoraActual = LocalDateTime.of(2018, 05, 3, 19, 00)
		miriam.fechaHoraActual = LocalDateTime.of(2018, 05, 3, 19, 00)
		maxi.crearEvento(cumpleJulian)
		maxi.crearEvento(casamientoMarta)
		juan.crearEvento(cumpleMaxi)
		maxi.invitarUsuario(agustin, cumpleJulian, 5)
		maxi.invitarUsuario(agustin, casamientoMarta, 6)
		maxi.invitarUsuario(maria, casamientoMarta, 2)
		juan.invitarUsuario(agustin, cumpleMaxi, 4)
		juan.invitarUsuario(beatriz, cumpleMaxi, 5)
		juan.invitarUsuario(miriam, cumpleMaxi, 2)
		// eventos organizados por mi
		// EVENTOS ABIERTOS
		val soundhearts = new EventoAbierto() => [
			nombreEvento = "Soundhearts"
			inicioEvento = LocalDateTime.of(2019, 04, 14, 18, 00)
			finEvento = LocalDateTime.of(2019, 04, 14, 23, 30)
			fechaMaximaConfirmacion = LocalDateTime.of(2019, 04, 13, 23, 59)
			locacion = tecnopolis
			edadMinima = 15
			valorEntrada = 0

		]

		val lollapalooza = new EventoAbierto() => [
			nombreEvento = "lollapalooza"
			inicioEvento = LocalDateTime.of(2018, 06, 27, 18, 00)
			finEvento = LocalDateTime.of(2018, 06, 28, 01, 00)
			locacion = hipodromo
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 03, 15, 23, 59)
			edadMinima = 18
			valorEntrada = 500
		]
		val cumpleMartin = new EventoCerrado() => [
			nombreEvento = " Cumple de Tincho"
			inicioEvento = LocalDateTime.of(2018, 06, 13, 19, 30)
			finEvento = LocalDateTime.of(2018, 06, 13, 23, 00)
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 06, 12, 19, 30)
			locacion = casaMaxi
			capacidadMaxima = 15
		]

		val bautismo = new EventoCerrado() => [
			nombreEvento = " Bautismo chloe"
			inicioEvento = LocalDateTime.of(2018, 06, 29, 10, 30)
			finEvento = LocalDateTime.of(2018, 06, 29, 12, 00)
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 06, 16, 10, 30)
			locacion = saloncito
			capacidadMaxima = 15
		]

		agustin.fechaHoraActual = LocalDateTime.of(2018, 04, 14, 18, 00)
		agustin.crearEvento(soundhearts)
		agustin.fechaHoraActual = LocalDateTime.of(2018, 06, 27, 18, 00)
		agustin.crearEvento(lollapalooza)
		agustin.fechaHoraActual = LocalDateTime.of(2018, 06, 06, 19, 30)
		agustin.crearEvento(cumpleMartin)
		agustin.fechaHoraActual = LocalDateTime.of(2018, 06, 01, 10, 30)
		agustin.crearEvento(bautismo)
	}

	def getUsrsRepo() {
		lista
	}
}
