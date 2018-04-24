package servicios

import ar.edu.eventos.Evento

class TarifaPorHora extends TipoTarifa {
	
	
	override def costo (Evento unevento){
		
		unevento.duracion()*costo_fijo
		
		
	}
	
}