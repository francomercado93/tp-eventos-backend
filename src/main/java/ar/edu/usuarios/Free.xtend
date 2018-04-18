package ar.edu.usuarios

import ar.edu.eventos.Evento
import ar.edu.eventos.EventoCerrado
import ar.edu.eventos.exceptions.BusinessException
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Free implements TipoUsuario {
	Integer maximaCantidadEventosPorMes = 3
	Integer maximaCantidadeventosSimultaneos = 0
	Integer cantidadMaximaPersonasEvento = 50

	override puedoOrganizarEvento(Usuario unUsuario) {
		(unUsuario.cantidadEventosOrganizadosMes() < maximaCantidadEventosPorMes) &&
			(unUsuario.cantidadEventosSimultaneos() == maximaCantidadeventosSimultaneos)

	}
	override cancelarEvento(Evento unEvento){
		println("Error: usuario free no puede cancelar eventos.")
	}

	override postergarEvento(Evento unEvento, LocalDateTime nuevaFechaInicio){
		println("Error: usuario free no puede postergar eventos.")
	}
	override invitarUsuario(Usuario invitado,Usuario organizador, EventoCerrado unEvento, Integer cantidadAcompaniantes){
		if(unEvento.cantidadAsistentesPosibles < cantidadMaximaPersonasEvento)		//Hasta 50 personas en total
			organizador.realizarInvitacion(invitado, unEvento, cantidadAcompaniantes)
		else
			throw new BusinessException("Supero cantidad maxima de personas invitadas.")
	}

  /*override organizarEventoAbierto(EventoAbierto abierto){
  	println("Usuario free no puede organizar evento abierto")
  }
  */
}
