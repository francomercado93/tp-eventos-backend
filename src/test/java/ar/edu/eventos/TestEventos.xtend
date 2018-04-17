package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class TestEventos {

	EventoAbierto soundhearts
	EventoAbierto lollapalooza
	EventoCerrado casamiento
	EventoCerrado cumple
	EventoCerrado minifiesta1
	Locacion salonFiesta
	Locacion hipodromo
	Locacion tecnopolis
	LocalDateTime inicioLolla = LocalDateTime.of(2018, 03, 27, 18, 00)
	LocalDateTime finLolla = LocalDateTime.of(2018, 03, 28, 01, 00)
	LocalDateTime inicioSound = LocalDateTime.of(2018, 04, 14, 18, 00)
	LocalDateTime finSound = LocalDateTime.of(2018, 04, 14, 23, 30)
	Point puntoPrueba = new Point(5, 8)
	double distanciaEsperada = 2849.7
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

	@Before
	def void init() {
		// LOCACIONES
		salonFiesta = new Locacion() => [
			nombre = "Club3"
			puntoGeografico = new Point(9, 6)
			superficie = 10d
		]
		tecnopolis = new Locacion() => [
			nombre = "Tecnopolis"
			puntoGeografico = new Point(2, 5)
			superficie = 6d
		]
		hipodromo = new Locacion() => [
			nombre = "hipodromo San Isidro"
			puntoGeografico = new Point(15, 32)
			superficie = 4.8d
		]

		// EVENTOS ABIERTOS
		soundhearts = new EventoAbierto() => [
			nombreEvento = "Soundhearts"
			inicioEvento = inicioSound
			finEvento = finSound
			lugar = tecnopolis
			edadMinima = 15
			valorEntrada = 0

		]
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
			porcentajeExito = 0.8
		]
		minifiesta1 = new EventoCerrado() => [
			nombreEvento = "minifiesta1"
			inicioEvento = LocalDateTime.of(2018, 05, 31, 14, 00)
			finEvento = LocalDateTime.of(2018, 05, 31, 15, 00)
			fechaMaximaConfirmacion = LocalDateTime.of(2018, 05, 31, 11, 30)
			lugar = salonFiesta
			capacidadMaxima = 20
			porcentajeExito = 0.8
		]
		// PERSONAS
		juan = new Usuario() => [
			nombreUsuario = "juan"
			fechaActual = LocalDateTime.of(2018, 03, 15, 22, 00)
			edad = 18
		]
		martin = new Usuario() => [
			nombreUsuario = "martin"
			fechaActual = LocalDateTime.of(2018, 03, 16, 00, 22)
			edad = 17
		]

		// Usuarios que compran entradas y cumplen requisitos
		maxi = new Usuario() => [
			nombreUsuario = "maxi"
			fechaActual = LocalDateTime.of(2018, 02, 15, 15, 30)
			edad = 40
			comprarEntrada(lollapalooza)
		]
		gaby = new Usuario() => [
			nombreUsuario = "gaby"
			fechaActual = LocalDateTime.of(2017, 09, 02, 20, 15)
			edad = 20
			comprarEntrada(lollapalooza)
		]
		maria = new Usuario() => [
			nombreUsuario = "maria"
			fechaActual = LocalDateTime.of(2018, 02, 27, 05, 00)
			edad = 35
			comprarEntrada(lollapalooza)
		]
		lucas = new Usuario() => [
			nombreUsuario = "lucas"
			fechaActual = LocalDateTime.of(2018, 01, 31, 19, 50)
			edad = 26
			comprarEntrada(lollapalooza)
			puntoDireccionUsuario = new Point(8.95, 6)

		]
		beatriz = new Usuario() => [
			nombreUsuario = "beatriz"
			fechaActual = LocalDateTime.of(2018, 02, 15, 15, 30)
			edad = 45
			comprarEntrada(lollapalooza)
			tipoUsuario = new Free()

		]
		// Organizadores
		free1 = new Usuario() => [
			nombreUsuario = "Pablo"
			fechaActual = LocalDateTime.of(2018, 05, 15, 19, 00)
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
			porcentajeExito = 0.8
			lugar = salonFiesta

		]

		alejandro = new Usuario() => [
			nombreUsuario = "Maria"
			edad = 35
			fechaActual = LocalDateTime.of(2018, 05, 01, 10, 00)
		]
		marco = new Usuario() => [
			nombreUsuario = "Marco"
			edad = 22
			fechaActual = LocalDateTime.of(2018, 05, 20, 17, 00)
		]
		tomas = new Usuario() => [
			nombreUsuario = "Tomas"
			edad = 29
			fechaActual = LocalDateTime.of(2018, 05, 10, 20, 52)
		]
		miriam = new Usuario() => [
			nombreUsuario = "Miriam"
			edad = 25
			fechaActual = LocalDateTime.of(2018, 05, 11, 10, 00)
		]
	}

	@Test
	def void probarDuracion() {
		Assert.assertEquals(7, lollapalooza.duracion, 0.1)
	}

	@Test
	def void probarDistancia() {
		Assert.assertEquals(distanciaEsperada, lollapalooza.distancia(puntoPrueba), 0.1d)
	}

	// Eventos abiertos
	@Test
	def void personaSacaEntrada() {
		juan.comprarEntrada(lollapalooza)
		Assert.assertTrue(lollapalooza.estaInvitado(juan))
	}

	@Test(expected=typeof(BusinessException))
	def void personaNoPuedeSacarEntradaSuperoFechaLimite() {
		martin.comprarEntrada(lollapalooza)
	// Assert.assertFalse(lollapalooza.usuarioEstaATiempo(martin))
	// Assert.assertFalse(lollapalooza.estaInvitado(martin))
	}

	@Test(expected=typeof(BusinessException))
	def void personaNoPuedeSacarEntradaNoTieneEdad() {
		martin.comprarEntrada(lollapalooza)
	// Assert.assertFalse(martin.edad >= lollapalooza.edadMinima)
	// Assert.assertFalse(lollapalooza.estaInvitado(martin))
	}

	@Test
	def void unaPersonaQuiereSacarUnaEntradaYNoQuedanEntradas() { // Compraron 6 entradas y no quedan
		ultimoComprador = new Usuario() => [
			nombreUsuario = "pablo"
			fechaActual = LocalDateTime.of(2018, 03, 15, 16, 45)
			edad = 33
			comprarEntrada(lollapalooza)
		]
		Assert.assertEquals(0, lollapalooza.cantidadDisponibles, 0.1)
	}

	@Test
	def void siUnaPersonaDevuelveEnIntervaloDe7DiasRestantesSeDevuelveUnPorcentaje() {
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
			nombreUsuario = "pablo"
			fechaActual = LocalDateTime.of(2018, 03, 15, 16, 45)
			edad = 33
			comprarEntrada(lollapalooza)
		]
		Assert.assertTrue(lollapalooza.esExitoso)
	}

	@Test
	def void seVendieronMenosDel90PorcientoEntoncesEventoNoEsExitoso() {
		Assert.assertFalse(lollapalooza.esExitoso)
	}

	@Test
	def void seVendieronMenosDel50PorcientoEntoncesEventoEsFracaso() { // Se devuelven 3 entradas, quedan 4 disponibles
		beatriz.devolverEntrada(lollapalooza)
		lucas.devolverEntrada(lollapalooza)
		maria.devolverEntrada(lollapalooza)
		Assert.assertTrue(lollapalooza.esFracaso)
	}
	@Test
	def void seVendieronMasDel50PorcientoYMenosDel90EntoncesEventoNoEsFracaso() {
		beatriz.devolverEntrada(lollapalooza)
		Assert.assertFalse(lollapalooza.esFracaso)
	}

	@Test
	def void personaRecibeInvitacionEsAgregadoAlEvento() {
		beatriz.invitarUsuario(lucas, casamiento, 3)
		Assert.assertTrue(casamiento.estaInvitado(lucas))
	}

	@Test
	def void organizadorFreeCreaEventoSiNoHayEventoEnSimultaneoyNoSuperaLaCantidadMaximaPorMes() {
		free1.crearEvento(casamiento)
		free1.fechaActual = LocalDateTime.of(2018, 05, 29, 16, 00) // free quiere crear un 
		Assert.assertTrue(free1.puedoCrearEvento()) // evento cuando termina otro
		free1.crearEvento(cumple)
		Assert.assertTrue(free1.eventosOrganizados.contains(cumple))
	}

	@Test
	def void organizadorFreeNoCreaEventoSiHayEventoEnSimultaneo() {
		free1.crearEvento(casamiento)
		free1.fechaActual = LocalDateTime.of(2018, 05, 28, 22, 00) // free quiere crear un 
		Assert.assertFalse(free1.puedoCrearEvento()) // evento mientras sucede otro
	}

	@Test
	def void organizadorFreeNoCreaEventoSiSuperaLaCantidadMaximaPorMes() {
		free1.crearEvento(casamiento)
		free1.fechaActual = LocalDateTime.of(2018, 05, 29, 11, 00)
		Assert.assertTrue(free1.puedoCrearEvento())
		free1.crearEvento(cumple)
		free1.fechaActual = LocalDateTime.of(2018, 05, 31, 12, 00)
		Assert.assertTrue(free1.puedoCrearEvento())
		free1.crearEvento(minifiesta1)
		free1.fechaActual = LocalDateTime.of(2018, 05, 31, 16, 00)
		Assert.assertFalse(free1.puedoCrearEvento())
	}

	@Test(expected=typeof(BusinessException))
	def void organizadorFreeNoPuedeInvitarMasDe50Personas() {
		free1.crearEvento(casamiento)
		free1.invitarUsuario(alejandro, casamiento, 10)
		alejandro.confirmarInvitacion(casamiento, 10)
		free1.invitarUsuario(marco, casamiento, 10)
		marco.confirmarInvitacion(casamiento, 10)
		free1.invitarUsuario(tomas, casamiento, 10)
		tomas.confirmarInvitacion(casamiento, 10)
		free1.invitarUsuario(miriam, casamiento, 10)
		miriam.confirmarInvitacion(casamiento, 10)
		free1.invitarUsuario(lucas, casamiento, 10)
		lucas.confirmarInvitacion(casamiento, 10)
		free1.invitarUsuario(maria, casamiento, 10)

	}

	@Test
	def void unUsuarioAceptaUnaInvitacionPendienteSiElOrganizadorEsSuAmigo() {
		lucas.agregarAmigo(beatriz)
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.aceptarPendientes()
		Assert.assertTrue(casamiento.estaConfirmado(lucas))
	}

	@Test
	def void unaUsuarioNoAceptaUnaInvitacionPendienteSiElOrganizadorNoEsSuAmigo() {
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.aceptarPendientes()
		Assert.assertFalse(casamiento.estaConfirmado(lucas))
	}

	@Test
	def void usuarioAceptaInvitacionPendienteSiAsistenMasdeCuatroAmigos() {
		// lucas no es amigo del organizador
		lucas.agregarAmigo(alejandro)
		lucas.agregarAmigo(marco)
		lucas.agregarAmigo(tomas)
		lucas.agregarAmigo(miriam)
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(alejandro, casamiento, 5)
		alejandro.confirmarInvitacion(casamiento, 3)
		beatriz.invitarUsuario(marco, casamiento, 4)
		marco.confirmarInvitacion(casamiento, 4)
		beatriz.invitarUsuario(tomas, casamiento, 2)
		tomas.confirmarInvitacion(casamiento, 2)
		beatriz.invitarUsuario(miriam, casamiento, 3)
		miriam.confirmarInvitacion(casamiento, 3)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.aceptarPendientes()
		Assert.assertTrue(casamiento.estaConfirmado(lucas))
	}

	@Test
	def void usuarioNoAceptaInvitacionPendienteSiNoAsistenMasdeCuatroAmigos() {
		// lucas no es amigo del organizador
		lucas.agregarAmigo(alejandro)
		lucas.agregarAmigo(tomas)
		lucas.agregarAmigo(miriam)
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(alejandro, casamiento, 5)
		alejandro.confirmarInvitacion(casamiento, 3)
		beatriz.invitarUsuario(tomas, casamiento, 2)
		tomas.confirmarInvitacion(casamiento, 2)
		beatriz.invitarUsuario(miriam, casamiento, 3)
		miriam.confirmarInvitacion(casamiento, 3)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.aceptarPendientes()
		Assert.assertFalse(casamiento.estaConfirmado(lucas))
	}

	@Test
	def void usuarioAceptaInvitacionPendienteSiSeEncuentraEnSuRadioDeCercania() {
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.radioCercania = 6
		lucas.aceptarPendientes()
		Assert.assertTrue(casamiento.estaConfirmado(lucas))
	}

	@Test
	def void usuarioNoAceptaInvitacionPendienteSiNoSeEncuentraEnSuRadioDeCercania() {
		lucas.radioCercania = 5
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.aceptarPendientes()
		Assert.assertFalse(casamiento.estaConfirmado(lucas))
	}

	@Test
	def void usuarioAntisocialRechazaInvitacionPendienteSiSeEncuentraFueraDeSuRadioDeCercania() {
		lucas.radioCercania = 5
		lucas.esAntisocial = true
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.rechazarPendientes() // cuando se rechaza la invitacion, se lo saca de la
		Assert.assertFalse(casamiento.estaInvitado(lucas)) // lista de pendientes del evento
	}

	@Test
	def void usuarioAntisocialRechazaInvitacionPendienteSiNoAsistenAlMenosDosAmigos() {
		lucas.radioCercania = 90
		lucas.esAntisocial = true
		lucas.agregarAmigo(miriam) // asiste un amigo
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		beatriz.invitarUsuario(miriam, casamiento, 3)
		miriam.confirmarInvitacion(casamiento, 3)
		lucas.rechazarPendientes() // cuando se rechaza la invitacion, se lo saca de la
		Assert.assertFalse(casamiento.estaInvitado(lucas)) // lista de pendientes del evento
	}

	@Test
	def void noAntisocialRechazaPendienteSiSeEncuentraFueraDeSuRadioDeCercaniaYNoAsisteNingunAmigo() {
		lucas.radioCercania = 5
		lucas.esAntisocial = false
		lucas.agregarAmigo(miriam) // lucas tiene amigos
		lucas.agregarAmigo(juan) // juan no es invitado
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(miriam, casamiento, 3) // miriam no confirma que asiste
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.rechazarPendientes() // cuando se rechaza la invitacion, se lo saca de la
		Assert.assertFalse(casamiento.estaInvitado(lucas)) // lista de pendientes del evento
	}

	@Test
	def void siCanceloElEventoSeDevuelveElDineroATodos() {
		lollapalooza.cancelarEvento() // Compraron entradas: maxi, gaby, maria, lucas, beatriz
		Assert.assertEquals(500, maxi.saldoAFavor, 0.1)
		Assert.assertEquals(500, gaby.saldoAFavor, 0.1)
		Assert.assertEquals(500, maria.saldoAFavor, 0.1)
		Assert.assertEquals(500, lucas.saldoAFavor, 0.1)
		Assert.assertEquals(500, beatriz.saldoAFavor, 0.1)
	}

	@Test
	def void siSeReprogramaLaFechaElEventoTieneLaMismaDuracion() {
		lollapalooza.reprogramarEvento(LocalDateTime.of(2018, 03, 28, 19, 00))
		Assert.assertEquals(7, lollapalooza.duracion, 0.1)
	}

	@Test
	def void siSeReprogramaEventoUsuarioDevuelveEntradaPorEl100DeSuValor() {
		lollapalooza.postergarEvento(LocalDateTime.of(2018, 03, 28, 19, 00))
		maxi.devolverEntradaSiEventoEstaPostergado(lollapalooza)
		Assert.assertFalse(lollapalooza.asistentes.contains(maxi))
		Assert.assertEquals(500, maxi.saldoAFavor, 0.1)
	}

}
