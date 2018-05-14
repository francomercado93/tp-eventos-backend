# tp-eventos-2018-grupo-8

[![Build Status](https://travis-ci.org/uqbar-project/eg-lista-correo-xtend.svg?branch=master)](https://travis-ci.org/algo2-unsam/tp-eventos-2018-grupo-8/) [![Coverage Status](https://coveralls.io/repos/github/algo2-unsam/tp-eventos-2018-grupo-8//badge.svg?branch=master&service=github)](https://coveralls.io/github/algo2-unsam/tp-eventos-2018-grupo-8/?branch=master&service=github) 

Entrega 2

Servicios

Agregaremos la posibilidad de contratar servicios para los eventos. De los servicios nos
interesa su descripción (ej: “Candy Bar Willy Wonka”, “Catering Food Party”, “Animación Mago
Goma”), y su costo. También queremos saber el costo total de un evento, sumando el de cada
uno de sus servicios contratados.
Para saber el costo de un servicio debemos sumar la tarifa del servicio más el traslado. Existen
tres tipos de tarifa:
   ● Tarifa fija: El costo de un servicio con tarifa fija será siempre el mismo para cualquier
  evento.
  ● Tarifa por hora: El costo se calcula en función de la duración del evento. Pueden tener
  un costo mínimo fijo.
  ● Tarifa por persona: Se calcula en función de la cantidad de asistentes. Los servicios
  que usan esta tarifa tienen un costo mínimo que se calculará en base a un porcentaje
  de la máxima cantidad de posibles asistentes (capacidad máxima en ambos tipos de
  evento). Por ejemplo; el servicio “Candy Bar Willy Wonka” cobra, como mínimo, su tarifa
  por el 70% de la capacidad máxima del evento. Cada servicio que utiliza este tipo de
  tarifa, define ese porcentaje mínimo a cobrar.
  Para calcular el costo del traslado cada servicio define su tarifa por kilómetro y su ubicación.
  
Validaciones

Validación de eventos
Al crear un evento se deben validar las siguientes condiciones:
  ● Coherencia de fechas: La fecha máxima de confirmación debe ser menor a la fecha de
  inicio. La fecha/hora de fin debe ser mayor a la fecha/hora de inicio.
  ● Datos obligatorios:
    ○ Nombre/descripción
    ○ Fecha desde
    ○ Fecha hasta
    ○ Fecha máxima de confirmación
    ○ Locación
    
Validación de otras entidades
Al crear o editar un elemento, se debe chequear que sus datos obligatorios no sean nulos.
Datos obligatorios por entidad:
  ● Locación: latitud, longitud y descripción.
  ● Usuario: nombre de usuario, nombre y apellido, email, fecha de nacimiento y dirección.
  ● Servicio: descripción, ubicación y tarifa.
  
Excepciones
Para cada una de las validaciones anteriormente mencionadas, se pide lanzar una excepción
en caso de que no se cumplan.
Utilizar también excepciones para los casos en los que no se pueda realizar una acción, por
ejemplo:
  ● No se puede realizar una invitación porque se supera la capacidad máxima.
  ● No se puede crear un evento porque se supera la cantidad máxima de eventos a
  organizar por el usuario.
  ● No se puede aceptar una invitación porque ya pasó la fecha máxima de confirmación.
  Repositorios
  
Por cada una de las entidades Locación, Usuario y Servicio se pide crear un objeto Repositorio
que trabaje con una colección de objetos en memoria, y que implemente el siguiente
comportamiento:
  ● void create(T object): Agrega un nuevo objeto a la colección, y le asigna un
  identificador único (id). El identificador puede ser random (chequeando que no se repita)
  o autoincremental. En caso de que tenga errores de validación no debe ser agregado.
  ● void delete(T object): Elimina el objeto de la colección.
  ● void update(T object): Modifica el objeto dentro de la colección. En caso de que tenga
  errores de validación no debe actualizar. De no existir el objeto buscado, es decir, un
  objeto con ese id, se debe lanzar una excepción.
  ● T searchById(int id): Retorna el objeto cuyo id sea el recibido como parámetro.
  ● List<T> search(String value): Devuelve los objetos que coincidan con la búsqueda de
  acuerdo a los siguientes criterios:
    ● Locación: El valor de búsqueda debe coincidir parcialmente con la descripción.
    ● Usuario: El valor de búsqueda debe coincidir parcialmente con el nombre y/o
    apellido, o exactamente con el nombre de usuario.
    ● Servicio: El valor de búsqueda debe coincidir con el inicio de la descripción.
    
Actualizaciones

Debido a que nuestro sistema recibirá actualizaciones de datos periódicamente,
desarrollaremos un mecanismo que actualice nuestros repositorios en base a los datos
recibidos mediante interfaces con servicios externos.
Actualización de usuarios:
Al consultar el servicio de usuarios se recibirá como respuesta el listado actualizado de
usuarios en formato JSON1. En base a este listado, agregaremos a nuestro repositorio los
usuarios que no existan en el mismo y actualizaremos aquellos que hayan recibido
modificaciones. Para saber si el usuario existe o no en nuestro sistema tendremos en cuenta su
nombre de usaurio.
Por el momento no nos interesa cómo obtenemos el JSON, sólo su conversión a objetos de
nuestro dominio y la posterior creación/modificación de estos objetos en sus correspondientes
repositorios.
El JSON recibido tendrá el siguiente formato2:
1 JavaScript Object Notation es un formato de intercambio de datos más liviano que el XML. Para más información ver
http://es.wikipedia.org/wiki/JSON y http://www.json.org/
2 Parsers para JSON: http://eclipsesource.com/blogs/2013/04/18/minimal-json-parser-for-java/ ,
https://code.google.com/p/json-simple/wiki/DecodingExamples , entre otros.
3 de 7

[
{
"nombreUsuario" : "lucas_capo" ,
"nombreApellido" : "Lucas Lopez" ,
"email" : "lucas_93@hotmail.com" ,
"fechaNacimiento" : "15/01/1993" ,
"direccion" :{
"calle" : "25 de Mayo" ,
"numero" : 3918 ,
"localidad" : "San Martín" ,
"provincia" : "Buenos Aires" ,
"coordenadas" :{
"x" : -34.572224 ,
"y" : 58.535651
}
}
},
{
"nombreUsuario" : "martin1990" ,
"nombreApellido" : "Martín Varela" ,
"email" : "martinvarela90@yahoo.com" ,
"fechaNacimiento" : "18/11/1990" ,
"direccion" :{
"calle" : "Av. Triunvirato" ,
"numero" : 4065 ,
"localidad" : "CABA" ,
"provincia" : "" ,
"coordenadas" :{
"x" : -33.582360 ,
"y" : 60.516598
}
}
}
]

Actualización de locaciones:
De manera similar, contaremos con un servicio de actualización de locaciones. Para saber si
una locación existe o no en nuestro sistema tendremos en cuenta sus coordenadas.
Este servicio, al ser consultado, retornará un JSON en el siguiente formato:
[
{
"x" : -34.603759 ,
"y" : -58.381586 ,
"nombre" : "Salón El Abierto"
},
{
"x" : -34.572224 ,
"y" : -58.535651 ,
"nombre" : "Estadio Obras"
}
]

Actualización de servicios:
Por último, contaremos con un servicio de actualización de servicios (si, un servicio de
servicios). Para saber si un servicio existe o no en nuestro sistema tendremos en cuenta su
descripción. Al ser consultado, retornará un JSON en el siguiente formato:
[
{
"descripcion" : "Catering Food Party" ,
"tarifaServicio" :{
"tipo" : "TF" ,
"valor" : 5000.00
},
"tarifaTraslado" : 30.00 ,
"ubicacion" :{
"x" : -34.572224 ,
"y" : 58.535651
}
}
]

Según los distintos tipos de tarifa, los valores de “tarifaServicio” tendrán los siguientes
formatos:
Tarifa Fija:
{
"tipo" : "TF" ,
"valor" : 5000.00
}
Tarifa por Persona:
{
"tipo" : "TPP" ,
"valor" : 300.00 ,
"porcentajeParaMinimo" : 70
}
Tarifa por Hora:
{
"tipo" : "TPH" ,
"valor" : 1000.00 ,
"minimo" : 3500.00
}


Se pide:
1) Diseñar e implementar el modelo de objetos de dominio.
2) Diseñar e implementar los casos de prueba correspondientes.
a) Armar el juego de datos necesario para realizar las pruebas
b) Codificar los tests unitarios
3) Generar un tag llamado “Entrega-2” en el repositorio.
7 de 7
