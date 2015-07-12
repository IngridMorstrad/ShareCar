require 'test_helper'

class TripsControllerTest < ActionController::TestCase

  def setup
    @user = users(:petr)
    @car = cars(:camry)
    @trip=Trip.create(origin:"A",destination:"B",car_id:@car.id,start_time:"9:00",end_time:"10:00",distance:200.0,completed:false)
    @passenger=Passenger.create(trip_id:@trip.id,user_id:@user.id)
    @owner=Owner.create(car_id:@car.id,user_id:@user.id)
  end

  test "should get index" do
    cookies[:auth_token] = @user.auth_token
    get :index
    assert_response :success
  end

  test "should get show" do
    cookies[:auth_token] = @user.auth_token
    get :show, id: @trip.id
    assert_response :success
  end

  test "should get new" do
    cookies[:auth_token] = @user.auth_token
    get :new
    assert_response :success
  end

  test "should get edit" do
    cookies[:auth_token] = @user.auth_token
    get :edit, id: @trip.id
    assert_response :success
  end

  test "should get delete" do
    cookies[:auth_token] = @user.auth_token
    get :delete, id: @trip.id
    assert_response :success
  end

end
