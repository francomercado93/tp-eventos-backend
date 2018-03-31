import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

class Locacion {
	@Accessors
	String nombre
	Point puntoGeografico

	new(String _nombre, Point _coordenada) {
		nombre = _nombre
		puntoGeografico = _coordenada
	}

	def double distancia(Point unPunto) {
		puntoGeografico.distance(unPunto)
	}
}
