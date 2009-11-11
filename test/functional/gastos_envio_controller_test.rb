require 'test_helper'

class GastosEnvioControllerTest < ActionController::TestCase

  def test_update
    random_price = rand(100)
    
    post(
      :update,
      :gastos_envio => "pepe,#{random_price}\nmaria,30\njuan,40"
    )
    
    assert_equal( 3, GastosEnvio.all.size )
    assert_equal( 'pepe', GastosEnvio.all[0].nombre )
    assert_equal( random_price, GastosEnvio.all[0].precio )
    assert_nil( flash[:error] )
  end
  
  def test_update_with_error
    random_price = rand(100)
    
    post(
      :update,
      :gastos_envio => "pepe,#{random_price}\nmaria\njuan,40"
    )
    
    assert_not_nil( flash[:error] )
  end

  def test_edit
    get( :edit )
    
    assert_equal( 
      File.read( "#{RAILS_ROOT}/config/gastos_envio.txt" ), 
      assigns(:gastos_envio)
    )
  end
end
