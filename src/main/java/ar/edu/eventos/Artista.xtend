package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Artista {
	
	String nombre
	double cachet
	
	new(String nombre){
		this.nombre = nombre
	}
}