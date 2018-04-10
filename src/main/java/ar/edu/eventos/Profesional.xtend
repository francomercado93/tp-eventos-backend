package ar.edu.eventos

class Profesional extends TipoUsuario{
	override puedoOrganizarEvento(Usuario unUsuario){
		this.cantidadEventosOrganizadosMes(unUsuario) <= 20
	}
	override capacidadMaxima() {
		999999
	}
}