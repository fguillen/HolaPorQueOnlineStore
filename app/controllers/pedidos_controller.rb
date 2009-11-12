class PedidosController < ApplicationController
  
  protect_from_forgery :except => [:notify]
  
  before_filter :usuario_autorizado, :only => [ :list, :edit, :update, :destroy ]

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @pedidos = Pedido.find(:all, :order => 'fecha DESC' )
  end
  

  def show
    @pedido = Pedido.find(params[:id])
  end
  
  def pagar
    @pedido = Pedido.find(params[:id])
  end


  def edit
    @pedido = Pedido.find(params[:id])
  end

  def update
    @pedido = Pedido.find(params[:id])
    if @pedido.update_attributes(params[:pedido])
      flash[:info] = 'Pedido was successfully updated.'
      redirect_to :action => 'show', :id => @pedido
    else
      render :action => 'edit'
    end
  end

  def destroy
    Pedido.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def enviar_email
    @pedido = Pedido.find(params[:id])
    @host = request.host_with_port
    Notificacion.deliver_enviar_pedido( @pedido, @host )
    flash[:info] = 'Email enviado'
    render :action => 'show'
  end
  
  # this is the IPN paypal action call
  def notify
    logger.info( "XXX: on notify" )
    logger.info( "params: #{params.inspect}" )
  
    @pedido = Pedido.find( params[:invoice] )
    record_not_found and return  if @pedido.nil?
    
    @pedido.paypal_notificate( params )
    
  
    render :nothing => true
  end

  
  # this is the return_url from Paypal
  def complete
    logger.info( "params: #{params.inspect}" )
    
    @pedido = Pedido.find( params[:invoice] || params[:id] )
    record_not_found and return  if @pedido.nil?
       
    # if @pedido.status == Pedido::STATUS[:ON_SESSION]
    #   # @pedido.update_attribute( :status, Pedido::STATUS[:NOT_NOTIFIED] )
    #   if @pedido.payment_type == 'transfer'
    #     @pedido.update_attribute(:status, Pedido::STATUS[:WAIT_TRANSFER])
    #   else
    #     @pedido.update_attribute( :status, Pedido::STATUS[:NOT_NOTIFIED] )
    #   end
    # end
    
    @pedido.update_attribute( :paypal_complete_params, params )
    
    
    if @pedido.estado == Pedido::STATUS[:COMPLETED]
      flash.now[:info] = 'El pago se ha realizado correctamente'

      #
      # vaciar carrito
      # 
      session[:carrito] = nil
    else
      flash.now[:error] = 'Algún problema ha ocurrido durante el pago, por favor contacta con nosotros.'
    end
    
    render :action => 'show'
  end
end
