import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class TipoUsuario {
	int edadMinima
	double valorEntrada
	double cantidadInvitados

	def void organizarEventoAbierto(EventoAbierto abierto) {
		abierto.edadMinima = edadMinima
		abierto.valorEntrada = valorEntrada
	}

	def void organizarEventoCerrado(EventoCerrado cerrado) {
		cerrado.capacidadMaxima = cantidadInvitados
	}

	def void cancelarEvento(Evento unEvento) {
		unEvento.cancelarEvento
	}
	def void postergarEvento(Evento unEvento, LocalDateTime nuevaFechaInicio){
 	 	unEvento.postergarEvento(nuevaFechaInicio)
 	}
}
