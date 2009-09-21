require File.dirname(__FILE__) + '/../test_helper'
require 'camisetas_controller'

# Re-raise errors caught by the controller.
class CamisetasController; def rescue_action(e) raise e end; end

class CamisetasControllerTest < Test::Unit::TestCase
  fixtures :camisetas

  def setup
    @controller = CamisetasController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = camisetas(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:camisetas)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:camiseta)
    assert assigns(:camiseta).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:camiseta)
  end

  def test_create
    num_camisetas = Camiseta.count

    post :create, :camiseta => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_camisetas + 1, Camiseta.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:camiseta)
    assert assigns(:camiseta).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Camiseta.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Camiseta.find(@first_id)
    }
  end
end
