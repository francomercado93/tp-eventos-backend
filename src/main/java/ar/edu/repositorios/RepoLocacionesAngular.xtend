package ar.edu.repositorios

import ar.edu.eventos.Locacion
import org.uqbar.geodds.Point

class RepoLocacionesAngular extends RepositorioLocacion {
	static RepoLocacionesAngular repoLocacionesAngular

	def static RepoLocacionesAngular getInstance() {
		if (repoLocacionesAngular === null) {
			repoLocacionesAngular = new RepoLocacionesAngular
		}
		repoLocacionesAngular
	}

	private new() {
		val salonFiesta = new Locacion() => [
			descripcion = "Salon de Fiesta"
			puntoGeografico = new Point(-34.603695, -58.410973)
			superficie = 10d
		]

		val casaMaxi = new Locacion() => [
			descripcion = "Casa de Maxi"
			puntoGeografico = new Point(-34.93695, -59.410973)
			superficie = 10d
		]
		val tecnopolis = new Locacion() => [
			descripcion = "Tecnopolis"
			puntoGeografico = new Point(-34.559276, -58.505377)
			superficie = 6d
		]

		val hipodromo = new Locacion() => [
			descripcion = "Hipodromo San Isidro"
			puntoGeografico = new Point(-34.480860, -58.518295)
			superficie = 4.8d
		]
		val saloncito = new Locacion() => [
			descripcion = "Saloncito"
			puntoGeografico = new Point(-34.480860, -58.518295)
			superficie = 4.8d
		]
		val geba = new Locacion() => [
			descripcion = "GEBA"
			puntoGeografico = new Point(-34.568134, -58.418342)
			superficie = 6d
		]
		val directvArena = new Locacion() => [
			descripcion = "Directv Arena"
			puntoGeografico = new Point(-34.461990, -58.717383)
			superficie = 2d
		]

		this.create(casaMaxi)
		this.create(hipodromo)
		this.create(saloncito)
		this.create(salonFiesta)
		this.create(tecnopolis)
		this.create(geba)
		this.create(directvArena)
	}

	def getLocaciones() {
		lista
	}

}
