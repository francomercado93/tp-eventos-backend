package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class EventoAbierto extends Evento {

	double espacioNecesarioPorPersona = 0.8
	int edadMinima // organizador crea evento setear edadMinima y valor entrada
	double valorEntrada
	

	override capacidadMaxima() {
		Math.round(lugar.superficie / this.espacioNecesarioPorPersona) // mostraba 5.99 y no 6
	}

	def void usuarioCompraEntrada(Usuario unUsuario) {
		if (this.cumpleCondiciones(unUsuario))
			this.agregarUsuarioListaAsistentes(unUsuario) // Si no cumple Requisitos no se muestra ninguna mensaje(prguntar excepciones)
	}

	override boolean cumpleCondiciones(Usuario unUsuario) { // muevo metodos de usuario que le corresponden al evento
		(this.superaEdadMin(unUsuario) && this.cantidadDisponibles > 0 && this.usuarioEstaATiempo(unUsuario))
	}

	def boolean superaEdadMin(Usuario unUsuario) {
		unUsuario.edad >= this.edadMinima
	}

	def devolverDinero(Usuario unUsuario) {
		unUsuario.saldoAFavor = valorEntrada * this.porcentajeADevolver(unUsuario)
	}

	def double porcentajeADevolver(Usuario unUsuario) {
		if(this.estaCancelado || this.estaPostergado)
			1
		else if (this.diasfechaMaximaConfirmacion(unUsuario) < 7d && this.diasfechaMaximaConfirmacion(unUsuario) > 0) // falta el caso en el que quedan 0 dias 
			(this.diasfechaMaximaConfirmacion(unUsuario) + 1) * 0.1
		else
			0.8
	}

	override boolean esExitoso() { // Es un exito si quedan menos del 10% de entradas
		this.cantidadDisponibles <= this.cantidadExito
	}

	override double cantidadExito() {
		this.capacidadMaxima() * porcentajeExito
	}

	override esFracaso() {
		this.cantidadDisponibles > this.cantidadFracaso // es un fracaso si quedan mas del 50% de las entradas
	}

	override double cantidadFracaso() {
		this.capacidadMaxima() * porcentajeFracaso
	}
	def devolverValorEntradasAsistentes() {
		asistentes.forEach[usuario | this.devolverDinero(usuario)]
	}
	
	override cancelarEvento() {
		super.cancelarEvento
		this.devolverValorEntradasAsistentes
	}
	

}