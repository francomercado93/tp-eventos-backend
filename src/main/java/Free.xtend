import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Free extends TipoUsuario {
	override organizarEventoCerrado(EventoCerrado cerrado){
		if(this.noSuperaCapacidadMaximaInvitados)
			cerrado.capacidadMaxima = cantidadInvitados
		else
			println("La cantidad de Invitados supera lo permitido")
	}
	
	def boolean noSuperaCapacidadMaximaInvitados(){
		cantidadInvitados <= 50
	}
	override organizarEventoAbierto(EventoAbierto abierto){
		println("Usuario free no puede organizar evento abierto")
	}
}

class Amateur extends TipoUsuario{
	
}