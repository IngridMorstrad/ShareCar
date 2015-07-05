require 'test_helper'

class CarsControllerTest < ActionController::TestCase
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
    owner=Owner.new(car_id:1,user_id:1)
    if !owner.save
      puts "NO OWNER SAVED BRO"
    end
    get :edit, id: car.id
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
    owner=Owner.new(car_id:1,user_id:1)
    if !owner.save
      puts "NO OWNER SAVED BRO"
    end
    get :delete, id: car.id
    assert_response :success
  end

end
