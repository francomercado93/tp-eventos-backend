import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Locacion {
	String nombre
	Point puntoGeografico
	double superficie


	def double distancia(Point unPunto) {
		puntoGeografico.distance(unPunto)
	}
}
