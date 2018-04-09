import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class TipoUsuario {
	int edadMinima
	double valorEntrada
	double cantidadInvitados
	def void organizarEventoAbierto(EventoAbierto abierto){
		abierto.edadMinima = edadMinima
		abierto.valorEntrada = valorEntrada
	}
	def void organizarEventoCerrado(EventoCerrado cerrado){
		cerrado.capacidadMaxima = cantidadInvitados
	}
	
	
}