package ar.edu.eventos

class Amateur extends TipoUsuario {
	
	override puedoOrganizarEvento(Usuario unUsuario){
		(this.cantidadEventosSimultaneos(unUsuario) <= 5)
			
	}
	override capacidadMaxima() {
		50
	}
}