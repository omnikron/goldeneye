require 'test_helper'

class WeaponSetsControllerTest < ActionController::TestCase
  setup do
    @weapon_set = weapon_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weapon_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weapon_set" do
    assert_difference('WeaponSet.count') do
      post :create, weapon_set: {  }
    end

    assert_redirected_to weapon_set_path(assigns(:weapon_set))
  end

  test "should show weapon_set" do
    get :show, id: @weapon_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weapon_set
    assert_response :success
  end

  test "should update weapon_set" do
    patch :update, id: @weapon_set, weapon_set: {  }
    assert_redirected_to weapon_set_path(assigns(:weapon_set))
  end

  test "should destroy weapon_set" do
    assert_difference('WeaponSet.count', -1) do
      delete :destroy, id: @weapon_set
    end

    assert_redirected_to weapon_sets_path
  end
end
