class GastosEnvioController < ApplicationController
  
  def update
    
    backup = File.read( "#{RAILS_ROOT}/config/gastos_envio.txt" )
    
    File.open( "#{RAILS_ROOT}/config/gastos_envio.txt", 'w' ) do |f|
      f.write params[:gastos_envio]
    end
    
    @gastos_envio = File.read( "#{RAILS_ROOT}/config/gastos_envio.txt" )
    
    # check
    begin
      GastosEnvio.all
      
      flash.now[:info] = "Se han actualizado los gastos de envío"
      
    rescue Exception => e
      flash.now[:error] = "revisa bien esto que tiene algún error"
      
      File.open( "#{RAILS_ROOT}/config/gastos_envio.txt", 'w' ) do |f|
        f.write backup
      end
    end
    
    
    render :action => 'edit'
  end
  
  def edit
    @gastos_envio = File.read( "#{RAILS_ROOT}/config/gastos_envio.txt" )
  end
end