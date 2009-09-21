class Pedido < ActiveRecord::Base
	def lineas_pedido_parseadas
		lineasPedidoParseadas = []
		for lineaPedido in lineasPedido.split(/\n/)
      logger.debug "lineaPedido: #{lineaPedido}"  
			lineasPedidoParseadas << Lineapedido.parsearLinea( lineaPedido )
		end
		lineasPedidoParseadas
	end
end
