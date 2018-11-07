package ar.edu.usuarios

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Direccion {
	String calle
	int numero
	String localidad
	String provincia
	Point coordenadas

	new(String unaCalle, int unNumero, String unaLocalidad, String unaProvincia, Point punto) {
		calle = unaCalle
		numero = unNumero
		localidad = unaLocalidad
		provincia = unaProvincia
		coordenadas = punto
	}
}
