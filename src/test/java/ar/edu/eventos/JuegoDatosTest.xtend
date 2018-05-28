package ar.edu.eventos

import ar.edu.servicios.Servicios
import ar.edu.servicios.TarifaFija
import ar.edu.servicios.TarifaPersona
import ar.edu.servicios.TarifaPorHora
import ar.edu.usuarios.Amateur
import ar.edu.usuarios.Free
import ar.edu.usuarios.Profesional
import ar.edu.usuarios.Usuario
import java.time.LocalDate
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Before
import org.uqbar.ccService.CCResponse
import org.uqbar.ccService.CreditCard
import org.uqbar.ccService.CreditCardService
import org.uqbar.geodds.Point

import static org.mockito.Mockito.*

@Accessors
abstract class JuegoDatosTest {

	// EventoAbierto soundhearts
	EventoAbierto lollapalooza
	EventoCerrado casamiento
	EventoCerrado cumple
	EventoCerrado minifiesta1
	EventoCerrado even1
	EventoCerrado even2
	EventoCerrado even3
	EventoCerrado even4
	EventoCerrado even5
	EventoCerrado even6
	Locacion salonFiesta
	Locacion hipodromo
	Locacion tecnopolis
	Locacion hipodromoPalermo
	LocalDateTime inicioLolla = LocalDateTime.of(2018, 03, 27, 18, 00)
	LocalDateTime finLolla = LocalDateTime.of(2018, 03, 28, 01, 00)
	// LocalDateTime inicioSound = LocalDateTime.of(2018, 04, 14, 18, 00)
	// LocalDateTime finSound = LocalDateTime.of(2018, 04, 14, 23, 30)
	Point puntoPrueba = new Point(-34.577908, -58.526486)
	Usuario juan
	Usuario martin
	Usuario maxi
	Usuario beatriz
	Usuario lucas
	Usuario maria
	Usuario gaby
	Usuario ultimoComprador
	Usuario free1
	Usuario alejandro
	Usuario marco
	Usuario tomas
	Usuario miriam
	Usuario gaston
	Usuario carla
	Usuario agustin
	Usuario agustina
	Servicios animacionMago
	Servicios cateringFoodParty
	Servicios candyBarWillyWonka
	Servicios animacionMagoCostoMinimo
	
	@Before
	def void init() {
				
		// LOCACIONES
		salonFiesta = new Locacion() => [
			descripcion = "Salon de Fiesta"
			puntoGeografico = new Point(-34.603695, -58.410973)
			superficie = 10d
		]
		tecnopolis = new Locacion() => [
			descripcion = "Tecnopolis"
			puntoGeografico = new Point(-34.559276, -58.505377)
			superficie = 6d
		]
		hipodromo = new Locacion() => [
			descripcion = "hipodromo San Isidro"
			puntoGeografico = new Point(-34.480860, -58.518295)
			superficie = 4.8d
		]
		
		hipodromoPalermo = new Locacion() =>[
			descripcion = "hipodromo Palermo"
			puntoGeografico = new Point(-34.567684, -58.429661)
			superficie = 4.8d
		]

		// EVENTOS ABIERTOS
		/*soundhearts = new EventoAbierto() => [
		 * 	nombreEvento = "Soundhearts"
		 * 	inicioEvento = inicioSound
		 * 	finEvento = finSound
		 * 	lugar = tecnopolis
		 * 	edadMinima = 15
		 * 	valorEntrada = 0

		 ]*/
		lollapalooza = new EventoAbierto() => [
			nombreEvento = "lollapalooza"
			inicioEvento = inicioLolla
			finEvento = finLolla
			lugar = hipodromo
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 03, 15, 23, 59)
			edadMinima = 18
			valorEntrada = 500
		]

