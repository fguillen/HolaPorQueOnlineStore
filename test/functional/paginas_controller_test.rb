require 'test_helper'

class PaginasControllerTest < ActionController::TestCase
  
  def setup
    PaginasController.any_instance.stubs(:usuario_autorizado).returns(true)
  end
  
  test "should get index" do
    5.times{ Factory(:pagina) }
    get :index
    assert_response :success
    assert_equal( 5, assigns(:paginas).size )
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pagina" do
    assert_difference('Pagina.count') do
      post :create, :pagina => { :title => 'page title', :text => 'page text' }
    end

    assert_redirected_to pagina_path(assigns(:pagina))
  end

  test "should show pagina" do
    get :show, :id => Factory(:pagina).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => Factory(:pagina).to_param
    assert_response :success
  end

  test "should update pagina" do
    pagina = Factory(:pagina, :title => 'pagina title' )
    
    put :update, :id => pagina.to_param, :pagina => { :title => 'other title' }
    assert_redirected_to pagina_path(assigns(:pagina))
    
    pagina.reload
    assert_equal( 'other title', pagina.title )
  end

  test "should destroy pagina" do
    pagina = Factory(:pagina)
    assert_difference('Pagina.count', -1) do
      delete :destroy, :id => pagina.to_param
    end

    assert_redirected_to paginas_path
  end
  
  test "sort pages" do
    pagina_01 = Factory(:pagina, :position => '1' )
    pagina_02 = Factory(:pagina, :position => '2' )
    
    assert_equal( [pagina_01, pagina_02], Pagina.all )
    
    post(:sort, :paginas => [ pagina_02.id, pagina_01.id ] )
    
    assert_equal( [pagina_02, pagina_01], Pagina.all )
  end
end
