package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.main.Main
import ar.edu.repositorios.RepositorioServicio
import ar.edu.repositorios.RepositorioUsuarios
import ar.edu.servicios.Servicios
import ar.edu.servicios.TarifaFija
import ar.edu.servicios.TarifaPersona
import ar.edu.servicios.TarifaPorHora
import ar.edu.usuarios.Amateur
import ar.edu.usuarios.Free
import ar.edu.usuarios.Profesional
import ar.edu.usuarios.Usuario
import com.eclipsesource.json.Json
import java.io.FileReader
import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class TestEventos {

	//EventoAbierto soundhearts
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
	LocalDateTime inicioLolla = LocalDateTime.of(2018, 03, 27, 18, 00)
	LocalDateTime finLolla = LocalDateTime.of(2018, 03, 28, 01, 00)
	//LocalDateTime inicioSound = LocalDateTime.of(2018, 04, 14, 18, 00)
	//LocalDateTime finSound = LocalDateTime.of(2018, 04, 14, 23, 30)
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
	Servicios animacionMago
	Servicios cateringFoodParty
	Servicios candyBarWillyWonka
	
	@Before
	def void init() {
		// LOCACIONES
		salonFiesta = new Locacion() => [
			descripcion = "Club3"
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

		// EVENTOS ABIERTOS
		/*soundhearts = new EventoAbierto() => [
			nombreEvento = "Soundhearts"
			inicioEvento = inicioSound
			finEvento = finSound
			lugar = tecnopolis
			edadMinima = 15
			valorEntrada = 0

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
		juan = new Usuario() => [
			nombreUsuario = "juan"
			nombreApellido ="Juan Martin del Potro"
			mail = "juan00@gmail.com"
			setDireccion("Quintana", 2551, "San Martin", "Buenos Aires", new Point(-34.578651, -58.549614))
			fechaActual = LocalDateTime.of(2018, 03, 15, 22, 00)
			fechaNacimiento = LocalDateTime.of(2000, 01, 02, 05, 25)
		]
		martin = new Usuario() => [
			nombreUsuario = "martin"
			nombreApellido = "Martin Benitez"
			mail = "juan00@gmail.com"
			setDireccion("America", 3450, "San Martin", "Buenos Aires", new Point(-34.560245, -58.546651))
			fechaActual = LocalDateTime.of(2018, 03, 16, 00, 22)
			fechaNacimiento = LocalDateTime.of(2001, 05, 12, 15,55)
			
		]

		// Usuarios que compran entradas y cumplen requisitos
		maxi = new Usuario() => [
			nombreUsuario = "maxi5"
			nombreApellido = "Maxi Coronel"
			mail = "maxigg@gmail.com"
			setDireccion("Carlos Francisco Melo", 2356, "Vicente Lopez", "Buenos Aires", new Point(-34.534199, -58.490467))
			fechaActual = LocalDateTime.of(2018, 02, 15, 15, 30)
			fechaNacimiento = LocalDateTime.of(1977, 08, 09, 22, 25)
			comprarEntrada(lollapalooza)
		]
		gaby = new Usuario() => [
			nombreUsuario = "Gaby555"
			nombreApellido = "Gabriel Martinez"
			mail = "gaby_44@gmail.com"
			setDireccion("Av. Maipú 3144", 2356, "Olivos", "Buenos Aires", new Point(-34.507145, -58.492910))
			fechaActual = LocalDateTime.of(2017, 09, 02, 20, 15)
			fechaNacimiento = LocalDateTime.of(1996, 10, 15, 00, 25)
			comprarEntrada(lollapalooza)
		]
		maria = new Usuario() => [
			nombreUsuario = "MariaSanchez4"
			nombreApellido = "Maria Sanchez"
			mail = "sanchezmaria@hotmail.com"
			setDireccion("Av. Bartolomé Mitre" , 4787, "Caseros", "Buenos Aires", new Point(-34.609812, -58.563639))
			fechaActual = LocalDateTime.of(2018, 02, 27, 05, 00)
			fechaNacimiento = LocalDateTime.of(1983, 02, 02, 12, 00)
			comprarEntrada(lollapalooza)
		]
		lucas = new Usuario() => [
			nombreUsuario = "Lucas41"
			nombreApellido = "Lucas Benitez"
			mail = "lucasb@gmail.com"
			setDireccion("Nogoya" , 3460, "Villa del Parque", "CABA", new Point(-34.605375, -58.496150))
			fechaActual = LocalDateTime.of(2018, 01, 31, 19, 50)
			fechaNacimiento = LocalDateTime.of(1991, 11, 11, 12, 00)
			comprarEntrada(lollapalooza)

		]
		beatriz = new Usuario() => [
			nombreUsuario = "Beatriz788"
			nombreApellido = "Beatriz Fernandez"
			mail = "bety@gmail.com"
			setDireccion("Gral Paz" , 1989, "Llavallol", "Buenos Aires", new Point(-34.785584, -58.420979))
			fechaActual = LocalDateTime.of(2018, 02, 15, 15, 30)
			fechaNacimiento = LocalDateTime.of(1973, 02, 02, 12, 00)
			comprarEntrada(lollapalooza)
			tipoUsuario = new Free()

		]
		// Organizadores
		free1 = new Usuario() => [
			nombreUsuario = "Pablo"
			nombreApellido = "Pablo Gomez"
			mail = "pabloggz@gmail.com"
			setDireccion("Pueyrredon" , 580, "San Antonio de Padua", "Buenos Aires", new Point(-34.671249, -58.711178))
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
			lugar = salonFiesta

		]

		alejandro = new Usuario() => [
			nombreUsuario = "Alej4ndro"
			nombreApellido = "Alejandro Estevanez"
			mail = "alejandro598@gmail.com"
			setDireccion("Independencia" , 343, "Pilar", "Buenos Aires", new Point(-34.460323, -58.909506))
			fechaNacimiento = LocalDateTime.of(1983, 02, 02, 12, 00)
			fechaActual = LocalDateTime.of(2018, 05, 01, 10, 00)
		]
		marco = new Usuario() => [
			nombreUsuario = "MarcoCD"
			nombreApellido = "Marco Sanchez"
			mail = "marquito@gmail.com"
			setDireccion("Moreno" , 256, "Pilar", "Buenos Aires", new Point(-34.461846, -58.907565))
			fechaNacimiento = LocalDateTime.of(1996, 05, 02, 12, 00)
			fechaActual = LocalDateTime.of(2018, 05, 20, 17, 00)
		]
		tomas = new Usuario() => [
			nombreUsuario = "TomasQWE"
			nombreApellido = "Tomas Diaz"
			mail = "tommy@hotmail.com"
			setDireccion("Av Colon" , 1090, "Ciudad de Cordoba", "Cordoba", new Point(-31.409261, -64.197778))
			fechaNacimiento = LocalDateTime.of(1988, 12, 02, 12, 00)
			fechaActual = LocalDateTime.of(2018, 05, 10, 20, 52)
		]
		miriam = new Usuario() => [
			nombreUsuario = "MiriamP"
			nombreApellido = "Miriam Perez"
			mail = "perezmiriam0@gmail.com"
			setDireccion("Falucho" , 2520, "Mar del Plata", "Buenos Aires", new Point(-38.005192, -57.551312))
			fechaNacimiento = LocalDateTime.of(1993, 02, 15, 12, 00)
			fechaActual = LocalDateTime.of(2018, 05, 11, 10, 00)
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
		gaston = new Usuario() =>[
			nombreUsuario = "Gaston"
			fechaNacimiento = LocalDateTime.of(1995, 02, 02, 12, 00)
			fechaActual = LocalDateTime.of(2018, 05, 24, 11, 06)
			tipoUsuario = new Amateur()
		]
		carla = new Usuario() =>[
			nombreUsuario = "Carla"
			fechaNacimiento = LocalDateTime.of(1994, 02, 10, 12, 00)
			fechaActual = LocalDateTime.of(2018, 05, 24, 11, 07)
			tipoUsuario = new Profesional()
		]
		
		//Servicios
		animacionMago = new Servicios() =>[
			tipoTarifa = new TarifaPorHora(300, 12)
			descripcion = "animacionMago"
			tarifaPorKilometro = 7
			ubicacionServicio = new Point(-34.515938, -58.485094)
		]
		cateringFoodParty = new Servicios() =>[
			descripcion = "cateringFoodParty"
			tipoTarifa = new TarifaPersona(15, 0.8)
			tarifaPorKilometro = 5
			ubicacionServicio = new Point(-34.513628, -58.523435)
		]
		candyBarWillyWonka = new Servicios() =>[
			//descripcion = "candyBarWillyWonka"
			tipoTarifa = new TarifaFija(750)
			tarifaPorKilometro = 20
			ubicacionServicio = new Point(-34.569370, -58.484621)
		]
	}

	@Test
	def void probarDuracion() {
		Assert.assertEquals(7, lollapalooza.duracion, 0.1)
	}

	@Test
	def void probarDistancia() {
		Assert.assertEquals(10.81, lollapalooza.distancia(puntoPrueba), 0.1d)
	}
	@Test
	def void probarCapacidadMaximaEventoAbierto() {
		Assert.assertEquals(6, lollapalooza.capacidadMaxima(), 0.1d)
	}

	// Eventos abiertos
	@Test
	def void personaSacaEntrada() {
		juan.comprarEntrada(lollapalooza)
		Assert.assertTrue(lollapalooza.estaInvitado(juan))
	}

	@Test(expected=typeof(BusinessException))
	def void personaNoPuedeSacarEntradaSuperoFechaLimite() {//Quedan entradas y tiene edad minima
		martin.fechaNacimiento = LocalDateTime.of(1999, 01, 01, 00, 00)
		martin.comprarEntrada(lollapalooza)
	}

	@Test(expected=typeof(BusinessException))
	def void personaNoPuedeSacarEntradaNoTieneEdadMinima() {
		martin.fechaActual = LocalDateTime.of(2018, 03, 15, 16, 45)//Esta a tiempo y quedan entradas disponibles
		martin.comprarEntrada(lollapalooza)
	}

	@Test(expected=typeof(BusinessException))
	def void unaPersonaQuiereSacarUnaEntradaYNoQuedanEntradas() { // Compraron 6 entradas y no quedan
		ultimoComprador = new Usuario() => [
			nombreUsuario = "pablo"
			fechaActual = LocalDateTime.of(2018, 03, 15, 16, 45)
			fechaNacimiento = LocalDateTime.of(1985, 03, 15, 00, 00)
		]
		ultimoComprador.comprarEntrada(lollapalooza)
		martin.comprarEntrada(lollapalooza)
	}

	@Test(expected=typeof(BusinessException))
	def void siUnaPersonaQuiereDevolverEntradaPeroNoTieneSistemaNoLoDeja() {
		juan.devolverEntrada(lollapalooza)
	}
	
	@Test(expected=typeof(BusinessException))
	def void siUnaPersonaQuiereDevolverEntradaElMismoDiaDElEvento() {
		juan.comprarEntrada(lollapalooza)
		juan.fechaActual = LocalDateTime.of(2018, 03, 15, 09, 30) //Devuelve en la fecha de confirmacion
		println(lollapalooza.diasfechaMaximaConfirmacion(juan))
		juan.devolverEntrada(lollapalooza)
	}
	
	@Test
	def void siUnaPersonaDevuelveEnIntervaloDe7DiasRestantesSeDevuelveUnPorcentaje() {//compra entrada y se arrepiente
		juan.fechaActual = LocalDateTime.of(2018, 03, 09, 22, 00)
		juan.comprarEntrada(lollapalooza)
		juan.devolverEntrada(lollapalooza)
		Assert.assertEquals(350d, juan.saldoAFavor, 0.1)
		Assert.assertEquals(1, lollapalooza.cantidadDisponibles, 0.1)
	}

	@Test
	def void siUnaPersonaDevuelveEntradaAntesDe7DiasSeDevuelve80Porciento() {
		juan.fechaActual = LocalDateTime.of(2018, 03, 06, 22, 00)
		juan.comprarEntrada(lollapalooza)
		juan.devolverEntrada(lollapalooza)
		Assert.assertEquals(400, juan.saldoAFavor, 0.1)
		Assert.assertEquals(1, lollapalooza.cantidadDisponibles, 0.1)
	}

	@Test
	def void seVendieronMasDel90PorcientoEntoncesEventoEsExitoso() {
		ultimoComprador = new Usuario() => [
			nombreUsuario = "pablo"
			fechaActual = LocalDateTime.of(2018, 03, 15, 16, 45)
			fechaNacimiento = LocalDateTime.of(1985, 03, 15, 00, 00)
			comprarEntrada(lollapalooza)
		]
		Assert.assertTrue(lollapalooza.esExitoso)
	}

	@Test
	def void seVendieronMenosDel90PorcientoEntoncesEventoNoEsExitoso() {
		Assert.assertFalse(lollapalooza.esExitoso)
	}

	@Test
	def void seVendieronMenosDel50PorcientoEntoncesEventoEsFracaso() { // Se devuelven 3 entradas, quedan 4 disponibles de las 6
		beatriz.devolverEntrada(lollapalooza)
		lucas.devolverEntrada(lollapalooza)
		maria.devolverEntrada(lollapalooza)
		Assert.assertEquals(6, lollapalooza.capacidadMaxima, 0.1)
		Assert.assertEquals(4, lollapalooza.cantidadDisponibles, 0.1)
		Assert.assertTrue(lollapalooza.esFracaso)
	}
	@Test
	def void seVendieronMasDel50PorcientoYMenosDel90EntoncesEventoNoEsFracasoYNoEsExitoso() {
		beatriz.devolverEntrada(lollapalooza)
		Assert.assertEquals(6, lollapalooza.capacidadMaxima, 0.1)
		Assert.assertEquals(2, lollapalooza.cantidadDisponibles, 0.1)
		Assert.assertFalse(lollapalooza.esFracaso)
		Assert.assertFalse(lollapalooza.esExitoso)
	}
	//EVENTOS CERRADOS
	//INVITACIONES
	
	@Test
	def void personaRecibeInvitacionEsAgregadoAlEvento() {
		beatriz.invitarUsuario(lucas, casamiento, 3)
		Assert.assertTrue(casamiento.estaInvitado(lucas))
	}
	
	@Test(expected=typeof(BusinessException))
	def void personaNoPuedeConfirmarInvitacionSiSuperaLaCantidadMaximaAcompaniantes() {
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.confirmarInvitacion(casamiento, 4)
	}
	
	@Test(expected=typeof(BusinessException))
	def void personaNoPuedeConfirmarInvitacionSiSuperaFechaMaximaDeConfirmacion() {
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.fechaActual = LocalDateTime.of(2018, 05, 26, 23, 59)	//fecha maxima de confirmacion es 2018, 05, 25, 23, 59)
		lucas.confirmarInvitacion(casamiento, 2)
	}
	
	@Test(expected=typeof(BusinessException))
	def void organizadorNoPuedeRealizarInvitacionConCantidadAcompaniantesQueExcedeCapacidadMaxima() {
		free1.crearEvento(casamiento)
		free1.invitarUsuario(alejandro, casamiento, 10)
		alejandro.confirmarInvitacion(casamiento, 10)
		free1.invitarUsuario(marco, casamiento, 10)
		marco.confirmarInvitacion(casamiento, 10)
		free1.invitarUsuario(tomas, casamiento, 10)
		tomas.confirmarInvitacion(casamiento, 10)
		free1.invitarUsuario(miriam, casamiento, 10)
		println(casamiento.cantidadAsistentesPosibles)
		free1.invitarUsuario(lucas, casamiento, 6)//No se puede tiene 44 invitados mas 6+1 de la nueva invitacion, la invitacion puede ser de 5+1 o menos
		}
		
		@Test(expected=typeof(BusinessException))
	def void organizadorNoPuedeInvitarMasDe50Personas() {
		free1.crearEvento(casamiento)
		free1.invitarUsuario(alejandro, casamiento, 10)
		alejandro.confirmarInvitacion(casamiento, 10)
		free1.invitarUsuario(marco, casamiento, 10)
		marco.confirmarInvitacion(casamiento, 10)
		free1.invitarUsuario(tomas, casamiento, 10)
		tomas.confirmarInvitacion(casamiento, 10)
		free1.invitarUsuario(miriam, casamiento, 10)
		free1.invitarUsuario(lucas, casamiento, 5)
		lucas.confirmarInvitacion(casamiento, 5)
		println(casamiento.cantidadAsistentesPosibles)
		free1.invitarUsuario(maria, casamiento, 0)	//No puede invitar a una persona mas
		}
	//TIPOS DE USUARIO
	@Test
	def void organizadorFreeCreaEventoSiNoHayEventoEnSimultaneoyNoSuperaLaCantidadMaximaPorMes() {
		free1.crearEvento(casamiento)
		free1.fechaActual = LocalDateTime.of(2018, 05, 29, 16, 00) // free quiere crear un 
		Assert.assertTrue(free1.puedoCrearEvento()) // evento cuando termina otro
		free1.crearEvento(cumple)
		Assert.assertTrue(free1.eventosOrganizados.contains(cumple))
	}

	@Test(expected=typeof(BusinessException))
	def void organizadorFreeNoCreaEventoSiHayEventoEnSimultaneo() {
		free1.crearEvento(casamiento)
		free1.fechaActual = LocalDateTime.of(2018, 05, 28, 22, 00) // free quiere crear un 
		free1.crearEvento(cumple) // evento mientras sucede otro
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
	//ACEPTACION Y RECHAZOS MASIVOS
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
		lucas.radioCercania = 10
		lucas.aceptarPendientes()
		println(casamiento.distancia(lucas.coordenadas))
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
		lucas.radioCercania = 100
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
	def void siSeReprogramaEventoUsuarioPuedeDevolverEntradaPorEl100DeSuValor() {
		lollapalooza.postergarEvento(LocalDateTime.of(2018, 03, 28, 19, 00))
		maxi.devolverEntrada(lollapalooza)
		Assert.assertFalse(lollapalooza.estaInvitado(maxi))
		Assert.assertEquals(500, maxi.saldoAFavor, 0.1)
	}
	@Test
	def void usuarioAmateurQueiereOrganizar5eventosALaVezYPuedePorQueEsAmateur(){
		gaston.crearEvento(even1)
		gaston.crearEvento(even2)
		gaston.crearEvento(even3)
		gaston.crearEvento(even4)
		Assert.assertTrue(gaston.puedoCrearEvento())		
	}
	@Test(expected=typeof(BusinessException))
	def void usuarioAmateurQueiereOrganizar6eventosALaVezYNoPuede(){
		gaston.crearEvento(even1)
		gaston.crearEvento(even2)
		gaston.crearEvento(even3)
		gaston.crearEvento(even4)
		gaston.crearEvento(even5)
		gaston.crearEvento(even6)
	}
	@Test
	def void usuarioAmateurNoPuedeRealizarMasDe50Invitaciones(){
		//realizar 50 invitaciones
		Assert.assertTrue(true)
		
	}
	
	@Test
	def void usuarioProfesionalQuiereOrganizar6eventosALaVezYPuede(){
		carla.crearEvento(even1)
		carla.crearEvento(even2)
		carla.crearEvento(even3)
		carla.crearEvento(even4)
		carla.crearEvento(even5)
		carla.crearEvento(even6)
		Assert.assertTrue(carla.puedoCrearEvento)		
	}
	@Test
	def void usuarioProfesionalQuiereOrganizarMasDe20eventosALaVezYNoPuede(){
		//organizar mas de 20 eventos al mismo tiempo
		Assert.assertTrue(true)		
	}

	@Test
	def void eventoCerradoConfirmanMasDel80PoCientoEsExitiso(){
		gaston.crearEvento(cumple)
		gaston.invitarUsuario(lucas,cumple,3)
		gaston.invitarUsuario(carla,cumple,2)
		gaston.invitarUsuario(maxi,cumple,3)
		gaston.invitarUsuario(marco,cumple,3)
		gaston.invitarUsuario(beatriz,cumple,3)
		carla.confirmarInvitacion(cumple,2)
		lucas.confirmarInvitacion(cumple,3)
		maxi.confirmarInvitacion(cumple,3)
		marco.confirmarInvitacion(cumple,3)
		Assert.assertTrue(cumple.esExitoso())	
	}
	@Test
	def void eventoCerradoEsCanceladoNoEsExitoso(){
		gaston.crearEvento(cumple)
		gaston.invitarUsuario(lucas,cumple,3)
		gaston.invitarUsuario(carla,cumple,2)
		gaston.invitarUsuario(maxi,cumple,3)
		gaston.invitarUsuario(marco,cumple,3)
		gaston.invitarUsuario(beatriz,cumple,3)
		lucas.confirmarInvitacion(cumple,3)
		maxi.confirmarInvitacion(cumple,3)
		marco.confirmarInvitacion(cumple,3)
		gaston.cancelarEvento(cumple)
		Assert.assertFalse(cumple.esExitoso())	
	}
	@Test
	def void eventoCerradoConfirmanMenosDel80PorCientoYMasDEl50PorCientoNoEsFracasoNiExitoso(){
		gaston.crearEvento(cumple)
		gaston.invitarUsuario(alejandro,cumple,3)
		gaston.invitarUsuario(marco,cumple,2)
		gaston.invitarUsuario(tomas,cumple,3)
		gaston.invitarUsuario(miriam,cumple,3)
		gaston.invitarUsuario(juan,cumple,3)
		alejandro.confirmarInvitacion(cumple,3)
		juan.confirmarInvitacion(cumple,3)
		marco.confirmarInvitacion(cumple,1)
		Assert.assertFalse(cumple.esExitoso())	
		Assert.assertFalse(cumple.esFracaso())
	}
	@Test
	def void eventoCerradoConfirmanMenosDel50PorCientoEsFracaso(){
		gaston.crearEvento(cumple)
		gaston.invitarUsuario(lucas,cumple,3)
		gaston.invitarUsuario(carla,cumple,2)
		gaston.invitarUsuario(maxi,cumple,3)
		gaston.invitarUsuario(marco,cumple,3)
		gaston.invitarUsuario(beatriz,cumple,3)
		carla.confirmarInvitacion(cumple,2)
		lucas.confirmarInvitacion(cumple,3)
		Assert.assertTrue(cumple.esFracaso())	
	}
	//ENTREGA 2
	//Servicioes
	
	@Test
	def void pruebaCostoUnServicioConTarifaFija(){
		lollapalooza.contratarServicio(candyBarWillyWonka)
		Assert.assertEquals(206.2, candyBarWillyWonka.costoTraslado(lollapalooza), 0.1)
		Assert.assertEquals(956.2, lollapalooza.costoTotalEvento, 0.1)
	}
	@Test
	def void pruebaCostoUnServicioConTarifaPorHora(){
		lollapalooza.contratarServicio(animacionMago)
		Assert.assertEquals(34.62, animacionMago.costoTraslado(lollapalooza), 0.1)
		Assert.assertEquals(7, lollapalooza.duracion, 0.1)
		Assert.assertEquals(418.62, lollapalooza.costoTotalEvento, 0.1)
	}
	
	@Test
	def void pruebaCostoUnServicioConTarifaPorPersona(){
		lollapalooza.contratarServicio(cateringFoodParty)
		Assert.assertEquals(18.36, cateringFoodParty.costoTraslado(lollapalooza), 0.1)
		Assert.assertEquals(5, lollapalooza.cantidadAsistentesPosibles, 0.1)
		Assert.assertEquals(93.36, lollapalooza.costoTotalEvento, 0.1)
	}
	
	@Test
	def void pruebaCostoTotalEventoContrataTresServicios(){
		lollapalooza.contratarServicio(cateringFoodParty)
		lollapalooza.contratarServicio(animacionMago)
		lollapalooza.contratarServicio(candyBarWillyWonka)
		Assert.assertEquals(1468.18, lollapalooza.costoTotalEvento, 0.1)
	}
	@Test
	def void pruebaSet(){
		println(lucas.nombreUsuario)
		martin.agregarAmigo(lucas)
		println(martin.amigos.get(0).nombreUsuario)
		martin.agregarAmigo(miriam)
		lucas.nombreUsuario = "pedro"
		println(martin.amigos.get(1).nombreUsuario)
		println(lucas.nombreUsuario)
		Assert.assertTrue(true)
	}
	
	 @Test
	def void pruebaEdadUsuario(){
		var franco = new Usuario() =>[
			fechaNacimiento = LocalDateTime.of(1993, 02, 15, 00, 00)
			fechaActual = LocalDateTime.of(2018, 02, 14, 12, 00)
		]
		Assert.assertEquals(25, franco.edad, 0.1)
	}
	
	/* 	@Test
	def void haceralgo(){
		var repo = new Repositorio<Usuario>()
		repo.create(gaston)
		repo.create(lucas)
		
	}
	*/
	@Test (expected=typeof(BusinessException))
	def void noSePuedeAgregarUsuarioQueFaltanDatos(){
		var repo = new RepositorioUsuarios()
		repo.create(gaston)
	}
	
	@Test 
	def void seAgregaUsuarioARepositorio(){
		var repo = new RepositorioUsuarios()
		repo.create(miriam)
		Assert.assertFalse(repo.search(miriam.nombreUsuario).isEmpty)
	}
	
	@Test (expected=typeof(BusinessException))
	def void noSePuedeAgregarServicioQueFaltanDatos(){
		var repo = new RepositorioServicio()
		repo.create(candyBarWillyWonka)	//Le falta descripcion
		
	}
	
	/*  @Test 
	def void pruebaJSON(){
		var FileReader fr = new FileReader("usuarios.json")
		var main = new Main()
		var str = Json.parse(fr).asString
		main.conversionJsonUsuarios(str)
		println(main.usuarios.get(0).nombreUsuario)
		println(main.usuarios.get(1).nombreUsuario)
	}*/
}		