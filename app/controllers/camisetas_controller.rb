class CamisetasController < ApplicationController
  layout 'tienda'

  before_filter :usuario_autorizado, :only => [ :new, :create, :edit, :update, :destroy ]

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }


  
  
  def listar_todas
  	logger.debug("listando las camisetas")
    @camisetas = Camiseta.find(:all)
    render :action => 'listar'
  end

  def buscar_por_id
  	@camisetas = Array.new
    @camisetas << Camiseta.find(params[:id])
    render :action => 'listar'

  end
  
  def buscar_por_categoria
    @camisetas = Camiseta.find(:all, :conditions => "categorias like '%#{params[:categoria]}%'" )
    render :action => 'listar'
  end
  
  def buscar_por_nombre
    @camisetas = Camiseta.find(:all, :conditions => "nombre like '%#{params[:nombre]}%'" )
    render :action => 'listar'
  end

  def new
    @camiseta = Camiseta.new
  end

  def create
    @camiseta = Camiseta.new(params[:camiseta])
    if @camiseta.save
      flash[:notice] = 'Ya has creado una nueva camiseta.'
      redirect_to :action => 'buscar_por_id', :id => @camiseta.id
    else
	  flash[:error] = 'Error al guardar la camiseta.'
      render :action => 'new'
    end
  end

  def edit
    @camiseta = Camiseta.find(params[:id])
  end

  def update
    @camiseta = Camiseta.find(params[:id])
    if @camiseta.update_attributes(params[:camiseta])
      flash[:notice] = 'La camiseta se actualizó correctamente.'
      redirect_to :action => 'buscar_por_id', :id => @camiseta.id
    else
	  flash[:error] = 'Error al actualizar la camiseta.'
      render :action => 'edit'
    end
  end

  def destroy
    Camiseta.find(params[:id]).destroy
    redirect_to :action => 'listar_todas'
  end
  
  def portada
   @camisetas = Camiseta.find(:all)
  end
  

end
