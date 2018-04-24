package servicios

import ar.edu.eventos.Evento
import org.uqbar.geodds.Point

class servicio {
	
	TipoTarifa unTipoTarifa
	double costoKilometro
	Point ubicacionServicio
	
	def nombre(String string){}
	
	
	def  costo(Evento unevento){
		unTipoTarifa.costo(unevento) + this.costoTraslado(unevento)
	}
	
	def  costoTraslado(Evento unEvento) {
		costoKilometro * unEvento.distancia(ubicacionServicio)
	}
	
}