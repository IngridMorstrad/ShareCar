require 'test_helper'

class TripsControllerTest < ActionController::TestCase
  test "should get index" do
    user=User.new(id:1,name:"venky",email:"blah@gmail.com",password:"papajohns",password_confirmation:"papajohns")
    if user.save
      cookies[:auth_token]=user.auth_token
    else
      puts "WTF BRO"
    end
    car=Car.new(id:1,make:"2014",model:"Ezz",year:1995,seats:4,cost_per_mile:1.25)
    if !car.save
      puts "NO CAR SAVED BRO"
    end
    trip=Trip.new(id:1,origin:"A",destination:"B",car_id:1,start_time:"9:00",end_time:"10:00",distance:200.0,total_trip_cost:195.0)
    if !trip.save
      puts "TRIP NOT SAVED BRO"
    end
    get :index
    assert_response :success
  end

  test "should get show" do
    user=User.new(id:1,name:"venky",email:"blah@gmail.com",password:"papajohns",password_confirmation:"papajohns")
    if user.save
      cookies[:auth_token]=user.auth_token
    else
      puts "WTF BRO"
    end
    car=Car.new(id:1,make:"2014",model:"Ezz",year:1995,seats:4,cost_per_mile:1.25)
    if !car.save
      puts "NO CAR SAVED BRO"
    end
    trip=Trip.new(id:1,origin:"A",destination:"B",car_id:1,start_time:"9:00",end_time:"10:00",distance:200.0,total_trip_cost:195.0)
    if !trip.save
      puts "TRIP NOT SAVED BRO"
    end
    passenger=Passenger.new(trip_id:1,user_id:1)
    if !passenger.save
      puts "PASSENGER NOT SAVED BRO"
    end
    get :show, id: trip.id
    assert_response :success
  end

  test "should get new" do
    user=User.new(id:1,name:"venky",email:"blah@gmail.com",password:"papajohns",password_confirmation:"papajohns")
    if user.save
      cookies[:auth_token]=user.auth_token
    else
      puts "WTF BRO"
    end
    get :new
    assert_response :success
  end

  test "should get edit" do
    user=User.new(id:1,name:"venky",email:"blah@gmail.com",password:"papajohns",password_confirmation:"papajohns")
    if user.save
      cookies[:auth_token]=user.auth_token
    else
      puts "WTF BRO"
    end
    car=Car.new(id:1,make:"2014",model:"Ezz",year:1995,seats:4,cost_per_mile:1.25)
    if !car.save
      puts "NO CAR SAVED BRO"
    end
    trip=Trip.new(id:1,origin:"A",destination:"B",car_id:1,start_time:"9:00",end_time:"10:00",distance:200.0,total_trip_cost:195.0)
    if !trip.save
      puts "TRIP NOT SAVED BRO"
    end
    passenger=Passenger.new(trip_id:1,user_id:1)
    if !passenger.save
      puts "PASSENGER NOT SAVED BRO"
    end
    owner=Owner.new(car_id:1,user_id:1)
    if !owner.save
      puts "OWNER NOT SAVED BRO"
    end
    get :edit, id: trip.id
    assert_response :success
  end

  test "should get delete" do
    user=User.new(id:1,name:"venky",email:"blah@gmail.com",password:"papajohns",password_confirmation:"papajohns")
    if user.save
      cookies[:auth_token]=user.auth_token
    else
      puts "WTF BRO"
    end
    car=Car.new(id:1,make:"2014",model:"Ezz",year:1995,seats:4,cost_per_mile:1.25)
    if !car.save
      puts "NO CAR SAVED BRO"
    end
    trip=Trip.new(id:1,origin:"A",destination:"B",car_id:1,start_time:"9:00",end_time:"10:00",distance:200.0,total_trip_cost:195.0)
    if !trip.save
      puts "TRIP NOT SAVED BRO"
    end
    passenger=Passenger.new(trip_id:1,user_id:1)
    if !passenger.save
      puts "PASSENGER NOT SAVED BRO"
    end
    owner=Owner.new(car_id:1,user_id:1)
    if !owner.save
      puts "OWNER NOT SAVED BRO"
    end
    get :delete, id: trip.id
    assert_response :success
  end

end
