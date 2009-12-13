require File.dirname(__FILE__) + '/../test_helper'

class NotificacionTest < Test::Unit::TestCase
  FIXTURES_PATH = File.dirname(__FILE__) + '/../fixtures'
  CHARSET = "utf-8"

  include ActionMailer::Quoting

  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @expected = TMail::Mail.new
    @expected.set_content_type "text", "plain", { "charset" => CHARSET }
    @expected.mime_version = '1.0'
  end

  def test_enviar_pedido
    pedido = Factory(:pedido, :fecha => Time.parse( '2000/01/01 10:10:10 UTC' ) )
    
    @expected.subject       = 'Tu pedido de la tienda de Hola Por Que'
    @expected.body          = read_fixture('enviar_pedido.html')
    @expected.to            = pedido.usuarioEmail
    @expected.bcc           = CONFIG[:admin_mails]
    @expected.from          = CONFIG[:email_from]
    @expected.content_type  = 'text/html; charset=utf-8'
    @expected.date          = Time.now
    
    mail = Notificacion.create_enviar_pedido(pedido, @expected.date )

    assert_equal( @expected.encoded, mail.encoded )
  end

  private
    def read_fixture(action)
      IO.readlines("#{FIXTURES_PATH}/notificacion/#{action}")
    end

    def encode(subject)
      quoted_printable(subject, CHARSET)
    end
end
