import java.time.LocalDateTime;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.uqbar.geodds.Point;

@SuppressWarnings("all")
public class Teste {
  private Evento fiesta;
  
  private Locacion estadio1;
  
  private Locacion estadio2;
  
  private LocalDateTime inicio = LocalDateTime.of(2018, 3, 27, 18, 0);
  
  private LocalDateTime hasta = LocalDateTime.of(2018, 3, 28, 1, 0);
  
  private LocalDateTime duracionEstimada = LocalDateTime.of(0, 0, 0, 7, 0);
  
  private Point puntocualquiera = new Point(2, 1);
  
  @Before
  public void init() {
    Evento _evento = new Evento("fest", this.inicio, this.hasta);
    this.fiesta = _evento;
    Point _point = new Point(1, 1);
    Locacion _locacion = new Locacion("obras", _point);
    this.estadio1 = _locacion;
    Point _point_1 = new Point(4, 2);
    Locacion _locacion_1 = new Locacion("geba", _point_1);
    this.estadio2 = _locacion_1;
  }
  
  @Test
  public void Probarduracion() {
    Assert.assertEquals(this.fiesta.duracion(), this.duracionEstimada);
  }
  
  @Test
  public void ProbarDistancia() {
    Assert.assertEquals(this.fiesta.distancia(this.puntocualquiera), 2.2, 0.1);
  }
}
