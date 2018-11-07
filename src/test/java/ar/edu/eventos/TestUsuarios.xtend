
package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.usuarios.Antisocial
import ar.edu.usuarios.Sociable
import ar.edu.usuarios.Usuario
import java.time.LocalDate
import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Test
import org.uqbar.ccService.CreditCard
import org.uqbar.ccService.CreditCardService

class TestUsuarios extends JuegoDatosTest {
	// Eventos abiertos
	@Test
	def void personaSacaEntrada() {
		juan.comprarEntrada(lollapalooza)
		Assert.assertTrue(lollapalooza.estaInvitado(juan))
	}

	@Test(expected=typeof(BusinessException))
	def void personaNoPuedeSacarEntradaSuperoFechaLimite() { // Quedan entradas y tiene edad minima
		martin.fechaNacimiento = LocalDate.of(1999, 01, 01)
		martin.comprarEntrada(lollapalooza)
	}

	@Test(expected=typeof(BusinessException))
	def void unaPersonaQuiereSacarUnaEntradaYNoQuedanEntradas() { // Compraron 6 entradas y no quedan
		ultimoComprador = new Usuario() => [
			nombreUsuario = "pablo"
			fechaHoraActual = LocalDateTime.of(2018, 03, 15, 16, 45)
			fechaNacimiento = LocalDate.of(1985, 03, 15)
			miTarjeta = new CreditCard
			servicioTarjeta = mockearCreditCardServicePagoExitoso(miTarjeta, lollapalooza.valorEntrada)
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
		juan.fechaHoraActual = LocalDateTime.of(2018, 03, 15, 09, 30) // Devuelve en la fecha de confirmacion
		println(lollapalooza.diasfechaMaximaConfirmacion(juan))
		juan.devolverEntrada(lollapalooza)
	}

	@Test
	def void siUnaPersonaDevuelveEnIntervaloDe7DiasRestantesSeDevuelveUnPorcentaje() { // compra entrada y se arrepiente
		juan.fechaHoraActual = LocalDateTime.of(2018, 03, 09, 22, 00)
		juan.comprarEntrada(lollapalooza)
		juan.devolverEntrada(lollapalooza)
		Assert.assertEquals(350d, juan.saldoAFavor, 0.1)
		Assert.assertEquals(1, lollapalooza.cantidadDisponibles, 0.1)
	}

	@Test
	def void siUnaPersonaDevuelveEntradaAntesDe7DiasSeDevuelve80Porciento() {
		juan.fechaHoraActual = LocalDateTime.of(2018, 03, 06, 22, 00)
		juan.comprarEntrada(lollapalooza)
		juan.devolverEntrada(lollapalooza)
		Assert.assertEquals(400, juan.saldoAFavor, 0.1)
		Assert.assertEquals(1, lollapalooza.cantidadDisponibles, 0.1)
	}

	// EVENTOS CERRADOS
	// INVITACIONES
	@Test
	def void personaRecibeInvitacionEsAgregadoAlEvento() {
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		Assert.assertTrue(casamiento.estaInvitado(lucas))
	}

	@Test(expected=typeof(BusinessException))
	def void personaNoPuedeConfirmarInvitacionSiSuperaLaCantidadMaximaAcompaniantes() {
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.confirmarInvitacion(casamiento, 4)
	}

	@Test(expected=typeof(BusinessException))
	def void personaNoPuedeConfirmarInvitacionSiSuperaFechaMaximaDeConfirmacion() {
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.fechaHoraActual = LocalDateTime.of(2018, 05, 26, 23, 59) // fecha maxima de confirmacion es 2018, 05, 25, 23, 59)
		lucas.confirmarInvitacion(casamiento, 2)
	}

	@Test(expected=typeof(BusinessException))
	def void freeNoPuedeOrganizarEventoAbierto() {
		println(free1.tipoUsuario)
		println(lollapalooza.class)
		free1.crearEvento(lollapalooza)
	}

	// 1	
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
		free1.invitarUsuario(lucas, casamiento, 6) // No se puede tiene 44 invitados mas 6+1 de la nueva invitacion, la invitacion puede ser de 5+1 o menos
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
		free1.invitarUsuario(maria, casamiento, 0) // No puede invitar a una persona mas
	}

	@Test
	def void unUsuarioAceptaUnaInvitacionPendienteSiElOrganizadorEsSuAmigo() {
		lucas.agregarAmigo(beatriz)
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.aceptarInvitacionesPendientes()
		Assert.assertTrue(casamiento.estaConfirmado(lucas))
	}

