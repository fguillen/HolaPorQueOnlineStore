# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Exception Notifier
  include ExceptionNotifiable
  # alias :rescue_action_locally :rescue_action_in_public
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '3cfd4b8a3899ad449c7ba0778115024f'
  
  def usuario_autorizado
    logger.debug "Comprobando permisos"
    
    unless session[:role] == 'admin'
      flash[:error] = 'Tienes que ser un administrador para entrar aquí.'
      redirect_to :controller => 'login'
      logger.warn "Usuario no autorizado intentando acción."
    end
    
  end
  
end
