require 'test_helper'

class LoansControllerTest < ActionController::TestCase

  def setup
    @user = users(:petr)
  end


  test "should get index" do
    cookies[:auth_token] = @user.auth_token
    get :index
    assert_response :success
  end

  test "should get show" do
    cookies[:auth_token] = @user.auth_token
    loan=Loan.new(id:1)
    if !(loan.save)
      puts "LOAN NOT SAVED BRO"
    end
    get :show, id: loan.id
    assert_response :success
  end

  test "should get new" do
    cookies[:auth_token] = @user.auth_token
    get :new
    assert_response :success
  end

  test "should get edit" do
    cookies[:auth_token] = @user.auth_token
    loan=Loan.new(id:1)
    if !(loan.save)
      puts "LOAN NOT SAVED BRO"
    end
    get :edit, id: loan.id
    assert_response :success
  end

  test "should get delete" do
    cookies[:auth_token] = @user.auth_token
    loan=Loan.new(id:1)
    if !(loan.save)
      puts "LOAN NOT SAVED BRO"
    end
    get :delete, id: loan.id
    assert_response :success
  end

end
