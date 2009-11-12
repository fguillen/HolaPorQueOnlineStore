class Notificacion < ActionMailer::Base

  def enviar_pedido( pedido, sent_on = Time.now )
    @subject    = 'Tu pedido de la tienda de Hola Por Que'
    @body       = { :pedido => pedido, :host => CONFIG[:host] }
    @recipients = 'holaporque@holaporque.com', pedido.usuarioEmail
    @bcc        = 'fguillen.mail@gmail.com'
    @from       = 'tienda@holaporque.com'
    @content_type =  'text/html'
    @sent_on    = sent_on
  end
end
