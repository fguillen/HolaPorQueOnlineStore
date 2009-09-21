class CategoriasController < ApplicationController
  layout 'tienda'
  
  def update
    File.open( "#{RAILS_ROOT}/config/categorias.txt", 'w' ) do |f|
      f.write params[:categorias]
    end
    
    @categorias = File.read( "#{RAILS_ROOT}/config/categorias.txt" )
    
    render :action => 'edit'
  end
  
  def edit
    @categorias = File.read( "#{RAILS_ROOT}/config/categorias.txt" )
  end
end
