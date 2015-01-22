require 'test_helper'

class DavidControllerTest < ActionController::TestCase
  test "should get hello" do
    get :hello
    assert_response :success
  end

  test "should get Yu" do
    get :Yu
    assert_response :success
  end

  test "should get Sun" do
    get :Sun
    assert_response :success
  end

  test "should get goodbye" do
    get :goodbye
    assert_response :success
  end

end
