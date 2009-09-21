class Lineapedido 
  def desparsearLinea
    ActiveRecord::Base.logger.debug "desparseando: cantidad: #{@cantidad}"
    
    lineaPedidoDesparseada = 
      "#{@camisetaId},#{@camisetaNombre},#{@camisetaModelo},#{@cantidad},#{@precio}\n"
      
    ActiveRecord::Base.logger.debug "lineaPedidoDesparseada: #{lineaPedidoDesparseada}"
    lineaPedidoDesparseada
  end

  def self.parsearLinea( lineaPedido )
    lineaPedidoParseada = 
      Lineapedido.new(
        lineaPedido.split(/,/)[0].strip,  #camisetaId
        lineaPedido.split(/,/)[2].strip,  #camisetaModelo
        lineaPedido.split(/,/)[3].strip   #cantidad
      )
      
    #
    # sobreescribir precio y nombre camiseta
    # para respetar el antiguo
    #
    lineaPedidoParseada.setCamisetaNombre( lineaPedido.split(/,/)[1].strip )
    lineaPedidoParseada.setPrecio( lineaPedido.split(/,/)[4].strip )
    
    lineaPedidoParseada
  end

  def initialize( camisetaId, camisetaModelo, cantidad )
    @camisetaId = camisetaId
    @camisetaNombre = Camiseta.find( camisetaId ).nombre
    @camisetaModelo = camisetaModelo
    @cantidad = cantidad
    @precio = calcularPrecio(camisetaId, camisetaModelo)
  end

	def setCantidad( cantidad )
    @cantidad = cantidad
    ActiveRecord::Base.logger.debug "cantidad:#{@cantidad}"
  end
	
	def camisetaId
		@camisetaId
	end
	
	def camisetaNombre
		@camisetaNombre
end

  def setCamisetaNombre( camisetaNombre )
    @camisetaNombre = camisetaNombre
  end
	
	def camisetaModelo
		@camisetaModelo
	end
	
	def cantidad
		@cantidad
	end
	
	def precio
		@precio
  end

  def setPrecio( precio )
    @precio = precio
  end
	
  def calcularPrecio ( camisetaId, modeloCamiseta )
    @camiseta = Camiseta.find( camisetaId )
    @precio = 0
    for modelo in @camiseta.modelos
      if modelo.index( modeloCamiseta ) == 0
        @precio = Modelo.new(modelo).precio
      end
    end
    @precio
  end  
  
	def total
		@precio.to_i * @cantidad.to_i
	end
end
