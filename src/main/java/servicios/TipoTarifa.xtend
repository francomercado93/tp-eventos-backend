package servicios

import ar.edu.eventos.Evento
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class TipoTarifa {

  double costo_fijo

	
	def   double costo(Evento unevento)
	
	
}