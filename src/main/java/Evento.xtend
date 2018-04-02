import java.time.Duration
import java.time.LocalDateTime
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
abstract class Evento {

	String nombreEvento
	LocalDateTime fechaInicio
	LocalDateTime fechaHasta
	Locacion lugar
	LocalDateTime fechaMaxima

	def duracion() {
		Duration.between(fechaInicio, fechaHasta).getSeconds() / 3600d
	}

	def double distancia(Point unPunto) {
		lugar.distancia(unPunto)
	}
	def  double capacidadMaxima()	

}

@Accessors
class EventoAbierto extends Evento {

	double espacioNecesarioPorPersona = 0.8
	int edadMinima
	List<Usuario> espectadores = newArrayList

	override def double capacidadMaxima() {
		lugar.superficie / espacioNecesarioPorPersona
	}
	
	def double cantidadEntradasDisponibles() {
		this.capacidadMaxima - espectadores.size
	}
		
	def usuarioCompraEntrada(Usuario unUsuario) {
		if(unUsuario.superaEdadMin(this) && this.cantidadEntradasDisponibles > 0 && 
			unUsuario.fechaActual.isBefore(this.fechaMaxima))
			espectadores.add(unUsuario)		//Si no cumple Requisitos no se muestra ninguna mensaje(prguntar excepciones)
	
	}
}

