import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors

class Usuario {
	String nombre
	LocalDateTime fechaActual
	int edad
	double saldoAFavor
	
	def comprarEntradas(EventoAbierto unEvento){
		unEvento.usuarioCompraEntrada(this)
		
	}
		
	def boolean superaEdadMin(EventoAbierto unEvento) {
		this.edad >= unEvento.edadMinima
	}
	def devolverEntrada(EventoAbierto unEvento){
		unEvento.devolverDinero(this)
	}
	def	cumpleCondiciones(EventoAbierto unEvento){
		(this.superaEdadMin(unEvento) && unEvento.cantidadEntradasDisponibles > 0 && 
			this.fechaActual.isBefore(unEvento.fechaMaxima))
	}
}