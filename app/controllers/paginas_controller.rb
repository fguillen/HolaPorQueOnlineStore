class PaginasController < ApplicationController
  
  before_filter :usuario_autorizado, :except => [ :show ]
    
  def index
    @paginas = Pagina.all
  end

  def show
    @pagina = Pagina.find(params[:id])
  end

  def new
    @pagina = Pagina.new
  end

  def edit
    @pagina = Pagina.find(params[:id])
  end

  def create
    @pagina = Pagina.new(params[:pagina])

    if @pagina.save
      flash[:notice] = 'Pagina was successfully created.'
      redirect_to(@pagina)
    else
      render :action => "new"
    end
  end

  def update
    @pagina = Pagina.find(params[:id])

    if @pagina.update_attributes(params[:pagina])
      flash[:notice] = 'Pagina was successfully updated.'
      redirect_to(@pagina)
    else
      render :action => "edit"
    end
  end

  def destroy
    @pagina = Pagina.find(params[:id])
    @pagina.destroy

    redirect_to(paginas_url)
  end
  
  def sort
    params[:paginas].each_with_index do |id, index|  
      Pagina.find( id ).update_attribute( :position, index+1 )
    end  
    render :nothing => true
  end
end
