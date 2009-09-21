class CarritoController < ApplicationController
	layout 'tienda'
	
  def anadir
  	carrito = 
      Lineapedido.new( 
        params[:camisetaId], 
        params[:modelo], 
        params[:cantidad]
      )
    
  	if session[:carrito].nil?
  		session[:carrito] = [carrito]
  	else
  		session[:carrito] << carrito
  	end
  	
  	redirect_to :action => 'ver'
  end

  def actualizar
  	indice = params[:indice].to_i
  	cantidad = params[:cantidad].to_i
  	
    logger.debug( "cantidad:#{cantidad}" )
    
  	carrito = session[:carrito][indice]
  	carrito.setCantidad( cantidad )
  	
  	session[:carrito][indice] = carrito
  	
  	redirect_to :action => 'ver'
  end

  def borrar
  	@carrito = session[:carrito]
  	@carrito.delete_at( params[:indice].to_i )
  	
  	if @carrito.size == 0
  		session[:carrito] = nil
  	end
  	redirect_to :action => 'ver'
  end

  def vaciar
	  session[:carrito] = nil
	  
	  redirect_to :action => 'ver'
  end

  def ver
  	@carrito = session[:carrito]
  	if @carrito.nil?
  		redirect_to :action => 'esta_vacio'
  	end
  end

  def esta_vacio
  end
  
  def completar_pedido
  	@carrito = session[:carrito]
  	if @carrito.nil?
  		redirect_to :action => 'esta_vacio'
  	end
  end
  
  def enviar_pedido
  	@carrito = session[:carrito]
  	if @carrito.nil?
  		redirect_to :action => 'esta_vacio'
  	else
	  	@pedido = Pedido.new
	  	@pedido.usuarioNombre = params[:usuario]["nombre"]
     @pedido.usuarioDireccion = params[:usuario]["direccion"]
	  	@pedido.usuarioEmail = params[:usuario]["email"]
     @pedido.usuarioTelefono = params[:usuario]["telefono"]
	  	@pedido.usuarioComentario = params[:usuario]["comentario"]
		  @pedido.fecha = DateTime.now
      @pedido.esBroma = params[:pedido]["esBroma"]
      
      if @pedido.esBroma == nil
        @pedido.esBroma = 0
      end

	  	carritos = session[:carrito]
	  	
	  	subtotal = 0

		  @pedido.lineasPedido = ""
	  	for carrito in carritos
	  		subtotal = subtotal + (carrito.precio.to_i * carrito.cantidad.to_i)
	  		
  			@pedido.lineasPedido << carrito.desparsearLinea
	  	end
	  	
	  	@pedido.subtotal = subtotal
	  	@pedido.gastosEnvio = 10
	  	@pedido.total = @pedido.subtotal + @pedido.gastosEnvio
	  	
	  	@pedido.save
	  	
	  	#
	  	# enviar email
	  	#
     @host = request.host_with_port
	  	Notificacion.deliver_enviar_pedido( @pedido, @host )

		#
		# vaciar carrito
		# 
		session[:carrito] = nil
		redirect_to :controller => 'pedidos', :action => 'show', :id => @pedido.id
	end
  end  
  
  def precio ( camisetaId, modeloCamiseta )
  	@camiseta = Camiseta.find( camisetaId )
  	@precio = 0
  	for modelo in @camiseta.modelos
  		if modelo.index( modeloCamiseta ) == 0
  			@precio = Modelo.new(modelo).precio
  		end
  	end
  	@precio
  end  
end
