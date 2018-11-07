package ar.edu.eventos

import ar.edu.usuarios.Usuario
import java.time.LocalDate
import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Test
import org.uqbar.ccService.CreditCard

class TestEventos extends JuegoDatosTest {

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

	// Eventos Abiertos
	@Test
	def void seVendieronMasDel90PorcientoEntoncesEventoAbiertoEsExitoso() {
		ultimoComprador = new Usuario() => [
			nombreUsuario = "pablo"
			fechaHoraActual = LocalDateTime.of(2018, 03, 15, 16, 45)
			fechaNacimiento = LocalDate.of(1985, 03, 15)
			miTarjeta = new CreditCard
			servicioTarjeta = mockearCreditCardServicePagoExitoso(miTarjeta, lollapalooza.valorEntrada)
			comprarEntrada(lollapalooza)
		]
		Assert.assertTrue(lollapalooza.esExitoso)
	}

	@Test
	def void seVendieronMenosDel90PorcientoEntoncesEventoNoEsExitoso() {
		Assert.assertFalse(lollapalooza.esExitoso)
	}

	@Test
	def void seVendieronMenosDel50PorcientoEntoncesEventoAbiertoEsFracaso() { // Se devuelven 3 entradas, quedan 4 disponibles de las 6
		beatriz.devolverEntrada(lollapalooza)
		lucas.devolverEntrada(lollapalooza)
		maria.devolverEntrada(lollapalooza)
		Assert.assertEquals(6, lollapalooza.capacidadMaxima, 0.1)
		Assert.assertEquals(4, lollapalooza.cantidadDisponibles, 0.1)
		Assert.assertTrue(lollapalooza.esFracaso)
	}

	@Test
	def void seVendieronMasDel50PorcientoYMenosDel90EntoncesEventoAbiertoNoEsFracasoYNoEsExitoso() {
		beatriz.devolverEntrada(lollapalooza)
		Assert.assertEquals(6, lollapalooza.capacidadMaxima, 0.1)
		Assert.assertEquals(2, lollapalooza.cantidadDisponibles, 0.1)
		Assert.assertFalse(lollapalooza.esFracaso)
		Assert.assertFalse(lollapalooza.esExitoso)
	}

	// EVENTOS CERRADOS
	@Test
	def void eventoCerradoConfirmanMasDel80PoCientoEsExitiso() {
		gaston.crearEvento(cumple)
		gaston.invitarUsuario(lucas, cumple, 3)
		gaston.invitarUsuario(carla, cumple, 2)
		gaston.invitarUsuario(maxi, cumple, 3)
		gaston.invitarUsuario(marco, cumple, 3)
		gaston.invitarUsuario(beatriz, cumple, 3)
		carla.confirmarInvitacion(cumple, 2)
		lucas.confirmarInvitacion(cumple, 3)
		maxi.confirmarInvitacion(cumple, 3)
		marco.confirmarInvitacion(cumple, 3)
		Assert.assertTrue(cumple.esExitoso())
	}

	@Test
	def void eventoCerradoEsCanceladoNoEsExitoso() {
		gaston.crearEvento(cumple)
		gaston.invitarUsuario(lucas, cumple, 3)
		gaston.invitarUsuario(carla, cumple, 2)
		gaston.invitarUsuario(maxi, cumple, 3)
		gaston.invitarUsuario(marco, cumple, 3)
		gaston.invitarUsuario(beatriz, cumple, 3)
		lucas.confirmarInvitacion(cumple, 3)
		maxi.confirmarInvitacion(cumple, 3)
		marco.confirmarInvitacion(cumple, 3)
		gaston.cancelarEvento(cumple)
		Assert.assertFalse(cumple.esExitoso())
	}

	@Test
	def void eventoCerradoConfirmanMenosDel80PorCientoYMasDEl50PorCientoNoEsFracasoNiExitoso() {
		gaston.crearEvento(cumple)
		gaston.invitarUsuario(alejandro, cumple, 3)
		gaston.invitarUsuario(marco, cumple, 2)
		gaston.invitarUsuario(tomas, cumple, 3)
		gaston.invitarUsuario(miriam, cumple, 3)
		gaston.invitarUsuario(juan, cumple, 3)
		alejandro.confirmarInvitacion(cumple, 3)
		juan.confirmarInvitacion(cumple, 3)
		marco.confirmarInvitacion(cumple, 1)
		Assert.assertFalse(cumple.esExitoso())
		Assert.assertFalse(cumple.esFracaso())
	}

	@Test
	def void eventoCerradoConfirmanMenosDel50PorCientoEsFracaso() {
		gaston.crearEvento(cumple)
		gaston.invitarUsuario(lucas, cumple, 3)
		gaston.invitarUsuario(carla, cumple, 2)
		gaston.invitarUsuario(maxi, cumple, 3)
		gaston.invitarUsuario(marco, cumple, 3)
		gaston.invitarUsuario(beatriz, cumple, 3)
		carla.confirmarInvitacion(cumple, 2)
		lucas.confirmarInvitacion(cumple, 3)
		Assert.assertTrue(cumple.esFracaso())
	}

	// CANCELACIONES Y POSTERGACIONES
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
}
