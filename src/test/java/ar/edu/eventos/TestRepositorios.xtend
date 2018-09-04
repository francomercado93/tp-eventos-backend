package ar.edu.eventos

import ar.edu.conversionActualizacion.ConversionJson
import ar.edu.eventos.exceptions.BusinessException
import ar.edu.main.StubUpdateService
import ar.edu.repositorios.RepositorioLocacion
import ar.edu.repositorios.RepositorioServicios
import ar.edu.repositorios.RepositorioUsuarios
import ar.edu.servicios.Servicio
import ar.edu.servicios.TarifaPersona
import ar.edu.servicios.TarifaPorHora
import ar.edu.usuarios.Usuario
import java.time.LocalDate
import java.time.LocalDateTime
import java.util.List
import org.junit.Assert
import org.junit.Test
import org.uqbar.geodds.Point

class TestRepositorios extends JuegoDatosTest{
	
	// ===============REPO USUARIO=============================
	@Test(expected=typeof(BusinessException))
	def void noSePuedeAgregarUsuarioNoValido() {
		var repo = new RepositorioUsuarios()
		repo.create(gaston)
	}

	@Test
	def void seAgregaUsuarioARepositorioYseAsignaId() {
		var repo = new RepositorioUsuarios()
		miriam.id = -1
		repo.create(miriam)
		println(repo.lista.get(0).nombreUsuario)
		Assert.assertEquals(0, miriam.id, 0)
		Assert.assertTrue(repo.lista.contains(miriam))
	}
	
	@Test
	def void pruebaBusquedaPorId() {
		var repo = new RepositorioUsuarios()
		miriam.id = -1
		lucas.id = -1
		agustin.id = -1
		repo.create(miriam)
		repo.create(lucas)
		repo.create(agustin)
		Assert.assertEquals(lucas, repo.searchById(1))
		Assert.assertEquals(miriam, repo.searchById(0))
		Assert.assertEquals(agustin, repo.searchById(2))
	}
	
	@Test
	def void busquedaPorString() {
		var repo = new RepositorioUsuarios()
		repo.create(martin)
		repo.create(marco)
		repo.create(lucas)
		repo.create(agustin)
		repo.create(agustina)
		var List<Usuario> result = repo.search("tin")
		result.forEach(usr | println(usr.nombreUsuario))
		Assert.assertEquals(3, result.size, 0.1)
	}
	
	@Test(expected=typeof(BusinessException))
	def void noSePuedeActualizarUsuarioQueNoExisteEnRepositorio() {
		var repo = new RepositorioUsuarios()
		repo.update(agustin)
	}
	
	@Test(expected=typeof(BusinessException))
	def void noSePuedeActualizarUsuarioNoValido() {
		var repo = new RepositorioUsuarios()
		repo.create(lucas)
		var nuevoLucas = new Usuario => [
			nombreUsuario = "Lucas41"
		]
		repo.update(nuevoLucas)
	}
	
	@Test
	def void noSeRepitenLosUsuariosDeUnaLista() {
		var repo = new RepositorioUsuarios()
		repo.create(lucas)
		var lucas2 = lucas
		repo.create(lucas2)
		Assert.assertEquals(1, repo.lista.size, 0.1)
	}

	@Test 
	def void pruebaUpdateRepoUsuario() {
		var repo = new RepositorioUsuarios()
		repo.create(lucas)
		repo.create(agustin)
		repo.create(agustina)
		repo.create(marco)
		var nuevoLucas = new Usuario => [
			nombreUsuario = "Lucas41"
			nombreApellido = "Lucas Benitez"
			mail = "lucasBenitez@gmail.com"	//CAMBIA EL MAIL
			setDireccion("Nogoya", 3460, "Villa del Parque", "CABA", new Point(-34.605375, -58.496150))
			fechaHoraActual = LocalDateTime.of(2018, 01, 31, 19, 50)
			fechaNacimiento = LocalDate.of(1991, 11, 11)
		]
		repo.update(nuevoLucas)
		Assert.assertEquals(nuevoLucas.mail, repo.search(lucas.nombreUsuario).get(0).mail)
		
	}
	
	//=========================REPO SERVICIO=================================
	
	@Test(expected=typeof(BusinessException))
	def void noSePuedeAgregarServicioNoValido() {
		var repo = new RepositorioServicios()
		var cateringPocha = new Servicio() => [
			descripcion = "catering Pocha"
		]
		repo.create(cateringPocha) // Le falta descripcion
	}
	
	@Test
	def void seAgregaServicioARepositorio() {
		var repo = new RepositorioServicios()
		repo.create(animacionMago)
		println(repo.lista.get(0).descripcion)
		Assert.assertTrue(repo.lista.contains(animacionMago))
	}
	
	@Test
	def void pruebaBusquedaPorIdServicios() {
		var repo = new RepositorioServicios()
		repo.create(cateringFoodParty)
		repo.create(animacionMago)
		repo.create(candyBarWillyWonka)
		Assert.assertEquals(candyBarWillyWonka, repo.searchById(2))
	}
	
