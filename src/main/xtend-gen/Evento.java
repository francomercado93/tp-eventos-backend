import java.time.LocalDateTime;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.geodds.Point;

@SuppressWarnings("all")
public class Evento {
  @Accessors
  private String nombre;
  
  @Accessors
  private LocalDateTime fechaInicio;
  
  @Accessors
  private LocalDateTime fechaHasta;
  
  @Accessors
  private Locacion lugar;
  
  public Evento(final String _nombre, final LocalDateTime _fechaInicio, final LocalDateTime _fechaHasta) {
    this.nombre = _nombre;
    this.fechaInicio = _fechaInicio;
    this.fechaHasta = _fechaHasta;
  }
  
  public Object duracion() {
    return this.operator_minus(this.fechaHasta, this.fechaInicio);
  }
  
  public Object operator_minus(final LocalDateTime date1, final LocalDateTime date2) {
    return this.operator_minus(date1, date2);
  }
  
  public double distancia(final Point unPunto) {
    return this.lugar.distancia(unPunto);
  }
  
  @Pure
  public String getNombre() {
    return this.nombre;
  }
  
  public void setNombre(final String nombre) {
    this.nombre = nombre;
  }
  
  @Pure
  public LocalDateTime getFechaInicio() {
    return this.fechaInicio;
  }
  
  public void setFechaInicio(final LocalDateTime fechaInicio) {
    this.fechaInicio = fechaInicio;
  }
  
  @Pure
  public LocalDateTime getFechaHasta() {
    return this.fechaHasta;
  }
  
  public void setFechaHasta(final LocalDateTime fechaHasta) {
    this.fechaHasta = fechaHasta;
  }
  
  @Pure
  public Locacion getLugar() {
    return this.lugar;
  }
  
  public void setLugar(final Locacion lugar) {
    this.lugar = lugar;
  }
}
