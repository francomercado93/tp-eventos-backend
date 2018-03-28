import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

class Evento {
	
@Accessors	String nombre
@Accessors	LocalDateTime fechaInicio
@Accessors	LocalDateTime fechaHasta
@Accessors	Locacion lugar
	
	new(String _nombre,LocalDateTime _fechaInicio,LocalDateTime _fechaHasta){
		nombre = _nombre
		fechaInicio = _fechaInicio
		fechaHasta = _fechaHasta
		
	}

    def duracion(){
		this.operator_minus(fechaHasta,fechaInicio)
	}
	def operator_minus(LocalDateTime date1, LocalDateTime date2){
		date1 - date2 
	}
	
	def double distancia(Point unPunto){
		lugar.distancia(unPunto)
	}
	
	
}