class Notificacion < ActionMailer::Base

  def enviar_pedido( pedido, sent_on = Time.now )
    @subject    = 'Tu pedido de la tienda de Hola Por Que'
    @body       = { :pedido => pedido, :host => CONFIG[:host] }
    @recipients = pedido.usuarioEmail
    @bcc        = CONFIG[:admin_mails]
    @from       = CONFIG[:email_from]
    @content_type =  'text/html'
    @sent_on    = sent_on
  end
end