	@Test
	def void unaUsuarioNoAceptaUnaInvitacionPendienteSiElOrganizadorNoEsSuAmigo() {
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.aceptarInvitacionesPendientes()
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
		lucas.aceptarInvitacionesPendientes()
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
		lucas.aceptarInvitacionesPendientes()
		Assert.assertFalse(casamiento.estaConfirmado(lucas))
	}

	@Test
	def void usuarioAceptaInvitacionPendienteSiSeEncuentraEnSuRadioDeCercania() {
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.radioCercania = 10
		lucas.aceptarInvitacionesPendientes()
		println(casamiento.distancia(lucas.direccion.coordenadas))
		Assert.assertTrue(casamiento.estaConfirmado(lucas))
	}

	@Test
	def void usuarioNoAceptaInvitacionPendienteSiNoSeEncuentraEnSuRadioDeCercania() {
		lucas.radioCercania = 5
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.aceptarInvitacionesPendientes()
		Assert.assertFalse(casamiento.estaConfirmado(lucas))
	}

	@Test
	def void usuarioAntisocialRechazaInvitacionPendienteSiSeEncuentraFueraDeSuRadioDeCercania() {
		lucas.radioCercania = 5
		lucas.tipoPersonalidad = new Antisocial()
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.rechazarPendientes() // cuando se rechaza la invitacion, se lo saca de la
		Assert.assertFalse(casamiento.estaInvitado(lucas)) // lista de pendientes del evento
	}

	@Test
	def void usuarioAntisocialRechazaInvitacionPendienteSiNoAsistenAlMenosDosAmigos() {
		lucas.radioCercania = 90
		lucas.tipoPersonalidad = new Antisocial()
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
		lucas.tipoPersonalidad = new Sociable()
		lucas.agregarAmigo(miriam) // lucas tiene amigos
		lucas.agregarAmigo(juan) // juan no es invitado
		beatriz.crearEvento(casamiento)
		beatriz.invitarUsuario(miriam, casamiento, 3) // miriam no confirma que asiste
		beatriz.invitarUsuario(lucas, casamiento, 3)
		lucas.rechazarPendientes() // cuando se rechaza la invitacion, se lo saca de la
		Assert.assertFalse(casamiento.estaInvitado(lucas)) // lista de pendientes del evento
	}

	// TIPOS DE USUARIO
	@Test
	def void organizadorFreeCreaEventoSiNoHayEventoEnSimultaneoyNoSuperaLaCantidadMaximaPorMes() {
		free1.crearEvento(casamiento)
		free1.fechaHoraActual = LocalDateTime.of(2018, 05, 29, 16, 00) // free quiere crear un 
		Assert.assertTrue(free1.puedoCrearEvento(cumple)) // evento cuando termina otro
		free1.crearEvento(cumple)
		Assert.assertTrue(free1.eventosOrganizados.contains(cumple))
	}

	@Test(expected=typeof(BusinessException))
	def void organizadorFreeNoCreaEventoSiHayEventoEnSimultaneo() {
		free1.crearEvento(casamiento)
		free1.fechaHoraActual = LocalDateTime.of(2018, 05, 28, 22, 00) // free quiere crear un 
		free1.crearEvento(cumple) // evento mientras sucede otro
	}
	
	@Test(expected=typeof(BusinessException))
	def void organizadorFreeNoPuedeCancelarEventos() {
		free1.crearEvento(casamiento)
		free1.cancelarEvento(casamiento) 
	}
	
	@Test(expected=typeof(BusinessException))
	def void organizadorFreeNoPuedePostergarEventos() {
		free1.crearEvento(casamiento)
		free1.postergarEvento(casamiento, LocalDateTime.of(2018, 11, 03, 17, 30)) 
	}

	@Test
	def void organizadorFreeNoCreaEventoSiSuperaLaCantidadMaximaPorMes() {
		free1.crearEvento(casamiento)
		free1.fechaHoraActual = LocalDateTime.of(2018, 05, 29, 11, 00)
		Assert.assertTrue(free1.puedoCrearEvento(cumple))
		free1.crearEvento(cumple)
		free1.fechaHoraActual = LocalDateTime.of(2018, 05, 31, 12, 00)
		Assert.assertTrue(free1.puedoCrearEvento(minifiesta1))
		free1.crearEvento(minifiesta1)
		free1.fechaHoraActual = LocalDateTime.of(2018, 05, 31, 16, 00)
		Assert.assertFalse(free1.puedoCrearEvento(even1))
	}

