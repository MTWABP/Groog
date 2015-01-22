require 'test_helper'

class SayingControllerTest < ActionController::TestCase
  test "should get hello" do
    get :hello
    assert_response :success
  end

  test "should get professor" do
    get :professor
    assert_response :success
  end

end
