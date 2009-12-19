require 'test_helper'

class CamisetasControllerTest < ActionController::TestCase


  def test_listar_todas
    get :listar_todas

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:camisetas)
  end

  def test_buscar_por_id
    camiseta = Factory(:camiseta)
    
    get :buscar_por_id, :id => camiseta.id

    assert_response :success
    assert_template 'listar'

    assert_not_nil assigns(:camisetas)
    assert_equal( camiseta, assigns(:camisetas).first )
  end

  def test_new
    CamisetasController.any_instance.expects(:usuario_autorizado).returns(true)
    
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:camiseta)
  end

  def test_create
    CamisetasController.any_instance.expects(:usuario_autorizado).returns(true)
    
    num_camisetas = Camiseta.count

    post :create, :camiseta => { :clave => 'wadus' }

    assert_response :redirect
    assert_redirected_to :action => 'buscar_por_id', :id => assigns(:camiseta).id

    assert_equal num_camisetas + 1, Camiseta.count
  end

  def test_edit
    CamisetasController.any_instance.expects(:usuario_autorizado).returns(true)

    get :edit, :id => Factory(:camiseta).id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:camiseta)
    assert assigns(:camiseta).valid?
  end

  def test_update
    CamisetasController.any_instance.expects(:usuario_autorizado).returns(true)

    camiseta = Factory(:camiseta)
    
    post :update, :id => camiseta.id
    assert_response :redirect
    assert_redirected_to :action => 'buscar_por_id', :id => camiseta.id
  end

  def test_destroy
    CamisetasController.any_instance.expects(:usuario_autorizado).returns(true)

    camiseta = Factory(:camiseta)
    
    assert_nothing_raised {
      Camiseta.find(camiseta.id)
    }

    post :destroy, :id => camiseta.id
    assert_response :redirect
    assert_redirected_to :action => 'listar_todas'

    assert_raise(ActiveRecord::RecordNotFound) {
      Camiseta.find(camiseta.id)
    }
  end
  
  def test_admin_index
    CamisetasController.any_instance.expects(:usuario_autorizado).returns(true)
    
    5.times{ Factory(:camiseta) }
    get(:admin_index)
    
    assert_response :success
    assert_equal( 5, assigns(:camisetas).size )
  end
  
  def test_sort
    CamisetasController.any_instance.expects(:usuario_autorizado).returns(true)
    
    camiseta_01 = Factory(:camiseta, :position => 1)
    camiseta_02 = Factory(:camiseta, :position => 2)
    
    assert_equal( [camiseta_01, camiseta_02], Camiseta.all )
    
    get( :sort, :camisetas_list => [camiseta_02.id, camiseta_01.id] )
    assert_response :success
    
    assert_equal( [camiseta_02, camiseta_01], Camiseta.all )
  end
end
