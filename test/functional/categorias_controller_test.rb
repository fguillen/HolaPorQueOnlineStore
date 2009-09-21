require File.dirname(__FILE__) + '/../test_helper'
require 'categorias_controller'

class CategoriasController; def rescue_action(e) raise e end; end

class CategoriasControllerTest < Test::Unit::TestCase

  def setup
    @controller = CategoriasController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

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