	@Test
	def void busquedaPorStringServicios() {
		var repo = new RepositorioServicios()
		var cateringPocha =  new Servicio =>[
			descripcion = "Catering Pocha"
			tipoTarifa = new TarifaPersona(15, 0.8)
			tarifaPorKilometro = 5
			ubicacionServicio = new Point(-34.513628, -58.523435)
		]
		repo.create(cateringFoodParty)
		repo.create(animacionMago)
		repo.create(cateringPocha)
		repo.create(candyBarWillyWonka)
		var List<Servicio> result = repo.search("Catering")
		result.forEach(serv | println(serv.descripcion))
		Assert.assertEquals(2, result.size, 0.1)
	}
	
	@Test(expected=typeof(BusinessException))
	def void noSePuedeActualizarServicioQueNoExisteEnRepositorio() {
		var repo = new RepositorioServicios()
		var cervezaGratis = new Servicio()
		repo.update(cervezaGratis)
	}
	
	@Test
	def void noSeRepitenLosServiciosDeUnRepo() {
		var repo = new RepositorioServicios()
		repo.create(animacionMago)
		var animacionMagoB = animacionMago
		repo.create(animacionMagoB)
		Assert.assertEquals(1, repo.lista.size, 0.1)
	}

	@Test 
	def void pruebaUpdateRepoServicios() {
		var repo = new RepositorioServicios()
		repo.create(animacionMago)
		var animacionMagoBlack = new Servicio => [
			tipoTarifa = new TarifaPorHora(300, 12)
			descripcion = "Animacion Mago"
			tarifaPorKilometro = 15
			ubicacionServicio = new Point(-34.515938, -58.485094)
		]
		repo.update(animacionMagoBlack)
		Assert.assertEquals(animacionMagoBlack.tarifaPorKilometro, animacionMago.tarifaPorKilometro, 0.1)
	}
	
	//==================REPO LOCACIONES==================
	@Test(expected=typeof(BusinessException))
	def void noSePuedeAgregarLocacionNoValido() {
		var repo = new RepositorioLocacion()
		var sociedadFomento3dF = new Locacion() => [
			descripcion = "SociedadFomento3dF"
		]
		repo.create(sociedadFomento3dF) // Le falta coordenadas
	}
	
	@Test
	def void seAgregaLocacionARepositorio() {
		var repo = new RepositorioLocacion()
		repo.create(salonFiesta)
		repo.create(hipodromo)
		
		Assert.assertTrue(repo.lista.contains(salonFiesta))
		Assert.assertTrue(repo.lista.contains(hipodromo))
	}
 
	@Test
	def void pruebaBusquedaPorIdLocacion() {
		var repo = new RepositorioLocacion()
		repo.create(salonFiesta)
		repo.create(hipodromo)
		repo.create(tecnopolis)
		Assert.assertEquals(tecnopolis, repo.searchById(2))
		}
	
 	@Test
	def void busquedaPorStringLocacion() {
		var repo = new RepositorioLocacion()
		repo.create(salonFiesta)
		repo.create(hipodromo)
		repo.create(tecnopolis)
		repo.create(hipodromoPalermo)
		var List<Locacion> result = repo.search("po")
		result.forEach(loc | println(loc.descripcion))
		Assert.assertTrue(result.contains(tecnopolis))
		Assert.assertTrue(result.contains(hipodromo))
		Assert.assertTrue(result.contains(hipodromoPalermo))
		Assert.assertEquals(3, result.size, 0.1)
	}
	
	@Test(expected=typeof(BusinessException))
	def void noSePuedeActualizarLocacionQueNoExisteEnRepositorio() {
		var repo = new RepositorioLocacion()
		repo.update(hipodromo)
	}
	
	@Test(expected=typeof(BusinessException))
	def void noSePuedeActualizarLocacionNoValido() {
		var repo = new RepositorioLocacion()
		var sociedad3dF = new Locacion() => [
			descripcion = "Sociedad fomento 3 de Febrero"
		]
		repo.update(sociedad3dF)
	}
 	
	@Test
	def void noSeRepitenLocacionesDeUnaLista() {
		var repo = new RepositorioLocacion()
		repo.create(hipodromo)
		repo.create(hipodromo)
		Assert.assertEquals(1, repo.lista.size, 0.1)
	}

	@Test 
	def void pruebaUpdateRepoLocacion() {
		var repo =  new RepositorioLocacion()
		var sociedad3dF = new Locacion() => [
			descripcion = "Sociedad fomento 3 de Febrero"
			puntoGeografico = new Point(-34.567192, -58.538944)
			superficie = 50
		]
		repo.create(sociedad3dF)
		var sociedad3dFNuevo = new Locacion() => [
			descripcion = "Sociedad fomento 3 de Febrero"
			puntoGeografico = new Point(-35.567192, -60.538944)	//cambia la ubicacion
			superficie = 50
		]
		repo.update(sociedad3dFNuevo)
		Assert.assertEquals(sociedad3dF.puntoGeografico, sociedad3dFNuevo.puntoGeografico)
	}
	
