require 'test_helper'

class CarsControllerTest < ActionController::TestCase

  def setup
    @car = cars(:camry)
    @user = users(:petr)
  end

  test "should get new" do
    cookies[:auth_token] = @user.auth_token
    get :new
    assert_response :success
  end

  test "should get edit" do
    cookies[:auth_token] = @user.auth_token
    owner = Owner.new(car_id: @car.id, user_id: @user.id)
    if !owner.save
      puts "NO OWNER SAVED BRO"
    end
    get :edit, id: @car.id
    assert_response :success
  end

  test "should get delete" do
    cookies[:auth_token] = @user.auth_token
    owner=Owner.new(car_id: @car.id, user_id: @user.id)
    if !owner.save
      puts "NO OWNER SAVED BRO"
    end
    get :delete, id: @car.id
    assert_response :success
  end

end
