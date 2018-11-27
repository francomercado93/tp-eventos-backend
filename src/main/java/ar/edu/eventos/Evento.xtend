package ar.edu.eventos

import ar.edu.eventos.exceptions.BusinessException
import ar.edu.servicios.Servicio
import ar.edu.usuarios.Usuario
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.time.Duration
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import java.util.ArrayList
import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.geodds.Point

@Accessors
@Observable
abstract class Evento extends Entity {

	static String DATE_PATTERN = "yyyy/MM/dd HH:mm"
	static String DATE_PATTERNBACKEND = "dd/MM/yyyy HH:mm"
	@JsonIgnore Usuario organizador // doble referencia, asociacion
	String nombreEvento
	@JsonIgnore LocalDateTime inicioEvento
	@JsonIgnore LocalDateTime finEvento
	@JsonIgnore Locacion locacion
	@JsonIgnore LocalDateTime fechaMaximaConfirmacion
	@JsonIgnore LocalDateTime fechaCreacion
	@JsonIgnore boolean estaCancelado = false
	@JsonIgnore boolean estaPostergado = false
	@JsonIgnore Set<Servicio> serviciosContratados = new HashSet<Servicio>
	@JsonIgnore List<Usuario> asistentes = new ArrayList<Usuario>
	@JsonIgnore List<Artista> artistas = new ArrayList<Artista> // Solo los eventos abiertos pueden agregar artistas

	new() {
		initialize()
	}

	new(int id) {
		this.id = id
	}

	new(String nombreEvento, LocalDateTime inicio, LocalDateTime fin, LocalDateTime maximaConfirmacion,
		LocalDateTime creacion) {
		initialize()
//		this.locacion = locacion
		this.inicioEvento = inicio
		this.finEvento = fin
		this.fechaMaximaConfirmacion = maximaConfirmacion
		this.fechaCreacion = creacion
	}

	def initialize() {
		this.nombreEvento = ""
		this.inicioEvento = LocalDateTime.now
		this.finEvento = LocalDateTime.now
		this.fechaMaximaConfirmacion = LocalDateTime.now
		this.fechaCreacion = LocalDateTime.now
	}

	def asignarFechas(String fechaConfirmacion, String fechaInicio, String fechaFin, String fechaCreacion) {
		this.inicioEvento = LocalDateTime.parse(fechaInicio, formatterBackEnd)
		this.finEvento = LocalDateTime.parse(fechaFin, formatterBackEnd)
		this.fechaMaximaConfirmacion = LocalDateTime.parse(fechaConfirmacion, formatterBackEnd)
		this.fechaCreacion = LocalDateTime.parse(fechaCreacion, formatterBackEnd)
	}

	@JsonProperty("locacion")
	def getDescripcionLocacion() {
		locacion.descripcion
	}

	@JsonProperty("organizadorEvento")
	def getNombreUsuarioOrganizador() {
		organizador.nombreUsuario
	}

//	@JsonProperty("rechazados")
//	def Integer getRechazados()
//	@JsonProperty("fechaCreacion")
//	def getFechaCreacionAsString() {
//		formatter.format(this.fechaCreacion)
//	}
	@JsonProperty("fechaMaximaConfirmacion")
	def getFechaMaximaConfirmacionAsString() {
		formatter.format(this.fechaMaximaConfirmacion)
	}

	@JsonProperty("inicioEvento")
	def getInicioEventoAsString() {
		formatter.format(this.inicioEvento)
	}

	@JsonProperty("finEvento")
	def getFinEventoAsString() {
		formatter.format(this.finEvento)
	}

	def formatter() {
		DateTimeFormatter.ofPattern(DATE_PATTERN)
	}

	def formatterBackEnd() {
		DateTimeFormatter.ofPattern(DATE_PATTERNBACKEND)
	}

	def double porcentajeExito() {
		0.9
	}

	def double porcentajeFracaso() {
		0.5
	}

	def duracion() {
		Duration.between(inicioEvento, finEvento).getSeconds() / 3600d
	}

	def double distancia(Point unPunto) {
		locacion.distancia(unPunto)
	}

	def contratarServicio(Servicio servicio) {
		serviciosContratados.add(servicio)
	}

	def costoTotalEvento() {
		serviciosContratados.fold(0d, [acum, servicio|acum + servicio.costo(this)])
	}

	def boolean coherenciaFechas(LocalDateTime fecha1, LocalDateTime fecha2) {
		fecha1.isBefore(fecha2)
	}

	def validarCampos() {
		if (nombreEvento === null)
			throw new BusinessException("Falta nombre")
		if (locacion === null) {
			throw new BusinessException("Falta maxima de confirmacion")
		}
		this.validarFechas
		if (!this.coherenciaFechas(fechaMaximaConfirmacion, inicioEvento))
			throw new BusinessException(
				"La fecha maxima de confirmacion debe ser menor que la fecha de inicio del evento")
		if (!this.coherenciaFechas(inicioEvento, finEvento))
			throw new BusinessException("La fecha de inicio del evento debe ser menor a la de finalizacion")
	}

	def validarFechas() {
		if (fechaMaximaConfirmacion === null) {
			throw new BusinessException("Falta maxima de confirmacion")
		}
		if (inicioEvento === null) {
			throw new BusinessException("Falta fecha de inicio")
		}
		if (finEvento === null) {
			throw new BusinessException("Falta fin de evento")
		}
	}

	@JsonProperty("capacidadMaxima")
	def double capacidadMaxima()

	def boolean esExitoso()

	def double cantidadExito()

	def boolean esFracaso()

	def double cantidadFracaso()

	def diasfechaMaximaConfirmacion(Usuario unUsuario) {
		(Duration.between(unUsuario.fechaHoraActual, this.fechaMaximaConfirmacion)).getSeconds() / 86400
	}

	def cantidadDisponibles() { // Eventos abiertos => entradas, cerrados => invitaciones
		Math.round(this.capacidadMaxima() - this.cantidadAsistentesPosibles)
	}

//	@JsonProperty("cantidadAsistentesPosibles")
	def cantidadAsistentesPosibles() {
		if (this.asistentes.nullOrEmpty)
			return 0
		else
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
		unUsuario.fechaHoraActual.isBefore(this.fechaMaximaConfirmacion)
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

	def void setFechaCreacionyOrganizador(Usuario unUsuario) {
		fechaCreacion = unUsuario.fechaHoraActual
		organizador = unUsuario
	}

	def boolean estaInvitado(Usuario unUsuario) {
		asistentes.contains(unUsuario)
	}

	def boolean tipoUsuarioPuedeOrganizar() {
		true
	}

	def double cantidadEntradasVendidas() {
		0d
	}

	def cantidadTotalInvitaciones() {
		0
	}
}