	@Test
	def void siSeReprogramaEventoUsuarioPuedeDevolverEntradaPorEl100DeSuValor() {
		lollapalooza.postergarEvento(LocalDateTime.of(2018, 03, 28, 19, 00))
		maxi.devolverEntrada(lollapalooza)
		Assert.assertFalse(lollapalooza.estaInvitado(maxi))
		Assert.assertEquals(500, maxi.saldoAFavor, 0.1)
	}

	@Test
	def void usuarioAmateurQueiereOrganizar5eventosALaVezYPuedePorQueEsAmateur() {
		gaston.crearEvento(even1)
		gaston.crearEvento(even2)
		gaston.crearEvento(even3)
		gaston.crearEvento(even4)
		Assert.assertTrue(gaston.puedoCrearEvento(even5))
	}

	@Test(expected=typeof(BusinessException))
	def void usuarioAmateurQueiereOrganizar6eventosALaVezYNoPuede() {
		gaston.crearEvento(even1)
		gaston.crearEvento(even2)
		gaston.crearEvento(even3)
		gaston.crearEvento(even4)
		gaston.crearEvento(even5)
		gaston.crearEvento(even6)
	}

	/*@Test
	 * def void usuarioAmateurNoPuedeRealizarMasDe50Invitaciones() {
	 * 	// realizar 50 invitaciones
	 * 	Assert.assertTrue(true)
	 *  }
	 */
	@Test
	def void usuarioProfesionalQuiereOrganizar6eventosALaVezYPuede() {
		carla.crearEvento(even1)
		carla.crearEvento(even2)
		carla.crearEvento(even3)
		carla.crearEvento(even4)
		carla.crearEvento(even5)
		carla.crearEvento(even6)
		Assert.assertTrue(carla.puedoCrearEvento(lollapalooza))
	}

	/*@Test
	 * def void usuarioProfesionalQuiereOrganizarMasDe20eventosALaVezYNoPuede() {
	 * 	// organizar mas de 20 eventos al mismo tiempo
	 * 	Assert.assertTrue(true)
	 }*/
	@Test
	def void usuarioTieneSaldoYCompraEntrada() {
		juan.comprarEntrada(lollapalooza)
		Assert.assertTrue(lollapalooza.estaInvitado(juan))

	}

	@Test(expected=typeof(BusinessException))
	def void usuarioNoPuedeComprarEntradaTarjetaNovalida() {
		juan.servicioTarjeta = new CreditCardService
		juan.comprarEntrada(lollapalooza)
	}

	@Test(expected=typeof(BusinessException))
	def void usuarioNoPuedeComprarEntradaPagoRechazado() {
		juan.servicioTarjeta = mockearCreditCardServicePagoRechazado(juan.miTarjeta, lollapalooza.valorEntrada)
		juan.comprarEntrada(lollapalooza)
	}
	
	//TEST DE DE INVITACIONES RETRACTABLES	
	@Test 
 
	def void seConcretaLainvitacionAlEjecutarOrdenes(){
		gaston.crearEvento(cumple)
		gaston.invitarUsuario(carla, cumple, 2)
        carla.confirmacionAsincronica (servAsincronico,cumple, 2)		
        Assert.assertEquals(0,cumple.invitadosConfirmados.size,0)
		cumple.ejecucionesDeInvitacionesAsincronicas(servAsincronico)
		Assert.assertEquals(1,cumple.invitadosConfirmados.size,0)
		}
	@Test
	def void usuarioCambiaDesicionAceptadaAntesEjecutarOrden(){
		gaston.crearEvento(cumple)
		gaston.invitarUsuario(carla, cumple, 2)
		carla.confirmacionAsincronica (servAsincronico,cumple, 2)	
		carla.cambiarDesicionAceptado(servAsincronico,cumple)
		cumple.ejecucionesDeInvitacionesAsincronicas(servAsincronico)
		Assert.assertEquals(0,cumple.invitadosConfirmados.size,0)
	}
	@Test
		def void usuarioCambiaDesicionaRechazadaAntesEjecutarOrden(){
		gaston.crearEvento(cumple)
		gaston.invitarUsuario(carla, cumple, 2)
		carla.rechazoAsincronica(servAsincronico,cumple)
		carla.rechazarInvitacion(cumple)
		carla.cambiarDesicionRechazado(servAsincronico,cumple)
		cumple.ejecucionesDeInvitacionesAsincronicas(servAsincronico)
		Assert.assertEquals(1,cumple.invitadosConfirmados.size,0)
	}
	
}
