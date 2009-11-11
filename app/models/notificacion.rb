class Notificacion < ActionMailer::Base

  def enviar_pedido( pedido, host, sent_on = Time.now )
    @subject    = 'Notificacion#enviar_pedido'
    @body       = { :pedido => pedido, :host => host }
    @recipients = 'holaporque@holaporque.com', pedido.usuarioEmail
    @bcc        = 'fguillen.mail@gmail.com'
    @from       = 'tienda@holaporque.com'
    @content_type =  'text/html'
    @sent_on    = sent_on
  end
end
