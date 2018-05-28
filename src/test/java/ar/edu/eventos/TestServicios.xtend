package ar.edu.eventos

import org.junit.Assert
import org.junit.Test

class TestServicios extends JuegoDatosTest {
	// Servicios
	@Test
	def void pruebaCostoUnServicioConTarifaFija() {
		lollapalooza.contratarServicio(candyBarWillyWonka)
		Assert.assertEquals(206.2, candyBarWillyWonka.costoTraslado(lollapalooza), 0.1)
		Assert.assertEquals(956.2, lollapalooza.costoTotalEvento, 0.1)
	}

	@Test
	def void pruebaCostoUnServicioConTarifaPorHora() {
		lollapalooza.contratarServicio(animacionMago)
		Assert.assertEquals(34.62, animacionMago.costoTraslado(lollapalooza), 0.1)
		Assert.assertEquals(7, lollapalooza.duracion, 0.1)
		Assert.assertEquals(418.62, lollapalooza.costoTotalEvento, 0.1)
	}
	
	@Test
	def void pruebaCostoUnServicioConTarifaPorHoraCostoMinimo() {
		lollapalooza.contratarServicio(animacionMagoCostoMinimo)
		Assert.assertEquals(34.62, animacionMagoCostoMinimo.costoTraslado(lollapalooza), 0.1)
		Assert.assertEquals(7, lollapalooza.duracion, 0.1)
		Assert.assertEquals(334.62, lollapalooza.costoTotalEvento, 0.1)
	}

	@Test
	def void pruebaCostoUnServicioConTarifaPorPersona() {
		lollapalooza.contratarServicio(cateringFoodParty)
		Assert.assertEquals(18.36, cateringFoodParty.costoTraslado(lollapalooza), 0.1)
		Assert.assertEquals(5, lollapalooza.cantidadAsistentesPosibles, 0.1)
		Assert.assertEquals(93.36, lollapalooza.costoTotalEvento, 0.1)
	}
	@Test
	def void pruebaCostoMinimoUnServicioConTarifaPorPersona() {//se cobra el minimo
		lollapalooza.contratarServicio(cateringFoodParty)
		lucas.devolverEntrada(lollapalooza)
		Assert.assertEquals(90.36, lollapalooza.costoTotalEvento, 0.1)
	}

	@Test
	def void pruebaCostoTotalEventoContrataTresServicios() {
		lollapalooza.contratarServicio(cateringFoodParty)
		lollapalooza.contratarServicio(animacionMago)
		lollapalooza.contratarServicio(candyBarWillyWonka)
		Assert.assertEquals(1468.18, lollapalooza.costoTotalEvento, 0.1)
	}
// TEST CON TARIFA COSTO MINIMO Y SIN COSTO MINIMO
}
