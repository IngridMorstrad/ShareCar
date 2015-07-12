require 'test_helper'

class CarsControllerTest < ActionController::TestCase

  def setup
    @car = cars(:camry)
    @user = users(:petr)
    @owner = Owner.create(car_id: @car.id, user_id: @user.id)
  end

  test "should get new" do
    cookies[:auth_token] = @user.auth_token
    get :new
    assert_response :success
  end

  test "should get edit" do
    cookies[:auth_token] = @user.auth_token
    get :edit, id: @car.id
    assert_response :success
  end

  test "should delete and redirect to cars path" do
    cookies[:auth_token] = @user.auth_token
    delete :delete, id: @car.id
    assert_redirected_to cars_path
  end

end
