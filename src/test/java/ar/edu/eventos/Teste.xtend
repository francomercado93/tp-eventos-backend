package ar.edu.eventos

import ar.edu.eventos.EventoAbierto
import ar.edu.eventos.EventoCerrado
import ar.edu.eventos.Free
import ar.edu.eventos.Locacion
import ar.edu.eventos.Usuario
import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class Teste {

	EventoAbierto soundhearts
	EventoAbierto lollapalooza
	EventoCerrado casamiento
	EventoCerrado cumple
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
			fechaInicio = inicioSound
			fechaHasta = finSound
			lugar = tecnopolis
			edadMinima = 15
			valorEntrada = 0

		]
		lollapalooza = new EventoAbierto() => [
			nombreEvento = "lollapalooza"
			fechaInicio = inicioLolla
			fechaHasta = finLolla
			lugar = hipodromo
			fechaMaxima = LocalDateTime.of(2018, 03, 15, 23, 59)
			edadMinima = 18
			valorEntrada = 500

		]

		cumple = new EventoCerrado() => [
			nombreEvento = "cumple Julian"
			organizador = juan
			fechaInicio = LocalDateTime.of(2018, 05, 30, 18, 30)
			fechaHasta = LocalDateTime.of(2018, 05, 30, 23, 00)
			lugar = salonFiesta
			cantidadDeAcompaniantesMax = 3
			capacidadMaxima = 20
			fechaMaxima = LocalDateTime.of(2018, 05, 18, 21, 00)
			porcentajeExito = 0.8
		]

		// PERSONAS
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
			puntoDireccionUsuario = new Point(8.95, 6)

		]
		beatriz = new Usuario() => [
			nombre = "beatriz"
			fechaActual = LocalDateTime.of(2018, 02, 15, 15, 30)
			edad = 45
			comprarEntradas(lollapalooza)
			tipo = new Free() => [
				cantidadInvitados = 12
			]

		]
		// Organizadores
		free1 = new Usuario() => [
			nombre = "Pablo"
			fechaActual = LocalDateTime.of(2018, 05, 15, 19, 00)
			tipo = new Free()
		]
		// EVENTOS CERRADOS
		casamiento = new EventoCerrado() => [
			nombreEvento = "Casamiento"
			cantidadDeAcompaniantesMax = 2
			capacidadMaxima = 150
			fechaMaxima = LocalDateTime.of(2018, 05, 25, 23, 59)
			fechaInicio = LocalDateTime.of(2018, 05, 28, 21, 30)
			fechaHasta = LocalDateTime.of(2018, 05, 29, 06, 00)
			porcentajeExito = 0.8
			lugar = salonFiesta

		]

		alejandro = new Usuario() => [
			nombre = "Maria"
			edad = 35
			fechaActual = LocalDateTime.of(2018, 05, 01, 10, 00)
		]
		marco = new Usuario() => [
			nombre = "Marco"
			edad = 22
			fechaActual = LocalDateTime.of(2018, 05, 20, 17, 00)
		]
		tomas = new Usuario() => [
			nombre = "Tomas"
			edad = 29
			fechaActual = LocalDateTime.of(2018, 05, 10, 20, 52)
		]
		miriam = new Usuario() => [
			nombre = "Miriam"
			edad = 25
			fechaActual = LocalDateTime.of(2018, 05, 11, 10, 00)
		]
	}

	@Test
	def void ProbarDuracion() {
		Assert.assertEquals(7, lollapalooza.duracion, 0.1)
	}

	@Test
	def void ProbarDistancia() {
		Assert.assertEquals(distanciaEsperada, lollapalooza.distancia(puntoPrueba), 0.1d)
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

	// En estos casos organizador = usuario
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

	

	@Test
	def void unaUsuarioAceptaUnaInvitacionPendienteSiElOrganizadorEsSuAmigo() {
		lucas.agregarAmigo(beatriz)
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento)
		lucas.aceptarPendientes()
		Assert.assertTrue(casamiento.estaConfirmado(lucas))
	}

	@Test
	def void unaUsuarioNoAceptaUnaInvitacionPendienteSiElOrganizadorNoEsSuAmigo() {
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento)
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
		beatriz.invitarUsuario(alejandro, casamiento)
		alejandro.confirmarInvitacion(casamiento)
		beatriz.invitarUsuario(marco, casamiento)
		marco.confirmarInvitacion(casamiento)
		beatriz.invitarUsuario(tomas, casamiento)
		tomas.confirmarInvitacion(casamiento)
		beatriz.invitarUsuario(miriam, casamiento)
		miriam.confirmarInvitacion(casamiento)
		beatriz.invitarUsuario(lucas, casamiento)
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
		beatriz.invitarUsuario(alejandro, casamiento)
		alejandro.confirmarInvitacion(casamiento)
		beatriz.invitarUsuario(tomas, casamiento)
		tomas.confirmarInvitacion(casamiento)
		beatriz.invitarUsuario(miriam, casamiento)
		miriam.confirmarInvitacion(casamiento)
		beatriz.invitarUsuario(lucas, casamiento)
		lucas.aceptarPendientes()
		Assert.assertFalse(casamiento.estaConfirmado(lucas))
	}

	@Test
	def void usuarioAceptaInvitacionPendienteSiSeEncuentraEnSuRadioDeCercania() {
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento)
		lucas.radioCercania = 6
		lucas.aceptarPendientes()
		Assert.assertTrue(casamiento.estaConfirmado(lucas))
	}

	@Test
	def void usuarioNoAceptaInvitacionPendienteSiNoSeEncuentraEnSuRadioDeCercania() {
		lucas.radioCercania = 5
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento)
		lucas.aceptarPendientes()
		Assert.assertFalse(casamiento.estaConfirmado(lucas))
	}
	@Test
	def void usuarioAntisocialRechazaInvitacionPendienteSiSeEncuentraFueraDeSuRadioDeCercania() {
		lucas.radioCercania = 5
		lucas.esAntisocial = true
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento)
		lucas.rechazarPendientes()		//cuando se rechaza la invitacion, se lo saca de la
		Assert.assertFalse(casamiento.estaInvitado(lucas))	//lista de pendientes del evento
	}
	@Test
	def void usuarioAntisocialRechazaInvitacionPendienteSiNoAsistenAlMenosDosAmigos() {
		lucas.radioCercania = 90
		lucas.esAntisocial = true
		lucas.agregarAmigo(miriam)		//asiste un amigo
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento)
		beatriz.invitarUsuario(miriam, casamiento)
		miriam.confirmarInvitacion(casamiento)
		lucas.rechazarPendientes()		//cuando se rechaza la invitacion, se lo saca de la
		Assert.assertFalse(casamiento.estaInvitado(lucas))	//lista de pendientes del evento
	}
	@Test
	def void noAntisocialRechazaPendienteSiSeEncuentraFueraDeSuRadioDeCercaniaYNoAsisteNingunAmigo() {
		lucas.radioCercania = 5
		lucas.esAntisocial = false
		lucas.agregarAmigo(miriam)		//lucas tiene amigos
		lucas.agregarAmigo(juan)		//juan no es invitado
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(miriam, casamiento) //miriam no confirma que asiste
		beatriz.invitarUsuario(lucas, casamiento)
		lucas.rechazarPendientes()		//cuando se rechaza la invitacion, se lo saca de la
		Assert.assertFalse(casamiento.estaInvitado(lucas))	//lista de pendientes del evento
	}
	@Test
	def void siCanceloElEventoSeDevuelveElDineroATodos(){
		lollapalooza.cancelarEvento()			//Compraron entradas: maxi, gaby, maria, lucas, beatriz
		Assert.assertEquals(500, maxi.saldoAFavor, 0.1)
		Assert.assertEquals(500, gaby.saldoAFavor, 0.1)
		Assert.assertEquals(500, maria.saldoAFavor, 0.1)
		Assert.assertEquals(500, lucas.saldoAFavor, 0.1)
		Assert.assertEquals(500, beatriz.saldoAFavor, 0.1)
	}
	@Test
	def void siSeReprogramaLaFechaElEventoTieneLaMismaDuracion(){
		lollapalooza.reprogramarEvento(LocalDateTime.of(2018, 03, 28, 19, 00))
		Assert.assertEquals(7, lollapalooza.duracion, 0.1)
	}
	@Test
	def void siSeReprogramaEventoUsuarioDevuelveEntradaPorEl100DeSuValor(){
		lollapalooza.postergarEvento(LocalDateTime.of(2018, 03, 28, 19, 00))
		maxi.devolverEntradaSiEventoEstaPostergado(lollapalooza)
		Assert.assertFalse(lollapalooza.asistentes.contains(maxi))
		Assert.assertEquals(500, maxi.saldoAFavor, 0.1)
	}
		
	@Test
	def void siUnOrganizadorFreeCreaUnEventoYNoHayUnEventoEnSimultaneoPuedeOrganizar() {
		free1.crearEvento(casamiento)
		free1.fechaActual = LocalDateTime.of(2018, 05, 29, 16, 00)		//free quiere crear un 
		Assert.assertTrue(free1.puedoCrearElEvento(cumple))			//evento cuando termina otro
		free1.crearEvento(cumple)
		Assert.assertTrue(free1.eventosOrganizados.contains(casamiento))
	}
	
	@Test
	def void siUnOrganizadorFreeCreaUnEventoPeroHayUnEventoEnSimultaneoNoPuedeOrganizar() {
		free1.crearEvento(casamiento)
		free1.fechaActual = LocalDateTime.of(2018, 05, 28, 22, 00)		//free quiere crear un 
		Assert.assertFalse(free1.puedoCrearElEvento(cumple))			//evento mientras sucede otro
	}

	/* @Test
	def void siUnOrganizadorFreeCreaUnEventoPeroNoHayUnEventoEnSimultaneoPuedeOrganizar() {
		Assert.assertFalse(free1.hayUnEventoActualmente)
	}*/
	/*
	@Test
	def void usuarioFreeQuiereOrganizarCerradounEventoYHayUnEventoEnEseMomento() {

		Assert.assertFalse(false beatriz.puedeOrganizarEvento()
	}
	*/
	
}