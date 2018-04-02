import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors

class Usuario {
	String nombre
	LocalDateTime fechaActual
	int edad	
	def comprarEntradas(EventoAbierto unEvento){
		unEvento.usuarioCompraEntrada(this)
	}
		
	def boolean superaEdadMin(EventoAbierto unEvento) {
		this.edad >= unEvento.edadMinima
	}
	
}