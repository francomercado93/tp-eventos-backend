package ar.edu.usuarios

import java.util.Map
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Direccion {
	String calle
	int numero
	String localidad
	String provincia
	Map<String, Double> coordenadas = newHashMap

	new(String unaCalle, int unNumero, String unaLocalidad, String unaProvincia, Point punto) {
		calle = unaCalle
		numero = unNumero
		localidad = unaLocalidad
		provincia = unaProvincia
		coordenadas.put("x", punto.getX)
		coordenadas.put("y", punto.getY)
	}
}
