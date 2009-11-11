class PedidosController < ApplicationController
  
  
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


  def edit
    @pedido = Pedido.find(params[:id])
  end

  def update
    @pedido = Pedido.find(params[:id])
    if @pedido.update_attributes(params[:pedido])
      flash[:notice] = 'Pedido was successfully updated.'
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
    flash[:notice] = 'Email enviado'
    render :action => 'show'
  end
end