		cumple = new EventoCerrado() => [
			nombreEvento = "cumple Julian"
			organizador = juan
			inicioEvento = LocalDateTime.of(2018, 05, 30, 18, 30)
			finEvento = LocalDateTime.of(2018, 05, 30, 23, 00)
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 05, 29, 21, 00)
			lugar = salonFiesta
			capacidadMaxima = 20
		]
		minifiesta1 = new EventoCerrado() => [
			nombreEvento = "minifiesta1"
			inicioEvento = LocalDateTime.of(2018, 05, 31, 14, 00)
			finEvento = LocalDateTime.of(2018, 05, 31, 15, 00)
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 05, 31, 11, 30)
			lugar = salonFiesta
			capacidadMaxima = 20
		]

		// PERSONAS
		agustin = new Usuario() => [
			nombreUsuario = "agustin"
			nombreApellido = "agustin gonzalez"
			mail = "agustinKpo@gmail.com"
			setDireccion("Quintana", 2551, "San Martin", "Buenos Aires", new Point(-34.578651, -58.549614))
			fechaHoraActual = LocalDateTime.of(2018, 03, 15, 22, 00)
			fechaNacimiento = LocalDate.of(2000, 01, 02)
		]
		agustina = new Usuario() => [
			nombreUsuario = "agustina"
			nombreApellido = "agustina pastor"
			mail = "agus2000@gmail.com"
			setDireccion("Quintana", 2551, "San Martin", "Buenos Aires", new Point(-34.578651, -58.549614))
			fechaHoraActual = LocalDateTime.of(2018, 03, 15, 22, 00)
			fechaNacimiento = LocalDate.of(2000, 01, 02)
		]
		juan = new Usuario() => [
			nombreUsuario = "juan"
			nombreApellido = "Juan Martin del Potro"
			mail = "juan00@gmail.com"
			setDireccion("Quintana", 2551, "San Martin", "Buenos Aires", new Point(-34.578651, -58.549614))
			fechaHoraActual = LocalDateTime.of(2018, 03, 15, 22, 00)
			fechaNacimiento = LocalDate.of(2000, 01, 02)
			miTarjeta = new CreditCard
			servicioTarjeta = mockearCreditCardServicePagoExitoso(miTarjeta, lollapalooza.valorEntrada)
		]
		martin = new Usuario() => [
			nombreUsuario = "martin"
			nombreApellido = "Martin Benitez"
			mail = "martinBntz@gmail.com"
			setDireccion("America", 3450, "San Martin", "Buenos Aires", new Point(-34.560245, -58.546651))
			fechaHoraActual = LocalDateTime.of(2018, 03, 16, 00, 22)
			fechaNacimiento = LocalDate.of(2001, 05, 12)
			miTarjeta = new CreditCard
			servicioTarjeta = mockearCreditCardServicePagoExitoso(miTarjeta, lollapalooza.valorEntrada)
		]

		// Usuarios que compran entradas y cumplen requisitos
		maxi = new Usuario() => [
			nombreUsuario = "maxi5"
			nombreApellido = "Maxi Coronel"
			mail = "maxigg@gmail.com"
			setDireccion("Carlos Francisco Melo", 2356, "Vicente Lopez", "Buenos Aires",
				new Point(-34.534199, -58.490467))
			fechaHoraActual = LocalDateTime.of(2018, 02, 15, 15, 30)
			fechaNacimiento = LocalDate.of(1977, 08, 09)
			miTarjeta = new CreditCard
			servicioTarjeta = mockearCreditCardServicePagoExitoso(miTarjeta, lollapalooza.valorEntrada)
			comprarEntrada(lollapalooza)
		]
		gaby = new Usuario() => [
			nombreUsuario = "Gaby555"
			nombreApellido = "Gabriel Martinez"
			mail = "gaby_44@gmail.com"
			setDireccion("Av. Maipú 3144", 2356, "Olivos", "Buenos Aires", new Point(-34.507145, -58.492910))
			fechaHoraActual = LocalDateTime.of(2017, 09, 02, 20, 15)
			fechaNacimiento = LocalDate.of(1996, 10, 15)
			miTarjeta = new CreditCard
			servicioTarjeta = mockearCreditCardServicePagoExitoso(miTarjeta, lollapalooza.valorEntrada)
			comprarEntrada(lollapalooza )
		]
		maria = new Usuario() => [
			nombreUsuario = "MariaSanchez4"
			nombreApellido = "Maria Sanchez"
			mail = "sanchezmaria@hotmail.com"
			setDireccion("Av. Bartolomé Mitre", 4787, "Caseros", "Buenos Aires", new Point(-34.609812, -58.563639))
			fechaHoraActual = LocalDateTime.of(2018, 02, 27, 05, 00)
			fechaNacimiento = LocalDate.of(1983, 02, 02)
			miTarjeta = new CreditCard
			servicioTarjeta = mockearCreditCardServicePagoExitoso(miTarjeta, lollapalooza.valorEntrada)
			comprarEntrada(lollapalooza)
		]
		lucas = new Usuario() => [
			nombreUsuario = "Lucas41"
			nombreApellido = "Lucas Benitez"
			mail = "lucasb@gmail.com"
			setDireccion("Nogoya", 3460, "Villa del Parque", "CABA", new Point(-34.605375, -58.496150))
			fechaHoraActual = LocalDateTime.of(2018, 01, 31, 19, 50)
			fechaNacimiento = LocalDate.of(1991, 11, 11)
			miTarjeta = new CreditCard
			servicioTarjeta = mockearCreditCardServicePagoExitoso(miTarjeta, lollapalooza.valorEntrada)
			comprarEntrada(lollapalooza)

		]
		beatriz = new Usuario() => [
			nombreUsuario = "Beatriz788"
			nombreApellido = "Beatriz Fernandez"
			mail = "bety@gmail.com"
			setDireccion("Gral Paz", 1989, "Llavallol", "Buenos Aires", new Point(-34.785584, -58.420979))
			fechaHoraActual = LocalDateTime.of(2018, 02, 15, 15, 30)
			fechaNacimiento = LocalDate.of(1973, 02, 02)
			miTarjeta = new CreditCard
			servicioTarjeta = mockearCreditCardServicePagoExitoso(miTarjeta, lollapalooza.valorEntrada)
			comprarEntrada(lollapalooza)
			tipoUsuario = new Free()

		]
		// Organizadores
		free1 = new Usuario() => [
			nombreUsuario = "Pablo"
			nombreApellido = "Pablo Gomez"
			mail = "pabloggz@gmail.com"
			setDireccion("Pueyrredon", 580, "San Antonio de Padua", "Buenos Aires", new Point(-34.671249, -58.711178))
			fechaHoraActual = LocalDateTime.of(2018, 05, 15, 19, 00)
			tipoUsuario = new Free()
		]
		// EVENTOS CERRADOS
		casamiento = new EventoCerrado() => [
			nombreEvento = "Casamiento"
			// cantidadDeAcompaniantesMax = 2
			capacidadMaxima = 150
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 05, 25, 23, 59)
			inicioEvento = LocalDateTime.of(2018, 05, 28, 21, 30)
			finEvento = LocalDateTime.of(2018, 05, 29, 06, 00)
			lugar = salonFiesta

		]

		alejandro = new Usuario() => [
			nombreUsuario = "Alej4ndro"
			nombreApellido = "Alejandro Estevanez"
			mail = "alejandro598@gmail.com"
			setDireccion("Independencia", 343, "Pilar", "Buenos Aires", new Point(-34.460323, -58.909506))
			fechaNacimiento = LocalDate.of(1983, 02, 02)
			fechaHoraActual = LocalDateTime.of(2018, 05, 01, 10, 00)
		]
		marco = new Usuario() => [
			nombreUsuario = "MarcoCD"
			nombreApellido = "Marco Sanchez"
			mail = "marquito@gmail.com"
			setDireccion("Moreno", 256, "Pilar", "Buenos Aires", new Point(-34.461846, -58.907565))
			fechaNacimiento = LocalDate.of(1996, 05, 02)
			fechaHoraActual = LocalDateTime.of(2018, 05, 20, 17, 00)
		]
		tomas = new Usuario() => [
			nombreUsuario = "TomasQWE"
			nombreApellido = "Tomas Diaz"
			mail = "tommy@hotmail.com"
			setDireccion("Av Colon", 1090, "Ciudad de Cordoba", "Cordoba", new Point(-31.409261, -64.197778))
			fechaNacimiento = LocalDate.of(1988, 12, 02)
			fechaHoraActual = LocalDateTime.of(2018, 05, 10, 20, 52)
		]
		miriam = new Usuario() => [
			nombreUsuario = "MiriamP"
			nombreApellido = "Miriam Perez"
			mail = "perezmiriam0@gmail.com"
			setDireccion("Falucho", 2520, "Mar del Plata", "Buenos Aires", new Point(-38.005192, -57.551312))
			fechaNacimiento = LocalDate.of(1993, 02, 15)
			fechaHoraActual = LocalDateTime.of(2018, 05, 11, 10, 00)
		]
		even1 = new EventoCerrado() => [
			nombreEvento = "even1"
			inicioEvento = LocalDateTime.of(2018, 05, 31, 14, 00)
			finEvento = LocalDateTime.of(2018, 05, 31, 15, 00)
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 05, 31, 11, 30)
			lugar = salonFiesta
			capacidadMaxima = 20
		]
		even2 = new EventoCerrado() => [
			nombreEvento = "even2"
			inicioEvento = LocalDateTime.of(2018, 05, 31, 14, 00)
			finEvento = LocalDateTime.of(2018, 05, 31, 15, 00)
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 05, 31, 11, 30)
			lugar = hipodromo
			capacidadMaxima = 20
		]
		even3 = new EventoCerrado() => [
			nombreEvento = "even3"
			inicioEvento = LocalDateTime.of(2018, 05, 31, 14, 00)
			finEvento = LocalDateTime.of(2018, 05, 31, 15, 00)
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 05, 31, 11, 30)
			lugar = tecnopolis
			capacidadMaxima = 20

		]
		even4 = new EventoCerrado() => [
			nombreEvento = "even4"
			inicioEvento = LocalDateTime.of(2018, 05, 31, 14, 00)
			finEvento = LocalDateTime.of(2018, 05, 31, 15, 00)
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 05, 31, 11, 30)
			lugar = salonFiesta
			capacidadMaxima = 20

		]
		even5 = new EventoCerrado() => [
			nombreEvento = "even5"
			inicioEvento = LocalDateTime.of(2018, 05, 31, 14, 00)
			finEvento = LocalDateTime.of(2018, 05, 31, 15, 00)
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 05, 31, 11, 30)
			lugar = salonFiesta
			capacidadMaxima = 20

		]
		even6 = new EventoCerrado() => [
			nombreEvento = "even6"
			inicioEvento = LocalDateTime.of(2018, 05, 31, 14, 00)
			finEvento = LocalDateTime.of(2018, 05, 31, 15, 00)
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 05, 31, 11, 30)
			lugar = salonFiesta
			capacidadMaxima = 20

		]
		gaston = new Usuario() => [
			nombreUsuario = "Gaston"
			fechaNacimiento = LocalDate.of(1995, 02, 02)
			fechaHoraActual = LocalDateTime.of(2018, 05, 24, 11, 06)
			tipoUsuario = new Amateur()
		]
		carla = new Usuario() => [
			nombreUsuario = "Carla"
			fechaNacimiento = LocalDate.of(1994, 02, 10)
			fechaHoraActual = LocalDateTime.of(2018, 05, 24, 11, 07)
			tipoUsuario = new Profesional()
		]

		// Servicios
		animacionMago = new Servicios() => [
			tipoTarifa = new TarifaPorHora(300, 12)
			descripcion = "Animacion Mago"
			tarifaPorKilometro = 7
			ubicacionServicio = new Point(-34.515938, -58.485094)
		]
		cateringFoodParty = new Servicios() => [
			descripcion = "Catering Food Party"
			tipoTarifa = new TarifaPersona(15, 0.8)
			tarifaPorKilometro = 5
			ubicacionServicio = new Point(-34.513628, -58.523435)
		]
		candyBarWillyWonka = new Servicios() => [
			descripcion = "candy Bar Willy Wonka"
			tipoTarifa = new TarifaFija(750)
			tarifaPorKilometro = 20
			ubicacionServicio = new Point(-34.569370, -58.484621)
		]
		animacionMagoCostoMinimo = new Servicios() => [
			tipoTarifa = new TarifaPorHora(300, 0)	
			descripcion = "Animacion Mago barato"
			tarifaPorKilometro = 7
			ubicacionServicio = new Point(-34.515938, -58.485094)
		]
	}
		
	def CreditCardService mockearCreditCardServicePagoExitoso(CreditCard tarjeta, double valor) {
		val servicioTarjeta = mock(typeof(CreditCardService))
		when(servicioTarjeta.pay(tarjeta, valor)).thenReturn(new CCResponse()=>[statusCode = 0 statusMessage = "Transaccion Exitosa"])
		return servicioTarjeta
	}
	
	def CreditCardService mockearCreditCardServicePagoRechazado(CreditCard tarjeta, double valor) {
		val servicioTarjeta = mock(typeof(CreditCardService))
		when(servicioTarjeta.pay(tarjeta, valor)).thenReturn(new CCResponse()=>[statusCode = 2 statusMessage = "Pago rechazado"])
		return servicioTarjeta
	}
}