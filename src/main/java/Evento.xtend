
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

	def double capacidadMaxima()

}

@Accessors
class EventoAbierto extends Evento {

	double espacioNecesarioPorPersona = 0.8
	int edadMinima
	List<Usuario> espectadores = newArrayList
	double valorEntrada

	override def  capacidadMaxima() {
		Math.round(lugar.superficie / this.espacioNecesarioPorPersona) //mostraba 5.99 y no 6
	}

	def cantidadEntradasDisponibles() {
		Math.round(this.capacidadMaxima - espectadores.size)
	}

	def void usuarioCompraEntrada(Usuario unUsuario) {
		if (unUsuario.cumpleCondiciones(this))
			espectadores.add(unUsuario) // Si no cumple Requisitos no se muestra ninguna mensaje(prguntar excepciones)
	}

	def devolverDinero(Usuario unUsuario) {
		unUsuario.saldoAFavor = valorEntrada * this.porcentajeADevolver(unUsuario)
	}

	def double diasFechaMaxima(Usuario unUsuario) {
		Math.rint(Duration.between(unUsuario.fechaActual, this.fechaMaxima).getSeconds() / 86400d)//obtener dias
	}

	def double porcentajeADevolver(Usuario unUsuario) {
		if (this.diasFechaMaxima(unUsuario) < 7d)//falta el caso en el que quedan 0 dias 
			(this.diasFechaMaxima(unUsuario) + 1) * 0.1
		else
			0.8
	}

}
