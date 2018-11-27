package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.usuarios.Usuario
import com.fasterxml.jackson.annotation.JsonIgnore
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class EventoAbierto extends Evento {
	static final double ESPACIONECESARIOPERSONA = 0.8

	int edadMinima
	double valorEntrada
	@JsonIgnore int entradasDevueltas

	new() {
		super()
		entradasDevueltas = 0
	}

	new(int id){
		super(id)
	}
//	override getRechazados() {
//		entradasDevueltas
//	}

	override capacidadMaxima() {
		locacion.calcularCapacidad(ESPACIONECESARIOPERSONA)
		locacion.capacidad
	}

	override boolean cumpleCondiciones(Usuario unUsuario) {
		(this.superaEdadMin(unUsuario) && this.cantidadDisponibles > 0 && this.usuarioEstaATiempo(unUsuario))
	}

	def boolean usuarioPuedeDevolverEntrada(Usuario usuario) {
		this.estaInvitado(usuario) && this.diasfechaMaximaConfirmacion(usuario) > 0
	}

	def boolean superaEdadMin(Usuario unUsuario) {
		unUsuario.edadUsuario >= this.edadMinima
	}

	override boolean esExitoso() {
		super.cantidadAsistentesPosibles >= this.cantidadExito
	}

	override double cantidadExito() {
		this.capacidadMaxima() * this.porcentajeExito
	}

	override esFracaso() {
		this.cantidadDisponibles > this.cantidadFracaso // es un fracaso si quedan mas del 50% de las entradas
	}

	override double cantidadFracaso() {
		this.capacidadMaxima() * this.porcentajeFracaso
	}

	override cancelarEvento() {
		super.cancelarEvento
		this.devolverValorEntradasAsistentes
	}

	def devolverValorEntradasAsistentes() {
		asistentes.forEach[usuario|this.devolverDinero(usuario)]
	}

	def devolverDinero(Usuario unUsuario) {
		unUsuario.sumarSaldoAFavor(this)
	}

	def double porcentajeADevolver(Usuario unUsuario) {
		if (this.estaCancelado || this.estaPostergado)
			1
		else if (this.diasfechaMaximaConfirmacion(unUsuario) < 7d)
			(this.diasfechaMaximaConfirmacion(unUsuario) + 1) * 0.1
		else
			0.8
	}

	def agregarArtista(Artista artista) {
		artistas.add(artista)
	}

	def eliminarArtista(String artista) {
		artistas.remove(artista)
	}

	override tipoUsuarioPuedeOrganizar() {
		false
	}

	def usuarioDevuelveEntrada(Usuario usuario) {
		if (!this.usuarioPuedeDevolverEntrada(usuario)) {
			throw new BusinessException("Error: usuario no puede devolver entrada")
		}
		this.devolverDinero(usuario)
		entradasDevueltas++
		this.removerUsuario(usuario)
	}

	override cantidadEntradasVendidas() {
		super.cantidadAsistentesPosibles()
	}
}
