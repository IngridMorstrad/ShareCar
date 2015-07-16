require 'test_helper'

class LoansControllerTest < ActionController::TestCase

  def setup
    @user1 = users(:petr)
    @user2 = users(:sam)
    @loan = Loan.create(borrower_id: @user2.id, lender_id: @user1.id)
  end


  test "should get index" do
    cookies[:auth_token] = @user1.auth_token
    get :index
    assert_response :success
  end

  test "should get show" do
    cookies[:auth_token] = @user1.auth_token
    get :show, id: @loan.id
    assert_response :success
  end

  test "should get new" do
    cookies[:auth_token] = @user1.auth_token
    get :new
    assert_response :success
  end

  test "should get edit" do
    cookies[:auth_token] = @user1.auth_token
    get :edit, id: @loan.id
    assert_response :success
  end

  test "should delete" do
    cookies[:auth_token] = @user1.auth_token
    delete :delete, id: @loan.borrower_id
    assert_redirected_to loans_path
  end

end
