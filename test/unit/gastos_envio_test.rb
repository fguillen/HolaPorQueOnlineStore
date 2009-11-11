require 'test_helper'

class GastosEnvioTest < ActiveSupport::TestCase
  def test_find
    File.open( "#{RAILS_ROOT}/config/gastos_envio.txt", 'w' ) do |f|
      f.write "pepe, 10\n"
      f.write "maria, 20\n"
      f.write "juan, 30\n"
    end
    
    assert_equal( 20, GastosEnvio.find( "maria" ).precio )
  end
end