package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.servicios.Servicios
import ar.edu.usuarios.Usuario
import java.time.Duration
import java.time.LocalDateTime
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
abstract class Evento {

	Usuario organizador
	String nombreEvento
	LocalDateTime inicioEvento
	LocalDateTime finEvento
	Locacion lugar
	LocalDateTime fechaMaximaConfirmacion
	LocalDateTime fechaCreacion
	Set<Servicios> serviciosContratados = newHashSet
	double porcentajeExito = 0.9
	double porcentajeFracaso = 0.5
	List<Usuario> asistentes = newArrayList
	boolean estaCancelado = false
	boolean estaPostergado = false

	def duracion() {
		Duration.between(inicioEvento, finEvento).getSeconds() / 3600d
	}

	def double distancia(Point unPunto) {
		lugar.distancia(unPunto)
	}
	
	def contratarServicio(Servicios servicio){
		serviciosContratados.add(servicio)
	}
	
	def costoTotalEvento(){
		serviciosContratados.fold(0d, [ acum, servicio | acum + servicio.costo(this) ])
	}
	
	def boolean validarFecha(LocalDateTime fecha1, LocalDateTime fecha2) {
		fecha1.isBefore(fecha2)
	}

	def validarCampos() {
		this.validarNombre()
		this.validarFechaInicio()
		this.validarFechaMaxima()
		this.validarFinEvento()
		this.validarLocacion
		this.validarFecha(fechaMaximaConfirmacion, inicioEvento)
		this.validarFecha(inicioEvento, finEvento)
	}

	def validarNombre() {
		if (nombreEvento === null) {
			throw new BusinessException("Falta nombre")
		}
	}

	def validarFechaInicio() {
		if (inicioEvento === null) {
			throw new BusinessException("Falta fecha de inicio")
		}
	}

	def validarFechaMaxima() {
		if (fechaMaximaConfirmacion === null) {
			throw new BusinessException("Falta maxima de confirmacion")
		}
	}

	def validarFinEvento() {
		if (finEvento === null) {
			throw new BusinessException("Falta fin de evento")
		}
	}

	def validarLocacion() {
		if (lugar === null) {
			throw new BusinessException("Falta maxima de confirmacion")
		}

	}

	def double capacidadMaxima()

	def boolean esExitoso()

	def double cantidadExito()

	def boolean esFracaso()

	def double cantidadFracaso()

	def diasfechaMaximaConfirmacion(Usuario unUsuario) {
		(Duration.between(unUsuario.fechaActual, this.fechaMaximaConfirmacion)).getSeconds() / 86400
	}

	def cantidadDisponibles() { // Eventos abiertos => entradas, cerrados => invitaciones
		Math.round(this.capacidadMaxima() - this.cantidadAsistentesPosibles)
	}

	def cantidadAsistentesPosibles() {
		asistentes.size
	}

	def void agregarUsuarioListaAsistentes(Usuario unUsuario) {
		asistentes.add(unUsuario)
	}

	def removerUsuario(Usuario unUsuario) { // Cuando se devuelve la entrada,
		asistentes.remove(unUsuario) // queda disponible para que un usuario pueda comprarla
	}

	def boolean cumpleCondiciones(Usuario unUsuario)

	def boolean usuarioEstaATiempo(Usuario unUsuario) {
		unUsuario.fechaActual.isBefore(this.fechaMaximaConfirmacion)
	}

	def void cancelarEvento() {
		estaCancelado = true
		this.notificarAsistentes
	}

	def void postergarEvento(LocalDateTime nuevaInicioEvento) {
		estaPostergado = true
		this.reprogramarEvento(nuevaInicioEvento)
		this.notificarAsistentes
	}

	def void reprogramarEvento(LocalDateTime nuevaInicioEvento) {
		finEvento = nuevaInicioEvento.plusSeconds(Duration.between(inicioEvento, finEvento).getSeconds)
		fechaMaximaConfirmacion = nuevaInicioEvento.plusSeconds(
			Duration.between(inicioEvento, fechaMaximaConfirmacion).getSeconds)
		inicioEvento = nuevaInicioEvento
	}

	def void notificarAsistentes() {
		asistentes.forEach[usuario|this.notificarUsuario(usuario)]
	}

	def void notificarUsuario(Usuario usuario) {
		if (this.estaCancelado)
			usuario.notificacionEventoCancelado
		else
			usuario.notificacionEventoPostergado(this)
	}

	def void settearVariables(Usuario unUsuario) {
		fechaCreacion = unUsuario.fechaActual
		organizador = unUsuario
	}

	def boolean estaInvitado(Usuario unUsuario) {
		asistentes.contains(unUsuario)
	}
}
