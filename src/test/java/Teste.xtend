import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class Teste {

	Evento fiesta
	Locacion estadio1
	Locacion estadio2
	LocalDateTime inicio = LocalDateTime.of(2018, 03, 27, 18, 00)
	LocalDateTime hasta = LocalDateTime.of(2018, 03, 28, 01, 00)
	LocalDateTime duracionEstimada = LocalDateTime.of(0000, 00, 00, 07, 00)
	Point puntocualquiera = new Point(2, 1)

	@Before
	def void init() {
		fiesta = new Evento("fest", inicio, hasta)
		estadio1 = new Locacion("obras", new Point(1, 1))
		estadio2 = new Locacion("geba", new Point(4, 2))
	}

	@Test
	def void Probarduracion() {
		Assert.assertEquals(fiesta.duracion(), duracionEstimada)
	}

	@Test
	def void ProbarDistancia() {
		Assert.assertEquals(fiesta.distancia(puntocualquiera), 2.2, 0.1)
	}

}
