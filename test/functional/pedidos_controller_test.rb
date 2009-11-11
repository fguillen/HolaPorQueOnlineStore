require 'test_helper'

class PedidosControllerTest < ActionController::TestCase

  def test_list
    PedidosController.any_instance.expects(:usuario_autorizado).returns(true)
    
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:pedidos)
  end

  def test_show
    # PedidosController.any_instance.expects(:usuario_autorizado).returns(true)

    pedido = Factory(:pedido)
    
    get :show, :id => pedido.id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:pedido)
    assert assigns(:pedido).valid?
  end



  def test_edit
    PedidosController.any_instance.expects(:usuario_autorizado).returns(true)

    pedido = Factory(:pedido)
    
    get :edit, :id => pedido.id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:pedido)
    assert assigns(:pedido).valid?
  end

  def test_update
    PedidosController.any_instance.expects(:usuario_autorizado).returns(true)

    pedido = Factory(:pedido)
    
    post :update, :id => pedido.id
    
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => pedido.id
  end

  def test_destroy
    PedidosController.any_instance.expects(:usuario_autorizado).returns(true)

    pedido = Factory(:pedido)
    
    assert_nothing_raised {
      Pedido.find(pedido.id)
    }

    post :destroy, :id => pedido.id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Pedido.find(pedido.id)
    }
  end
end
