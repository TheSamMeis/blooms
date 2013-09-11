require 'test_helper'

class RecurlyControllerTest < ActionController::TestCase
  test "should get billing" do
    get :billing
    assert_response :success
  end

  test "should get account" do
    get :account
    assert_response :success
  end

end
