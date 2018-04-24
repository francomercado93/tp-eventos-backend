package servicios

import ar.edu.eventos.Evento

class TarifaPersona extends TipoTarifa {
	
	double porcentaje
	
	override costo(Evento unevento){
		
		this.tarifaMinima(unevento)+this.costoExtraPorPersona(unevento)
		
	}
	
	def tarifaMinima(Evento unevento){
		
		(unevento.capacidadMaxima()*porcentaje)*costo_fijo
	}
	
	
	
	def double costoExtraPorPersona(Evento unEvento){
		if(unEvento.cantidadAsistentesPosibles()>(unEvento.capacidadMaxima()*porcentaje))
			(unEvento.cantidadAsistentesPosibles()-(unEvento.capacidadMaxima()*porcentaje))	*costo_fijo
		else
			0
		}
	
}