import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.geodds.Point;

@SuppressWarnings("all")
public class Locacion {
  @Accessors
  private String nombre;
  
  @Accessors
  private Point puntoGeografico;
  
  public Locacion(final String _nombre, final Point _coordenada) {
    this.nombre = _nombre;
    this.puntoGeografico = _coordenada;
  }
  
  public double distancia(final Point unPunto) {
    return this.puntoGeografico.distance(unPunto);
  }
  
  @Pure
  public String getNombre() {
    return this.nombre;
  }
  
  public void setNombre(final String nombre) {
    this.nombre = nombre;
  }
  
  @Pure
  public Point getPuntoGeografico() {
    return this.puntoGeografico;
  }
  
  public void setPuntoGeografico(final Point puntoGeografico) {
    this.puntoGeografico = puntoGeografico;
  }
}