	//CONVERSION JSON
	@Test
	def void pruebaJSONUsuario() {
		var main = new ConversionJson()
		var usuariosActualizados = new StubUpdateService
		main.conversionJsonAUsuarios(usuariosActualizados.getUserUpdates)
		main.usuarios.forEach(usuario | println("\nNombre usuario: "+ usuario.nombreUsuario+"\nNombre y apellido: "+
			 usuario.nombreApellido+"\nEmail: "+ usuario.mail+"\nFecha de nacimiento: "+ 
			 usuario.fechaNacimiento+"\nDireccion:\nCalle: "+usuario.direccion.calle +" "
			 +usuario.direccion.numero+"\nLocalidad: "+usuario.direccion.localidad+"\nProvincia: "+ 
			 usuario.direccion.provincia+"\nCoordenadas: "+usuario.direccion.coordenadas))
		Assert.assertEquals(3, main.usuarios.size, 0.1)
	}
	
	@Test
	def void pruebaJSONLocaciones() {
		var main = new ConversionJson()
		var locacionesActualizadas = new StubUpdateService
		main.conversionJsonLocaciones(locacionesActualizadas.getLocationUpdates)
		main.locaciones.forEach(locacion | println("\nNombre: "+locacion.descripcion+"\nCoordenadas :"+locacion.puntoGeografico))
		Assert.assertEquals(3, main.locaciones.size, 0.1)
	}
	
	@Test
	def void pruebaJSONServicios() {
		var main = new ConversionJson()
		var serviciosActualizados = new StubUpdateService
		main.conversionJsonServicios(serviciosActualizados.getServiceUpdates)
		main.servicios.forEach(servicio | println("\nDescripcion: "+servicio.descripcion+"\nCoordenadas :"
			+servicio.ubicacionServicio+"\nTipo tarifa: "+servicio.tipoTarifa.class+"\nValor: "
			+ servicio.tipoTarifa.costoFijo+"\nTarifa de traslado: "+servicio.tarifaPorKilometro))
		Assert.assertEquals(2, main.servicios.size, 0.1)
	}
	
	//=======ENTREGA 3====================================

	@Test
	def void pruebaUpdateAllUsuarios() {
		var repo = new RepositorioUsuarios()
		repo.updateService = new StubUpdateService
		repo.create(agustin)
		repo.create(agustina)
		repo.create(lucas)
		repo.create(miriam)
		println("==========Repo sin actualizar================")
		repo.lista.forEach(usuario | println("\nNombre usuario: "+ usuario.nombreUsuario+"\nEmail: "+ usuario.mail))
		repo.updateAll()	//Actualiza usuario agustin y agrega dos usuarios mas
		println("\n===============Repo actualizado==========")
		repo.lista.forEach(usuario | println("\nNombre usuario: "+ usuario.nombreUsuario+"\nEmail: "+ usuario.mail))
		Assert.assertEquals(6, repo.lista.size, 0.1)
	}
	
	@Test
	def void pruebaUpdateAllServicios() {
		var repo = new RepositorioServicios()
		repo.updateService = new StubUpdateService
		repo.create(animacionMago)
		repo.create(cateringFoodParty)
		repo.create(candyBarWillyWonka)
		println("==========Repo sin actualizar================")
		repo.lista.forEach(servicio | println("\nDescripcion: "+servicio.descripcion+"\nCoordenadas :"
			+servicio.ubicacionServicio+"\nTipo tarifa: "+servicio.tipoTarifa.class+"\nValor: "
			+ servicio.tipoTarifa.costoFijo+"\nTarifa de traslado: "+servicio.tarifaPorKilometro))
		repo.updateAll()//Actualiza el tipo de tarifa de catering food party y agrega nuevos servicios al repositorio
		println("\n===============Repo actualizado==========")
		repo.lista.forEach(servicio | println("\nDescripcion: "+servicio.descripcion+"\nCoordenadas :"
			+servicio.ubicacionServicio+"\nTipo tarifa: "+servicio.tipoTarifa.class+"\nValor: "
			+ servicio.tipoTarifa.costoFijo+"\nTarifa de traslado: "+servicio.tarifaPorKilometro))
		Assert.assertEquals(4, repo.lista.size, 0.1)
	}
	
	@Test
	def void pruebaUpdateAllLocaciones() {
		var repo = new RepositorioLocacion()
		repo.updateService = new StubUpdateService
		repo.create(tecnopolis)
		repo.create(hipodromo)
		repo.create(hipodromoPalermo)
		repo.create(salonFiesta)
		println("==========Repo sin actualizar================")
		repo.lista.forEach(locacion | println("\nDescripcion: "+locacion.descripcion+"\nCoordenadas :"
			+locacion.puntoGeografico))
		repo.updateAll()//Actualiza las coordenadas del salon de Fiesta y agrega los nuevos datos
		println("\n===============Repo actualizado==========")
		repo.lista.forEach(locacion | println("\nDescripcion: "+locacion.descripcion+"\nCoordenadas :"
			+locacion.puntoGeografico))
		Assert.assertEquals(6, repo.lista.size, 0.1)
	 }
 }