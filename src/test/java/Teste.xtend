import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class Teste {

	EventoAbierto fiesta
	EventoAbierto lollapalooza
	EventoCerrado casamiento
//	EventoCerrado cumple
	Locacion estadio1
	Locacion hipodromo
	LocalDateTime inicio = LocalDateTime.of(2018, 03, 27, 18, 00)
	LocalDateTime fin = LocalDateTime.of(2018, 03, 28, 01, 00)
	Usuario juan
	Usuario martin

	Point puntoPrueba = new Point(5, 8)
	double distanciaEsperada = 496.51d
	Usuario maxi
	Usuario beatriz
	Usuario lucas
	Usuario maria
	Usuario gaby
	Usuario ultimoComprador

	@Before
	def void init() {
		//LOCACIONES
		estadio1 = new Locacion() => [
			nombre = "obras"
			puntoGeografico = new Point(9, 6)
		]
		hipodromo = new Locacion() => [
			nombre = "hipodromo San Isidro"
			puntoGeografico = new Point(15, 32)
			superficie = 4.8d
		]
		
		//EVENTOS ABIERTOS
		fiesta = new EventoAbierto() => [
			nombreEvento = "fest"
			fechaInicio = inicio
			fechaHasta = fin
			lugar = estadio1

		]
		lollapalooza = new EventoAbierto() => [
			nombreEvento = "lollapalooza"
			fechaInicio = inicio
			fechaHasta = fin
			lugar = hipodromo
			fechaMaxima = LocalDateTime.of(2018, 03, 15, 23, 59)
			edadMinima = 18
			valorEntrada = 500
		]
		
		//EVENTOS CERRADOS
		casamiento = new EventoCerrado() => [

			cantidadDeAcompaniantesMax = 2
			capacidadMaxima = 150
			fechaMaxima = LocalDateTime.of(2018, 05, 25, 23, 59)
			porcentajeExito = 0.8

		]
		
		//PERSONAS
		juan = new Usuario() => [
			nombre = "juan"
			fechaActual = LocalDateTime.of(2018, 03, 15, 22, 00)
			edad = 17
		]
		martin = new Usuario() => [
			nombre = "martin"
			fechaActual = LocalDateTime.of(2018, 03, 16, 00, 22)
			edad = 22
		]
		// Usuarios que compran entradas y cumplen requisitos
		maxi = new Usuario() => [
			nombre = "maxi"
			fechaActual = LocalDateTime.of(2018, 02, 15, 15, 30)
			edad = 40
			comprarEntradas(lollapalooza)
		]
		gaby = new Usuario() => [
			nombre = "gaby"
			fechaActual = LocalDateTime.of(2017, 09, 02, 20, 15)
			edad = 20
			comprarEntradas(lollapalooza)
		]
		maria = new Usuario() => [
			nombre = "maria"
			fechaActual = LocalDateTime.of(2018, 02, 27, 05, 00)
			edad = 35
			comprarEntradas(lollapalooza)
		]
		lucas = new Usuario() => [
			nombre = "lucas"
			fechaActual = LocalDateTime.of(2018, 01, 31, 19, 50)
			edad = 26
			comprarEntradas(lollapalooza)
		]
		beatriz = new Usuario() => [
			nombre = "beatriz"
			fechaActual = LocalDateTime.of(2018, 02, 15, 15, 30)
			edad = 45
			comprarEntradas(lollapalooza)

		]

	}

	@Test
	def void ProbarDuracion() {
		Assert.assertEquals(7, fiesta.duracion, 0.1)
	}

	@Test
	def void ProbarDistancia() {
		Assert.assertEquals(distanciaEsperada, fiesta.distancia(puntoPrueba), 0.1d)
	}

	@Test
	def void siUnaLocacionTieneUnaSuperficieElEventoTieneUnaCapacidadMaxima() {
		Assert.assertEquals(6, lollapalooza.capacidadMaxima(), 0.1d)
	}

	@Test
	def void unaPersonaQuiereSacarUnaEntradaNoSuperaFechaMaxima() {
		Assert.assertTrue(juan.fechaActual.isBefore(lollapalooza.fechaMaxima))
	}

	@Test
	def void unaPersonaQuiereSacarUnaEntradaYSuperaFechaMaxima() {
		Assert.assertTrue(martin.fechaActual.isAfter(lollapalooza.fechaMaxima))
	}

	@Test
	def void unaPersonaQuiereSacarUnaEntradaYNoSuperaEdadMinima() {
		Assert.assertTrue(juan.edad < lollapalooza.edadMinima)
	}

	@Test
	def void unaPersonaQuiereSacarUnaEntradaYSuperaEdadMinima() {
		Assert.assertTrue(martin.edad > lollapalooza.edadMinima)
	}

	@Test
	def void unaPersonaQuiereSacarUnaEntradaYQuedanEntradas() {
		Assert.assertTrue(lollapalooza.cantidadDisponibles > 0) // Compraron 5 entradas y queda 1
	}

	@Test
	def void unaPersonaQuiereSacarUnaEntradaYNoQuedanEntradas() { // Compraron 6 entradas y no quedan
		ultimoComprador = new Usuario() => [
			nombre = "pablo"
			fechaActual = LocalDateTime.of(2018, 03, 15, 16, 45)
			edad = 33
			comprarEntradas(lollapalooza)
		]
		Assert.assertTrue(lollapalooza.cantidadDisponibles == 0)
	}

	@Test
	def void siUnaPersonaDevuelveEnIntervaloDe7DiasRestantesSeDevuelveUnaParteDelValor() {
		martin.fechaActual = LocalDateTime.of(2018, 03, 09, 22, 00)
		martin.devolverEntrada(lollapalooza)
		Assert.assertEquals(350d, martin.saldoAFavor, 0.1)
	}

	@Test
	def void siUnaPersonaDevuelveEntradaAntesDe7DiasSeDevuelve80Porciento() {
		martin.fechaActual = LocalDateTime.of(2018, 03, 06, 22, 00)
		martin.devolverEntrada(lollapalooza)
		Assert.assertEquals(400, martin.saldoAFavor, 0.1)
	}

	@Test
	def void seVendieronMasDel90PorcientoEntoncesEventoEsExitoso() {
		ultimoComprador = new Usuario() => [
			nombre = "pablo"
			fechaActual = LocalDateTime.of(2018, 03, 15, 16, 45)
			edad = 33
			comprarEntradas(lollapalooza)
		]
		Assert.assertTrue(lollapalooza.esExitoso)
	}

	@Test
	def void seVendieronMenosDel50PorcientoEntoncesEventoEsFracaso() { // Se devuelven 3 entradas, quedan 4 disponibles
		beatriz.devolverEntrada(lollapalooza)
		lucas.devolverEntrada(lollapalooza)
		maria.devolverEntrada(lollapalooza)

		Assert.assertTrue(lollapalooza.esFracaso)
	}
	//En estos casos organizador = usuario
	@Test
	def void PersonaRecibeInvitacionCumpleCondicionesYEsAgregadoAlEvento() {

		beatriz.invitarUsuario(lucas, casamiento)
		Assert.assertTrue(casamiento.estaInvitado(lucas))

	}
	@Test
	def void PersonaRecibeInvitacionNoCumpleCondicionesYNoEsAgregadoAlEvento() {

		
		Assert.assertTrue(true)

	}

	@Test
	def void personaRecibeInvitacionYSuperaFechaMaxima() {
		
	}
	@Test
	def void personaRecibeInvitacionYNoSuperaFechaMaxima() {
		
	}
	@Test
	def void personaRecibeInvitacionYSuperaCantidadAcompaniantesMaxima() {
		
	}
	@Test
	def void personaRecibeInvitacionYNOSuperaCantidadAcompaniantesMaxima() {
		
	}
	@Test
	def void personaRecibeInvitacionYHayCapacidad() {
		
	}
	@Test
	def void personaRecibeInvitacionYNoHayCapacidad() {
		
	}
	@Test
	def void personaConfirmaInvitacionYApareceEnLista() {
		
	}
	@Test
	def void personaRechazaInvitacionYNoApareceEnLista() {
		
	}
}
