class LoginController < ApplicationController
  
  def entrar
    nombre = params[:nombre]
    clave = params[:clave]
    
    logger.debug "login: #{nombre}, #{clave}"
    
    if nombre == CONFIG[:user] and clave == CONFIG[:pass]
      session[:role] = 'admin'
      flash[:info] = "Ahora eres un administrador"
      redirect_to :controller => 'camisetas', :action => 'listar_todas'
    else
      flash[:error] = "El nombre o la clave están mal."
      logger.warn "Autentificación errónea: #{nombre}, #{clave}"
      redirect_to :action => 'index'
    end
  end
  
  def salir
    session[:role] = nil
    flash[:info] = "Ya no eres un administrador"
    redirect_to :controller => 'camisetas', :action => 'listar_todas'
  end
end
