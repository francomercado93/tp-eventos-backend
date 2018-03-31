import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import java.time.Duration

class Evento {

	@Accessors
	String nombreEvento
	LocalDateTime fechaInicio
	LocalDateTime fechaHasta
	Locacion lugar

	new(
		String _nombreEvento,
		LocalDateTime _fechaInicio,
		LocalDateTime _fechaHasta,
		Locacion _lugar
	) {
		nombreEvento = _nombreEvento
		fechaInicio = _fechaInicio
		fechaHasta = _fechaHasta
		lugar = _lugar
	}

	def duracion() {
		Duration.between(fechaInicio, fechaHasta).getSeconds() / 3600d
	}

	def double distancia(Point unPunto) {
		lugar.distancia(unPunto)
	}

}
