class CategoriasController < ApplicationController
  
  def update
    File.open( "#{RAILS_ROOT}/config/categorias.txt", 'w' ) do |f|
      f.write params[:categorias]
    end
    
    @categorias = File.read( "#{RAILS_ROOT}/config/categorias.txt" )
    
    flash.now[:info] = "Se han actualizado las categorías"
    
    render :action => 'edit'
  end
  
  def edit
    @categorias = File.read( "#{RAILS_ROOT}/config/categorias.txt" )
  end
end
