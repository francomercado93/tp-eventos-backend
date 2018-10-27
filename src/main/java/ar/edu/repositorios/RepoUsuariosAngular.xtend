package ar.edu.repositorios

import ar.edu.usuarios.Amateur
import ar.edu.usuarios.Free
import ar.edu.usuarios.Profesional
import ar.edu.usuarios.Usuario
import java.time.LocalDate

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

	}

	def getUsrsRepo() {
		lista
	}
}
