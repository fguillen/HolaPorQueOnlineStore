class CarritoController < ApplicationController
  
  def anadir
    carrito = 
      Lineapedido.new( 
        params[:camisetaId], 
        params[:modelo], 
        params[:cantidad]
      )
    
    if session[:carrito].nil?
      session[:carrito] = [carrito]
      session[:envio] = GastosEnvio.all.first
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
    
    @pedido = Pedido.new(:usuarioPais => 'España')
  end
  
  def enviar_pedido
    @carrito = session[:carrito]
    if @carrito.nil?
      redirect_to :action => 'esta_vacio'
    else
      @pedido = Pedido.new
      @pedido.usuarioNombre = params[:pedido][:usuarioNombre]
      @pedido.usuarioCiudad = params[:pedido][:usuarioCiudad]
      @pedido.usuarioPais = params[:pedido][:usuarioPais]
      @pedido.usuarioDireccion = params[:pedido][:usuarioDireccion]
      @pedido.usuarioEmail = params[:pedido][:usuarioEmail]
      @pedido.usuarioTelefono = params[:pedido][:usuarioEelefono]
      @pedido.usuarioComentario = params[:pedido][:usuarioComentario]
      @pedido.usuarioCp = params[:pedido][:usuarioCp]
      @pedido.mailing = params[:pedido][:mailing]

      
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
      
      @pedido.tipoEnvio = session[:envio].nombre
      @pedido.gastosEnvio = session[:envio].precio
      
      @pedido.total = @pedido.subtotal + @pedido.gastosEnvio
      
      if @pedido.save
        redirect_to :controller => 'pedidos', :action => 'pagar', :id => @pedido.id
      else
        flash.now[:error] = 'Algún error al rellenar el formulario de pedido'
        render :controller => 'carrito', :action => 'completar_pedido'
      end
    end
  end  
  
  def cambiar_tipo_envio
    session[:envio] = GastosEnvio.find( params[:tipo_envio].split(',')[0] )
    
    flash[:info] = "Tipo de envío actualizado"
    
    redirect_to :action => 'ver'
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
