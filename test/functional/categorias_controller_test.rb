require 'test_helper'

class CategoriasControllerTest < ActionController::TestCase

  def test_update
    post(
      :update,
      :categorias => "pepe\nmaria\njuan"
    )
    
    assert_equal(
      ['pepe', 'maria', 'juan' ],
      File.read( "#{RAILS_ROOT}/config/categorias.txt" ).split("\n")
    )
  end
  
  def test_edit
    get( :edit )
    
    assert_equal( 
      File.read( "#{RAILS_ROOT}/config/categorias.txt" ), 
      assigns(:categorias)
    )
  end
end
