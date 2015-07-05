require 'test_helper'

class LoansControllerTest < ActionController::TestCase
  test "should get index" do
    user=User.new(id:1,name:"venky",email:"blah@gmail.com",password:"papajohns",password_confirmation:"papajohns")
    if user.save
      cookies[:auth_token]=user.auth_token
    else
      puts "WTF BRO"
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
    loan=Loan.new(id:1)
    if !(loan.save)
      puts "LOAN NOT SAVED BRO"
    end
    get :show, id: loan.id
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
    loan=Loan.new(id:1)
    if !(loan.save)
      puts "LOAN NOT SAVED BRO"
    end
    get :edit, id: loan.id
    assert_response :success
  end

  test "should get delete" do
    user=User.new(id:1,name:"venky",email:"blah@gmail.com",password:"papajohns",password_confirmation:"papajohns")
    if user.save
      cookies[:auth_token]=user.auth_token
    else
      puts "WTF BRO"
    end
    loan=Loan.new(id:1)
    if !(loan.save)
      puts "LOAN NOT SAVED BRO"
    end
    get :delete, id: loan.id
    assert_response :success
  end

end
