# Tp-eventos-backend
Cuenta con varios branchs donde cada uno es el backend de las distintas aplicaciones realizadas con los frameworks Arena, Angular y React.

Cómo levantar el servidor REST
Las opciones para probarlo (ya sea con POSTMAN o una aplicación cliente) son las siguientes:

desde el Eclipse, seleccionar EventosController.xtend y con botón derecho ejecutar la opción: Run As > Java Application
o bien desde la línea de comando (Git Bash o una terminal de Linux) ejecutar la siguiente instrucción

$ mvn clean compile assembly:single

Esto genera un jar, o archivo comprimido donde están los .class necesarios para levantar la aplicación. Luego escriben en la línea de comando

$ java -jar target/tareas-angular-xtrest-0.0.1-SNAPSHOT-jar-with-dependencies.jar

El nombre del jar puede variar, deben buscarlo en el directorio target del raíz. Entonces visualizarán en la consola el log del servidor levantado:

INFO  - log                        - Logging initialized @164ms
INFO  - Server                     - jetty-9.2.z-SNAPSHOT
INFO  - ServerConnector            - Started ServerConnector@4a831c6d{HTTP/1.1}{0.0.0.0:9000}
INFO  - Server                     - Started @611ms
Rutas
Una vez levantado el servidor, escriban la siguiente URL http://localhost:9000/ en su navegador preferido, que les mostrará la lista de rutas disponibles:
