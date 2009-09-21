class Notificacion < ActionMailer::Base

  def enviar_pedido( pedido, host )
    @subject    = 'Notificacion#enviar_pedido'
    @body       = { :pedido => pedido, :host => host }
    @recipients = 'holaporque@holaporque.com', pedido.usuarioEmail
    @bcc        = 'fguillen.mail@gmail.com'
    @from       = 'tienda@holaporque.com'
    @content_type =  'text/html'
  end
end
