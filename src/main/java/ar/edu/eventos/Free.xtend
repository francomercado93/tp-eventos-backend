package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Free extends TipoUsuario {
	
	override puedoOrganizarEvento(Usuario unUsuario){
		(this.cantidadEventosOrganizadosMes(unUsuario) <= 3) && (this.cantidadEventosSimultaneos(unUsuario) == 0)
			
	}
	override capacidadMaxima(){
		50
	}
	
	/*override organizarEventoCerrado(EventoCerrado cerrado){
		if(this.noSuperaCapacidadMaximaInvitados)
			cerrado.capacidadMaxima = cantidadInvitados
		else
			println("La cantidad de Invitados supera lo permitido")
	}
	
	def boolean noSuperaCapacidadMaximaInvitados(){
		cantidadInvitados <= 50
	}
	/*override organizarEventoAbierto(EventoAbierto abierto){
		println("Usuario free no puede organizar evento abierto")
	}
	override cancelarEvento(Evento unEvento){
		println("Usuario free no puede cancelar eventos")
	}*/
}

	
	