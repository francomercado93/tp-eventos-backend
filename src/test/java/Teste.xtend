
import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class Teste {

	Evento fiesta
	Locacion estadio1
	LocalDateTime inicio = LocalDateTime.of(2018, 03, 27, 18, 00)
	LocalDateTime hasta = LocalDateTime.of(2018, 03, 28, 01, 00)

	Point puntoPrueba = new Point(5, 8)
	double distanciaEsperada = 496.51d

	@Before
	def void init() {
		estadio1 = new Locacion("obras", new Point(9, 6))
		fiesta = new Evento("fest", inicio, hasta, estadio1)
	}

	@Test
	def void ProbarDuracion() {
		Assert.assertEquals(7, fiesta.duracion, 0.1)
	}

	@Test
	def void ProbarDistancia() {
		Assert.assertEquals(distanciaEsperada, fiesta.distancia(puntoPrueba), 0.1)
	}

}
