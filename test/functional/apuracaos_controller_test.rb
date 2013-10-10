require 'test_helper'

class ApuracaosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:apuracaos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create apuracao" do
    assert_difference('Apuracao.count') do
      post :create, :apuracao => { }
    end

    assert_redirected_to apuracao_path(assigns(:apuracao))
  end

  test "should show apuracao" do
    get :show, :id => apuracaos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => apuracaos(:one).to_param
    assert_response :success
  end

  test "should update apuracao" do
    put :update, :id => apuracaos(:one).to_param, :apuracao => { }
    assert_redirected_to apuracao_path(assigns(:apuracao))
  end

  test "should destroy apuracao" do
    assert_difference('Apuracao.count', -1) do
      delete :destroy, :id => apuracaos(:one).to_param
    end

    assert_redirected_to apuracaos_path
  end
end
