package ar.edu.creditCard

import ar.edu.eventos.exceptions.BusinessException
import org.uqbar.ccService.CreditCard
import org.uqbar.ccService.CreditCardService

class PagoConTarjeta {
	CreditCard tarjeta
	CreditCardService servicioTarjeta 
	
	new(CreditCard unaTarjeta, CreditCardService unServicioTarjeta){
		tarjeta = unaTarjeta
		servicioTarjeta = unServicioTarjeta
	}
	
	def puedePagar(double valor ){
		if(servicioTarjeta.pay(tarjeta, valor).statusCode != 0)
			throw new BusinessException(servicioTarjeta.pay(tarjeta, valor).statusMessage)
	}
}